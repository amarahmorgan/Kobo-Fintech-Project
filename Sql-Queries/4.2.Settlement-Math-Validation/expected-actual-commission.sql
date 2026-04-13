-- 4.2.06 Settlement Math Validation - Expected vs Actual Commission (Top mismatches)
USE KoboFintech;
GO

WITH RecentTransactions AS (
    SELECT TOP 200 
        tl.EntryID,
        tl.Amount,
        tl.CommissionAmount,
        COALESCE(m.MerchantTier, 'Standard') AS EffectiveTier,
        p.Description
    FROM TransactionLedger tl
    INNER JOIN Wallets w ON tl.WalletID = w.WalletID
    LEFT JOIN Merchants m ON w.UserID = m.UserID
    INNER JOIN Products p ON tl.ProductID = p.ProductID
    ORDER BY tl.CreatedTimestamp DESC
)
SELECT 
    r.EntryID,
    r.Description,
    r.EffectiveTier,
    r.Amount,
    r.CommissionAmount AS AppliedCommission,
    ROUND(r.Amount * c.CommissionPercentage / 100.0, 2) AS ExpectedCommission,
    ROUND(ABS(r.CommissionAmount - (r.Amount * c.CommissionPercentage / 100.0)), 2) AS Difference
FROM RecentTransactions r
INNER JOIN Commissions c ON r.ProductID = c.ProductID 
    AND r.EffectiveTier = c.MerchantTier 
    AND c.IsActive = 1
WHERE ABS(r.CommissionAmount - (r.Amount * c.CommissionPercentage / 100.0)) > 0.01
ORDER BY Difference DESC;