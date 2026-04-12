SELECT 
    tl.ExternalReference,
    COUNT(*) AS Occurrences
FROM TransactionLedger tl
LEFT JOIN DigitalVouchers dv ON tl.EntryID = dv.EntryID
WHERE dv.EntryID IS NULL
  AND tl.ProcessingStatus = 'Completed'
GROUP BY tl.ExternalReference
HAVING COUNT(*) > 1;