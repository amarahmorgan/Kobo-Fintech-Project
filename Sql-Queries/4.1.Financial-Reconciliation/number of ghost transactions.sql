  SELECT 
    COUNT(*) AS GhostTransactionCount
FROM TransactionLedger tl
LEFT JOIN DigitalVouchers dv 
    ON tl.EntryID = dv.EntryID
WHERE dv.EntryID IS NULL
  AND tl.ProcessingStatus = 'Completed';