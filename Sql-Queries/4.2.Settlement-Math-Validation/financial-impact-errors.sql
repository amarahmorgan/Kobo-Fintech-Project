-- 4.2.09 Settlement Math Validation - Financial Impact of Commission Errors
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
    SUM(ABS(tl.CommissionAmount - (tl.Amount * c.CommissionPercentage / 100.0))) AS TotalAbsoluteError,
    SUM(CASE WHEN tl.CommissionAmount > (tl.Amount * c.CommissionPercentage / 100.0) 
             THEN (tl.CommissionAmount - (tl.Amount * c.CommissionPercentage / 100.0)) ELSE 0 END) AS OverCommission,
    SUM(CASE WHEN tl.CommissionAmount < (tl.Amount * c.CommissionPercentage / 100.0) 
             THEN ((tl.Amount * c.CommissionPercentage / 100.0) - tl.CommissionAmount) ELSE 0 END) AS UnderCommission
FROM RecentTransactions tl
INNER JOIN Commissions c ON tl.ProductID = c.ProductID 
    AND tl.EffectiveTier = c.MerchantTier 
    AND c.IsActive = 1
WHERE ABS(tl.CommissionAmount - (tl.Amount * c.CommissionPercentage / 100.0)) > 0.01;