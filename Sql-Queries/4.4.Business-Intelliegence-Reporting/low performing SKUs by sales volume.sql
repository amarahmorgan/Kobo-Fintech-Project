SELECT TOP 10 
    p.SKU,
    COUNT(tl.EntryID) AS SalesCount
FROM TransactionLedger tl
JOIN Products p ON tl.ProductID = p.ProductID
WHERE tl.ProcessingStatus = 'Completed'
GROUP BY p.SKU
ORDER BY SalesCount ASC;