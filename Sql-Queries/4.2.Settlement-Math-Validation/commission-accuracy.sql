-- 4.2.02 Settlement Math Validation - Commission Accuracy Rate (Recent 1,000 transactions)
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
),
ValidationStats AS (
    SELECT 
        COUNT(*) AS TotalTransactions,
        SUM(CASE WHEN ABS(tl.CommissionAmount - (tl.Amount * c.CommissionPercentage / 100.0)) <= 0.01 
                 THEN 1 ELSE 0 END) AS CorrectCommissions
    FROM RecentTransactions tl
    INNER JOIN Commissions c ON tl.ProductID = c.ProductID 
        AND tl.EffectiveTier = c.MerchantTier 
        AND c.IsActive = 1
)
SELECT 
    TotalTransactions,
    CorrectCommissions,
    ROUND(CorrectCommissions * 100.0 / NULLIF(TotalTransactions, 0), 2) AS AccuracyPercentage
FROM ValidationStats; 