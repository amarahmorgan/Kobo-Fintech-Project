-- 4.2.14 Settlement Math Validation - Premium Tier Specific Validation
USE KoboFintech;
GO

WITH PremiumTx AS (
    SELECT tl.Amount, tl.CommissionAmount, tl.ProductID
    FROM TransactionLedger tl
    INNER JOIN Wallets w ON tl.WalletID = w.WalletID
    INNER JOIN Merchants m ON w.UserID = m.UserID
    WHERE m.MerchantTier = 'Premium'
)
SELECT 
    COUNT(*) AS PremiumTransactions,
    SUM(CASE WHEN ABS(tl.CommissionAmount - (tl.Amount * c.CommissionPercentage / 100.0)) > 0.01 THEN 1 ELSE 0 END) AS Mismatches
FROM PremiumTx tl
INNER JOIN Commissions c ON tl.ProductID = c.ProductID 
    AND c.MerchantTier = 'Premium' 
    AND c.IsActive = 1;