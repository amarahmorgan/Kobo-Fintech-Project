-- 4.2.07 Settlement Math Validation - Impact of Duplicate Commission Rule
-- Specifically checks effect of the duplicate rule for ProductID 2, Standard tier
USE KoboFintech;
GO

SELECT 
    'Duplicate Commission Rule (Product 2 - Standard)' AS Issue,
    COUNT(*) AS AffectedTransactions,
    SUM(tl.CommissionAmount) AS TotalCommissionApplied
FROM TransactionLedger tl
WHERE tl.ProductID = 2 
  AND ABS(tl.CommissionAmount - 6.00) < 0.01;  -- the duplicate 6% rule