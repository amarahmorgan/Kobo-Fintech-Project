-- 4.2.11 Settlement Math Validation - Accuracy Trend by Month
USE KoboFintech;
GO

SELECT 
    YEAR(tl.CreatedTimestamp) AS TransactionYear,
    MONTH(tl.CreatedTimestamp) AS TransactionMonth,
    COUNT(*) AS TotalTransactions,
    ROUND(AVG(CASE WHEN ABS(tl.CommissionAmount - (tl.Amount * c.CommissionPercentage / 100.0)) <= 0.01 
                   THEN 100.0 ELSE 0 END), 2) AS AccuracyPercentage
FROM TransactionLedger tl
INNER JOIN Wallets w ON tl.WalletID = w.WalletID
LEFT JOIN Merchants m ON w.UserID = m.UserID
INNER JOIN Commissions c ON tl.ProductID = c.ProductID 
    AND COALESCE(m.MerchantTier, 'Standard') = c.MerchantTier 
    AND c.IsActive = 1
GROUP BY YEAR(tl.CreatedTimestamp), MONTH(tl.CreatedTimestamp)
ORDER BY TransactionYear DESC, TransactionMonth DESC;