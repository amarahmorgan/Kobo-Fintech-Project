-- 4.2.01 Settlement Math Validation - Mismatches in Most Recent 1,000 Transactions
-- Verifies if the applied CommissionAmount matches the correct percentage from Commissions table
USE KoboFintech;
GO

WITH RecentTransactions AS (
    SELECT TOP 1000 
        tl.EntryID,
        tl.WalletID,
        tl.ProductID,
        tl.Amount,
        tl.CommissionAmount,
        COALESCE(m.MerchantTier, 'Standard') AS EffectiveTier,
        u.FullName,
        u.Role
    FROM TransactionLedger tl
    INNER JOIN Wallets w ON tl.WalletID = w.WalletID
    INNER JOIN Users u ON w.UserID = u.UserID
    LEFT JOIN Merchants m ON u.UserID = m.UserID
    ORDER BY tl.CreatedTimestamp DESC
)
SELECT 
    r.EntryID,
    r.FullName,
    r.EffectiveTier,
    p.Description AS Product,
    r.Amount,
    r.CommissionAmount AS AppliedCommission,
    c.CommissionPercentage,
    ROUND(r.Amount * c.CommissionPercentage / 100.0, 2) AS ExpectedCommission,
    ABS(r.CommissionAmount - ROUND(r.Amount * c.CommissionPercentage / 100.0, 2)) AS Difference
FROM RecentTransactions r
INNER JOIN Products p ON r.ProductID = p.ProductID
INNER JOIN Commissions c ON r.ProductID = c.ProductID 
    AND r.EffectiveTier = c.MerchantTier
    AND c.IsActive = 1
WHERE ABS(r.CommissionAmount - ROUND(r.Amount * c.CommissionPercentage / 100.0, 2)) > 0.01
ORDER BY Difference DESC;