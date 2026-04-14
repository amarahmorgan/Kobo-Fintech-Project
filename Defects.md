# 🐞 Defect Register — Kobo Merchant & Settlement Gateway

## 📌 Overview
During API testing (Postman), UI automation (Playwright), database validation (SQL), and cross-role synchronization testing, multiple critical defects were identified across financial processing, security, data integrity, and user experience layers. These defects highlight weaknesses in validation, transaction integrity, and system consistency.

---

# CRITICAL FINANCIAL DEFECTS

---

## 🚨 1. Insufficient Balance Not Enforced
**Description:** Transactions are processed even when the wallet balance is lower than the product value.  
**Expected:** Transaction should be rejected.  
**Actual:** Transaction succeeds.  
**Impact:** Financial loss, negative balances, incorrect settlements.  
**Severity:** Critical  

---

## 🚨 2. Duplicate Transaction References Allowed
**Description:** System allows multiple transactions with the same reference ID.  
**Expected:** Reference must be unique.  
**Actual:** Duplicate transactions succeed.  
**Impact:** Double charging, duplicate vouchers, ledger corruption.  
**Severity:** Critical  

---

## 🚨 3. Invalid Product ID Causes Server Crash (500)
**Description:** Invalid productId results in Internal Server Error.  
**Expected:** Return 400 or 404.  
**Actual:** System crashes.  
**Impact:** System instability, poor error handling.  
**Severity:** High  

---

## 🚨 4. Invalid Wallet ID Not Properly Validated
**Description:** Invalid wallet IDs produce inconsistent or incorrect responses.  
**Expected:** Proper validation error.  
**Actual:** Unpredictable behavior.  
**Impact:** Data integrity risk.  
**Severity:** High  

---

## 🚨 5. Rapid Duplicate Transactions Not Prevented
**Description:** Multiple rapid requests are processed without restriction.  
**Expected:** Rate limiting or duplicate detection.  
**Actual:** All requests succeed.  
**Impact:** Fraud risk, financial abuse.  
**Severity:** Critical  

---

# INPUT VALIDATION DEFECTS

---

## ⚠️ 6. Invalid MSISDN Accepted
**Description:** System accepts incorrectly formatted phone numbers.  
**Impact:** Data integrity issues, failed communication.  
**Severity:** High  

---

## ⚠️ 7. Invalid Voucher Quantity Accepted
**Description:** System allows zero, negative, or excessively large quantities.  
**Impact:** Incorrect financial calculations, abuse risk.  
**Severity:** Critical  

---

## ⚠️ 8. Weak Input Validation Across Forms
**Description:** Fields lack strict validation (length, format, required checks).  
**Impact:** Poor data quality, system inconsistency.  
**Severity:** High  

---

## ⚠️ 9. Weak Reference Field Validation
**Description:** System accepts long strings and special characters without restriction.  
**Impact:** Security and data integrity risks.  
**Severity:** Medium  

---

## ⚠️ 10. Missing or Inconsistent Error Messaging
**Description:** Error messages are unclear or inconsistent.  
**Impact:** Poor user experience, confusion.  
**Severity:** Medium  

---

# UI & USER EXPERIENCE DEFECTS

---

## ⚠️ 11. Balance Not Updating in Real-Time
**Description:** Wallet balance does not update after transaction until refresh.  
**Impact:** User confusion, duplicate transactions.  
**Severity:** High  

---

## ⚠️ 12. Session Handling Weakness
**Description:** Session timeout and persistence not properly enforced.  
**Impact:** Potential unauthorized access.  
**Severity:** High  

---

# CROSS-ROLE SYNCHRONISATION DEFECTS

---

## ⚠️ 13. Profile Changes Not Syncing
**Description:** Admin updates (phone, address) not reflected in Merchant view.  
**Impact:** Data inconsistency between roles.  
**Severity:** High  

---

## ⚠️ 14. 2FA Setting Not Syncing
**Description:** Admin enables 2FA, but Merchant session does not update.  
**Impact:** Security inconsistency.  
**Severity:** High  

---

## ⚠️ 15. Notification & Theme Changes Not Syncing
**Description:** UI preferences do not update across sessions.  
**Impact:** Poor user experience.  
**Severity:** Medium  

---

## ✅ 16. Clear Transactions Works Correctly
**Description:** Clearing transactions updates Merchant view immediately.  
**Impact:** Confirms correct behavior.  
**Severity:** N/A (Working Feature)  

---

# RBAC & SECURITY DEFECTS

---

## 🚨 17. Potential Privilege Escalation Risk
**Description:** Merchant attempts access to admin endpoints.  
**Impact:** Unauthorized data exposure.  
**Severity:** Critical  

---

## ⚠️ 18. Inconsistent Access Control Enforcement
**Description:** Not all endpoints enforce RBAC consistently.  
**Impact:** Security gaps.  
**Severity:** High  

---

## ⚠️ 19. Cross-Merchant Data Access Risk
**Description:** Merchant may access another merchant’s data.  
**Impact:** Privacy violation.  
**Severity:** High  

---

## ⚠️ 20. Weak Token Validation
**Description:** Invalid or tampered tokens may not be properly rejected.  
**Impact:** Unauthorized access.  
**Severity:** High  

---

## ⚠️ 21. Missing Authentication Handling
**Description:** Some endpoints may allow access without authentication.  
**Impact:** System exposure.  
**Severity:** Critical  

---

# DATABASE & DATA INTEGRITY DEFECTS

---

## 🚨 22. FLOAT Used for Financial Data
**Description:** Monetary values stored as FLOAT.  
**Impact:** Rounding errors over time.  
**Severity:** Critical  

---

## 🚨 23. Stored Procedure Missing Validation
**Description:** usp_IssueDigitalVoucher lacks balance checks and transactions.  
**Impact:** Negative balances, partial failures.  
**Severity:** Critical  

---

## 🚨 24. Ghost Transactions
**Description:** Transactions exist without corresponding vouchers.  
**Impact:** Ledger inconsistency.  
**Severity:** Critical  

---

## ⚠️ 25. Duplicate External References
**Description:** Duplicate references occur periodically.  
**Impact:** Data duplication issues.  
**Severity:** High  

---

## ⚠️ 26. Invalid MSISDN Data in Database
**Description:** Stored phone numbers have incorrect formats.  
**Impact:** Data quality issues.  
**Severity:** High  

---

## ⚠️ 27. Duplicate Commission Rules
**Description:** Multiple commission rules for same product/tier.  
**Impact:** Incorrect calculations.  
**Severity:** High  

---

## ⚠️ 28. Incorrect Settlement Calculations
**Description:** NetAmount ≠ GrossAmount - CommissionAmount.  
**Impact:** Financial inaccuracies.  
**Severity:** Critical  

---

## ⚠️ 29. Expired Vouchers Still Present
**Description:** Expired vouchers are not filtered or handled.  
**Impact:** Incorrect usage or reporting.  
**Severity:** Medium  

---

## ⚠️ 30. Negative and Low Wallet Balances
**Description:** Some wallets have invalid balances.  
**Impact:** Financial inconsistency.  
**Severity:** Critical  

---

## ⚠️ 31. Disabled Users Still Transacting
**Description:** Users marked Disabled still perform transactions.  
**Impact:** Business rule violation.  
**Severity:** Critical  

---

## ⚠️ 32. Merchant Status Mismatch
**Description:** Merchant status inconsistent with user ServiceStatus.  
**Impact:** Data inconsistency.  
**Severity:** High  

---

## ⚠️ 33. Referential Integrity Gaps
**Description:** Missing or weak relationships between tables.  
**Impact:** Data inconsistency.  
**Severity:** Medium  

---

# 📊 FINAL SUMMARY

The system exhibits critical weaknesses in:
- Financial validation and transaction integrity  
- Input validation and error handling  
- Role-based access control and security  
- Cross-role data synchronization  
- Database design and data consistency  

These defects pose significant risks to financial accuracy, system stability, and user trust, and must be addressed before production deployment.