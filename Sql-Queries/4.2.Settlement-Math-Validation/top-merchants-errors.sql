-- 4.2.10 Settlement Math Validation - Top Merchants with Commission Errors
USE KoboFintech;
GO

WITH RecentTransactions AS (
    SELECT TOP 1000 
        tl.WalletID,
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
    m.BusinessName,
    COUNT(*) AS TransactionsWithError,
    SUM(ABS(tl.CommissionAmount - (tl.Amount * c.CommissionPercentage / 100.0))) AS TotalErrorAmount
FROM RecentTransactions tl
INNER JOIN Wallets w ON tl.WalletID = w.WalletID
INNER JOIN Merchants m ON w.UserID = m.UserID
INNER JOIN Commissions c ON tl.ProductID = c.ProductID 
    AND tl.EffectiveTier = c.MerchantTier 
    AND c.IsActive = 1
WHERE ABS(tl.CommissionAmount - (tl.Amount * c.CommissionPercentage / 100.0)) > 0.01
GROUP BY m.BusinessName
ORDER BY TotalErrorAmount DESC;