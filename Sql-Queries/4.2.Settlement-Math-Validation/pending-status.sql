-- 4.2.12 Settlement Math Validation - Pending Status Transactions with Commission
USE KoboFintech;
GO

SELECT 
    COUNT(*) AS PendingTransactionsWithCommission,
    SUM(CommissionAmount) AS TotalCommissionInPending
FROM TransactionLedger
WHERE ProcessingStatus = 'Pending' 
  AND CommissionAmount > 0;