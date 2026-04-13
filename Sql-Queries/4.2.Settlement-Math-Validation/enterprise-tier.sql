-- 4.2.13 Settlement Math Validation - Enterprise Tier Specific Validation
USE KoboFintech;
GO

WITH EnterpriseTx AS (
    SELECT tl.Amount, tl.CommissionAmount, tl.ProductID
    FROM TransactionLedger tl
    INNER JOIN Wallets w ON tl.WalletID = w.WalletID
    INNER JOIN Merchants m ON w.UserID = m.UserID
    WHERE m.MerchantTier = 'Enterprise'
)
SELECT 
    COUNT(*) AS EnterpriseTransactions,
    SUM(CASE WHEN ABS(tl.CommissionAmount - (tl.Amount * c.CommissionPercentage / 100.0)) > 0.01 THEN 1 ELSE 0 END) AS Mismatches,
    ROUND(100.0 * SUM(CASE WHEN ABS(tl.CommissionAmount - (tl.Amount * c.CommissionPercentage / 100.0)) > 0.01 THEN 1 ELSE 0 END) 
          / NULLIF(COUNT(*), 0), 2) AS MismatchPct
FROM EnterpriseTx tl
INNER JOIN Commissions c ON tl.ProductID = c.ProductID 
    AND c.MerchantTier = 'Enterprise' 
    AND c.IsActive = 1;