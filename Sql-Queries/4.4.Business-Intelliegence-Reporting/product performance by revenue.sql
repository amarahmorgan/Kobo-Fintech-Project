SELECT 
    p.SKU,
    p.Description,
    SUM(tl.Amount) AS Revenue
FROM TransactionLedger tl
JOIN Products p ON tl.ProductID = p.ProductID
WHERE tl.ProcessingStatus = 'Completed'
GROUP BY p.SKU, p.Description
ORDER BY Revenue DESC;