SELECT 
    w.WalletID,
    w.Balance,
    tl.EntryID,
    tl.Amount
FROM TransactionLedger tl
LEFT JOIN DigitalVouchers dv ON tl.EntryID = dv.EntryID
JOIN Wallets w ON tl.WalletID = w.WalletID
WHERE dv.EntryID IS NULL
  AND tl.ProcessingStatus = 'Completed'
  AND w.Balance < 0;