SELECT TOP 10 
    p.SKU,
    p.Description,
    SUM(tl.Amount) AS TotalRevenue
FROM TransactionLedger tl
JOIN Products p ON tl.ProductID = p.ProductID
WHERE tl.ProcessingStatus = 'Completed'
GROUP BY p.SKU, p.Description
ORDER BY TotalRevenue ASC;