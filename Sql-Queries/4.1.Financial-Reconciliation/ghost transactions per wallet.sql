SELECT 
    tl.WalletID,
    COUNT(*) AS GhostCount,
    SUM(tl.Amount) AS TotalLostAmount
FROM TransactionLedger tl
LEFT JOIN DigitalVouchers dv 
    ON tl.EntryID = dv.EntryID
WHERE dv.EntryID IS NULL
  AND tl.ProcessingStatus = 'Completed'
GROUP BY tl.WalletID
ORDER BY TotalLostAmount DESC;