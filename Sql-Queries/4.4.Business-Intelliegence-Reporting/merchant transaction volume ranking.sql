SELECT 
    m.MerchantID,
    m.BusinessName,
    COUNT(tl.EntryID) AS TransactionCount
FROM TransactionLedger tl
JOIN Wallets w ON tl.WalletID = w.WalletID
JOIN Merchants m ON w.UserID = m.UserID
GROUP BY m.MerchantID, m.BusinessName
ORDER BY TransactionCount DESC;