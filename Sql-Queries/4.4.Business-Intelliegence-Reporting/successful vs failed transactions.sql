SELECT 
    ProcessingStatus,
    COUNT(*) AS TotalTransactions,
    SUM(Amount) AS TotalValue
FROM TransactionLedger
GROUP BY ProcessingStatus;