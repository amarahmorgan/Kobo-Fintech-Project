-- 4.2.03 Settlement Math Validation - Mismatches by Merchant Tier
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
    r.EffectiveTier,
    COUNT(*) AS TotalTransactions,
    SUM(CASE WHEN ABS(r.CommissionAmount - (r.Amount * c.CommissionPercentage / 100.0)) > 0.01 THEN 1 ELSE 0 END) AS Mismatches,
    ROUND(100.0 * SUM(CASE WHEN ABS(r.CommissionAmount - (r.Amount * c.CommissionPercentage / 100.0)) > 0.01 THEN 1 ELSE 0 END) 
          / NULLIF(COUNT(*), 0), 2) AS MismatchPercentage
FROM RecentTransactions r
INNER JOIN Commissions c ON r.ProductID = c.ProductID 
    AND r.EffectiveTier = c.MerchantTier 
    AND c.IsActive = 1
GROUP BY r.EffectiveTier
ORDER BY MismatchPercentage DESC;