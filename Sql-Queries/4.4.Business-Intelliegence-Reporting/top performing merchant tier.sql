SELECT 
    m.MerchantTier,
    SUM(tl.Amount) AS TotalRevenue
FROM TransactionLedger tl
JOIN Wallets w ON tl.WalletID = w.WalletID
JOIN Merchants m ON w.UserID = m.UserID
WHERE tl.ProcessingStatus = 'Completed'
GROUP BY m.MerchantTier
ORDER BY TotalRevenue DESC;