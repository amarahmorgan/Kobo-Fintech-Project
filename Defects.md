# 📄 Task Questions — Kobo Merchant & Settlement Gateway

---

## 🔷 Task 1: Git Branching & Regression Risk

A structured Git branching strategy (e.g., maintaining `main` as the stable production branch with short-lived `feature/` branches) reduces regression risk in a shared automation suite through three key principles: isolation, accountability, and traceability.

### 🔹 Isolation  
Each engineer works in an isolated feature branch. This ensures that incomplete, unstable, or broken automation code does not directly affect the shared `main` branch. As a result, the main test suite remains stable and reliable at all times.

### 🔹 Accountability via Peer Review  
All changes must be submitted through Pull Requests (PRs), where team members review the code before merging. This ensures:
- Bugs and logic errors are caught early  
- Incorrect locators or unstable tests are identified  
- Code quality standards are maintained  

This process acts as a quality gate, preventing regressions from being introduced into the main branch.

### 🔹 Traceability  
A structured Git history allows teams to track every change. Using tools like `git log` and `git blame`, regressions can be traced back to:
- A specific commit  
- A Pull Request  
- The responsible contributor  

This significantly improves debugging efficiency and system maintainability.

### ✅ Conclusion  
A structured branching strategy ensures all changes are isolated, reviewed, and traceable, minimizing regression risk in a collaborative environment.

---

## 🔷 Task 2: Least Privilege & API Vulnerability

Yes, during API validation, instances were identified where the system failed to fully enforce the principle of Least Privilege.

During privilege escalation testing, it was observed that a standard Merchant authentication token could attempt to access restricted Admin endpoints such as:
- `/api/v1/admin/ledger`  
- `/api/v1/admin/users`  
- `/api/v1/admin/settlements`  

While some endpoints correctly returned `401/403` responses, enforcement was inconsistent across all endpoints.

Additionally, cross-merchant access testing revealed that a Merchant could attempt to retrieve data belonging to another Merchant using endpoints such as:
- `/api/v1/merchants/{id}/transactions`  
- `/api/v1/merchants/{id}/balance`  

This exposes a potential **Insecure Direct Object Reference (IDOR)** vulnerability, where the system authenticates the user but fails to properly authorize access to specific resources.

### 🚨 Impact  
- Unauthorized data access  
- Exposure of sensitive financial information  
- Violation of data privacy principles  

### ✅ Conclusion  
The system demonstrates gaps in enforcing Least Privilege, particularly in authorization checks. In a production fintech environment, strict RBAC enforcement is essential to ensure users can only access data within their permitted scope.

---

## 🔷 Task 3: Page Object Model (POM) & UI Stability

In the Page Object Model (POM), separating locators from test logic significantly improves the stability and maintainability of the automation suite.

### 🔹 Centralized Locators  
All selectors (e.g., `getByRole`, `getByTestId`, CSS selectors) are stored within dedicated Page Object classes such as `LoginPage` or `SettingsPage`. If the UI changes, only the locator in the Page Object needs to be updated.

### 🔹 Resilient Test Logic  
Test scripts interact with high-level methods such as:
- `login()`  
- `updateSettings()`  
- `processTransaction()`  

This ensures that test cases focus on business logic rather than UI structure.

### 🔹 Reduced Maintenance Effort  
Without POM, locators would be duplicated across multiple test files. A single UI change would require updates in many places, increasing maintenance effort and the risk of broken tests.

### 🔹 Stability Benefit  
Because 40+ automated tests rely on reusable page objects instead of raw selectors, a UI change does not cause a cascading failure across the test suite.

### ✅ Conclusion  
Separating locators from test logic improves readability, scalability, and resilience, making the automation framework stable in fast-changing UI environments.

---

## 🔷 Task 4: Data Types & Financial Discrepancies

The data type used in the financial tables that can cause rounding errors is `FLOAT` (as well as `MONEY` in some SQL systems).

### 🔹 Why FLOAT Causes Problems  
FLOAT is an approximate numeric type that uses binary floating-point representation. It cannot accurately store many decimal values such as:
- 0.1  
- 0.05  
- Percentage values like 3.5% or 5.50%  

While small inaccuracies may not be visible in a single transaction, they accumulate across high-volume transactions, leading to noticeable discrepancies.

---

### 🔹 SQL Example Demonstrating a Financial Discrepancy

```sql
USE KoboFintech;
GO

-- Using FLOAT (approximate type)
DECLARE @amount FLOAT = 1000000.00;
DECLARE @commissionRate FLOAT = 0.035;

DECLARE @commissionFloat FLOAT = @amount * @commissionRate;
-- May result in slight inaccuracy (e.g., 35000.00000000001)

-- Using DECIMAL (exact precision)
DECLARE @amountDec DECIMAL(19,4) = 1000000.0000;
DECLARE @commissionRateDec DECIMAL(5,4) = 0.0350;

DECLARE @commissionDec DECIMAL(19,4) = @amountDec * @commissionRateDec;
-- Exact result: 35000.0000

🔹 Impact
	•	Incorrect commission calculations
	•	Settlement discrepancies
	•	Financial reconciliation failures
	•	Audit and compliance risks

    Recommendation

Financial systems should use fixed precision data types such as:
	•	DECIMAL(18,4)
	•	NUMERIC(18,4)

These ensure exact calculations and prevent cumulative rounding errors.

   Conclusion

Using FLOAT in financial systems introduces precision errors that compound over time. Replacing it with DECIMAL ensures accurate and reliable financial processing.