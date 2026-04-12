SELECT 
    w.WalletID,
    w.Balance,
    COUNT(*) AS GhostCount
FROM TransactionLedger tl
LEFT JOIN DigitalVouchers dv ON tl.EntryID = dv.EntryID
JOIN Wallets w ON tl.WalletID = w.WalletID
WHERE dv.EntryID IS NULL
  AND tl.ProcessingStatus = 'Completed'
  AND w.Balance < 10
GROUP BY w.WalletID, w.Balance;