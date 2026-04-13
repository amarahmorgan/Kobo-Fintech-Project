-- 4.2.08 Settlement Math Validation - Cases Where Wrong Merchant Tier Was Used
USE KoboFintech;
GO

WITH RecentTransactions AS (
    SELECT TOP 1000 
        tl.EntryID,
        COALESCE(m.MerchantTier, 'Standard') AS ActualTier,
        tl.ProductID,
        tl.CommissionAmount
    FROM TransactionLedger tl
    INNER JOIN Wallets w ON tl.WalletID = w.WalletID
    LEFT JOIN Merchants m ON w.UserID = m.UserID
    ORDER BY tl.CreatedTimestamp DESC
)
SELECT 
    r.EntryID,
    r.ActualTier,
    c.MerchantTier AS CommissionTierUsed,
    p.Description,
    r.CommissionAmount
FROM RecentTransactions r
INNER JOIN Products p ON r.ProductID = p.ProductID
INNER JOIN Commissions c ON r.ProductID = c.ProductID AND c.IsActive = 1
WHERE r.ActualTier != c.MerchantTier 
  AND ABS(r.CommissionAmount - (r.Amount * c.CommissionPercentage / 100.0)) <= 0.01;  -- but used wrong tier