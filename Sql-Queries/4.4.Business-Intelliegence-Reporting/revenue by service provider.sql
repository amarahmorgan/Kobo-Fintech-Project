SELECT 
    sp.ProviderName,
    SUM(tl.Amount) AS TotalRevenue
FROM TransactionLedger tl
JOIN Products p ON tl.ProductID = p.ProductID
JOIN ServiceProviders sp ON p.ProviderID = sp.ProviderID
WHERE tl.ProcessingStatus = 'Completed'
GROUP BY sp.ProviderName
ORDER BY TotalRevenue DESC;