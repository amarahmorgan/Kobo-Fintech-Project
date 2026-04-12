-- 4.2.05 Settlement Math Validation - Mismatches by Service Provider
USE KoboFintech;
GO

WITH RecentTransactions AS (
    SELECT TOP 1000 
        tl.Amount,
        tl.CommissionAmount,
        COALESCE(m.MerchantTier, 'Standard') AS EffectiveTier,
        p.ProviderID
    FROM TransactionLedger tl
    INNER JOIN Wallets w ON tl.WalletID = w.WalletID
    LEFT JOIN Merchants m ON w.UserID = m.UserID
    INNER JOIN Products p ON tl.ProductID = p.ProductID
    ORDER BY tl.CreatedTimestamp DESC
)
SELECT 
    sp.ProviderName,
    COUNT(*) AS TotalTransactions,
    SUM(CASE WHEN ABS(r.CommissionAmount - (r.Amount * c.CommissionPercentage / 100.0)) > 0.01 THEN 1 ELSE 0 END) AS Mismatches
FROM RecentTransactions r
INNER JOIN ServiceProviders sp ON r.ProviderID = sp.ProviderID
INNER JOIN Commissions c ON r.ProductID = c.ProductID 
    AND r.EffectiveTier = c.MerchantTier 
    AND c.IsActive = 1
GROUP BY sp.ProviderName
ORDER BY Mismatches DESC;