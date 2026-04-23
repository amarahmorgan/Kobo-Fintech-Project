SELECT 
    FORMAT(tl.CreatedTimestamp, 'yyyy-MM') AS Month,
    SUM(tl.Amount) AS TotalRevenue
FROM TransactionLedger tl
WHERE tl.ProcessingStatus = 'Completed'
GROUP BY FORMAT(tl.CreatedTimestamp, 'yyyy-MM')
ORDER BY Month;
