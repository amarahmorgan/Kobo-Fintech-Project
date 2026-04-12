SELECT 
    tl.EntryID,
    tl.Amount,
    tl.CommissionAmount,
    (tl.Amount + tl.CommissionAmount) AS TotalImpact
FROM TransactionLedger tl
LEFT JOIN DigitalVouchers dv ON tl.EntryID = dv.EntryID
WHERE dv.EntryID IS NULL
  AND tl.ProcessingStatus = 'Completed';