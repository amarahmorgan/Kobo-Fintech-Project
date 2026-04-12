SELECT 
    u.UserID,
    u.FullName,
    COUNT(*) AS GhostCount,
    SUM(tl.Amount) AS TotalLost
FROM TransactionLedger tl
LEFT JOIN DigitalVouchers dv ON tl.EntryID = dv.EntryID
JOIN Wallets w ON tl.WalletID = w.WalletID
JOIN Users u ON w.UserID = u.UserID
WHERE dv.EntryID IS NULL
  AND tl.ProcessingStatus = 'Completed'
GROUP BY u.UserID, u.FullName
ORDER BY TotalLost DESC;