SELECT TOP 10 
    m.MerchantID,
    m.BusinessName,
    SUM(tl.Amount) AS TotalRevenue
FROM TransactionLedger tl
JOIN Wallets w ON tl.WalletID = w.WalletID
JOIN Merchants m ON w.UserID = m.UserID
WHERE tl.ProcessingStatus = 'Completed'
GROUP BY m.MerchantID, m.BusinessName
ORDER BY TotalRevenue DESC;