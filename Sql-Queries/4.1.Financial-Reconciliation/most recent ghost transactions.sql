SELECT TOP 10
    tl.EntryID,
    tl.WalletID,
    tl.Amount,
    tl.CreatedTimestamp
FROM TransactionLedger tl
LEFT JOIN DigitalVouchers dv ON tl.EntryID = dv.EntryID
WHERE dv.EntryID IS NULL
  AND tl.ProcessingStatus = 'Completed'
ORDER BY tl.CreatedTimestamp DESC;