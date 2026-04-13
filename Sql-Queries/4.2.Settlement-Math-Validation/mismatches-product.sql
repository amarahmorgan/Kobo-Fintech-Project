-- 4.2.04 Settlement Math Validation - Mismatches by Product
USE KoboFintech;
GO

WITH RecentTransactions AS (
    SELECT TOP 1000 
        tl.Amount,
        tl.CommissionAmount,
        COALESCE(m.MerchantTier, 'Standard') AS EffectiveTier,
        tl.ProductID
    FROM TransactionLedger tl
    INNER JOIN Wallets w ON tl.WalletID = w.WalletID
    LEFT JOIN Merchants m ON w.UserID = m.UserID
    ORDER BY tl.CreatedTimestamp DESC
)
SELECT 
    p.Description,
    COUNT(*) AS TotalTransactions,
    SUM(CASE WHEN ABS(r.CommissionAmount - (r.Amount * c.CommissionPercentage / 100.0)) > 0.01 THEN 1 ELSE 0 END) AS Mismatches
FROM RecentTransactions r
INNER JOIN Products p ON r.ProductID = p.ProductID
INNER JOIN Commissions c ON r.ProductID = c.ProductID 
    AND r.EffectiveTier = c.MerchantTier 
    AND c.IsActive = 1
GROUP BY p.Description
ORDER BY Mismatches DESC;