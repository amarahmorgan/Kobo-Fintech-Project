# 📄 Contributions Log — Kobo Merchant & Settlement Gateway

## 👥 Team Members
- Amarah Morgan  
- Yanda  

---

## 🔷 Task 1: Environment Setup & Git Governance
**Contributors:** Amarah & Yanda  

- Executed Kobo.sql and verified database setup (5000+ records)
- Installed and ran Node.js API locally
- Verified API endpoints via Swagger
- Initialized Playwright framework using TypeScript and POM structure
- Set up Git repository with proper branching strategy (feature branches, PR workflow)

---

## 🔷 Task 2: API Testing (Postman)

### 🔹 Task 2.1 — Merchant Lifecycle
**Completed by:** Yanda  

- Created 15+ API requests for merchant lifecycle
- Tested registration, activation, and state transitions
- Validated edge cases:
  - Duplicate MSISDN
  - Invalid inputs
  - Weak authentication scenarios

---

### 🔹 Task 2.2 — Financial & Distribution Logic
**Completed by:** Amarah  

- Created 20 API requests for voucher issuance and wallet processing
- Tested:
  - Successful transactions
  - Invalid inputs
  - Boundary conditions
- Identified critical defects:
  - Transactions processed despite insufficient balance
  - Duplicate transaction references allowed
  - Invalid product ID causing 500 Internal Server Error

---

### 🔹 Task 2.3 — Identity & RBAC
**Completed by:** Amarah  

- Performed privilege escalation testing
- Attempted access to admin endpoints using merchant tokens
- Tested:
  - Unauthorized access
  - Missing tokens
  - Tampered tokens
- Verified weaknesses in access control enforcement

---

## 🔷 Task 3: Playwright Automation

### 🔹 Task 3.1 — Merchant Happy Path
**Completed by:** Yanda  

- Automated full merchant journey:
  - Login
  - Balance inquiry
  - Voucher purchase
  - Transaction validation
  - Ledger verification

---

### 🔹 Task 3.2 — Negative & Boundary Testing
**Completed by:** Amarah  

- Automated negative scenarios:
  - Invalid inputs
  - Missing required fields
  - Validation failures
- Identified UI defects:
  - Transactions processing without required inputs
  - Missing validation enforcement

---

### 🔹 Task 3.3 — Cross-Role Synchronisation
**Completed by:** Amarah & Yanda  

- Yanda:
  - Initial setup and partial test implementation  
- Amarah:
  - Completed remaining tests
  - Verified synchronization between admin and merchant views  

- Validated:
  - Commission updates reflecting correctly across roles

---

## 🔷 Task 4: Database Testing (SQL)

### 🔹 Task 4.1 — Financial Reconciliation
**Completed by:** Yanda  

- Wrote queries to detect ghost transactions
- Verified consistency between Wallets and DigitalVouchers

---

### 🔹 Task 4.2 — Settlement Validation
**Completed by:** Amarah  

- Created JOIN queries across Users, Products, and Transactions
- Verified commission calculations for recent transactions

---

### 🔹 Task 4.3 — Data Integrity & Constraints
**Completed by:** Amarah  

- Identified data issues:
  - Duplicate transaction references
  - Invalid MSISDN formats
- Validated data quality and constraints

---

### 🔹 Task 4.4 — Business Intelligence Reporting
**Completed by:** Yanda  

- Generated reports:
  - Top 10 merchants by revenue
  - Low-performing product SKUs
- Supported business decision-making insights

---

## 🔷 Task 5: Documentation & Analysis

### 📄 Defects Register (`defects.md`)
**Contributors:** Amarah & Yanda  

- Identified and documented system defects
- Included:
  - Financial bugs
  - Validation issues
  - Security vulnerabilities

---

### 📄 Task Questions (`task-questions.md`)
**Contributors:** Amarah & Yanda  

- Both contributed to answering all task questions
- Covered:
  - Git traceability
  - RBAC security
  - POM design principles
  - Financial validation

---

### 📄 README.md
**Contributors:** Amarah & Yanda  

- Wrote project overview
- Documented setup instructions
- Provided execution guidelines

---

## 🔷 Summary

This project was completed collaboratively, with responsibilities divided across API testing, automation, and database validation. Both team members contributed to defect identification, documentation, and overall system analysis, ensuring comprehensive test coverage of the fintech platform.