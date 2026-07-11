
# ACID Principles in Databases (With Examples)

## What are ACID Principles?
ACID principles ensure that **database transactions are reliable and safe**, even in cases of system failure, crashes, or concurrent access.

**ACID stands for:**
- **A**tomicity
- **C**onsistency
- **I**solation
- **D**urability

---

## 1️. Atomicity – *All or Nothing*

### Definition
Atomicity ensures that a transaction is treated as a **single unit**.
Either **all operations succeed**, or **none are applied**.

### Real‑World Example
Bank transfer of ₹1000:
- Debit from Account A
- Credit to Account B

If credit fails, debit must be undone.

### SQL Example
```sql
BEGIN;

UPDATE accounts SET balance = balance - 1000 WHERE id = 1;
UPDATE accounts SET balance = balance + 1000 WHERE id = 2;

COMMIT;
```

If any statement fails:
```sql
ROLLBACK;
```

✔ Prevents partial updates  
✔ Ensures data safety

---

## 2️. Consistency – *Rules Must Always Be Followed*

### Definition
A transaction must move the database from **one valid state to another valid state**.

All **constraints, rules, and relationships** must remain intact.

### Real‑World Example
Rule:
- Account balance cannot be negative

Trying to withdraw more money than available → transaction fails.

### SQL Example
```sql
ALTER TABLE accounts
ADD CONSTRAINT chk_balance CHECK (balance >= 0);
```

```sql
BEGIN;

UPDATE accounts SET balance = balance - 1000 WHERE id = 1;

COMMIT; -- Fails if balance becomes negative
```

✔ Data integrity maintained

---

## 3️. Isolation – *Transactions Don’t Interfere*

### Definition
Each transaction executes **independently**, as if it were the only one running.

Intermediate results are **not visible** to other transactions.

### Real‑World Example
Two users booking the **last movie ticket** at the same time.

Isolation ensures:
- Only one booking succeeds
- No double booking

### SQL Example
```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

BEGIN;

SELECT balance FROM accounts WHERE id = 1;
UPDATE accounts SET balance = balance - 500 WHERE id = 1;

COMMIT;
```

✔ Prevents dirty reads  
✔ Prevents lost updates

---

## 4️. Durability – *Once Done, It Stays Done*

### Definition
Once a transaction is committed, the changes are **permanently saved**, even if:
- System crashes
- Power failure occurs

### Real‑World Example
You receive a **payment success message**.
Even if the app crashes, the payment remains recorded.

### SQL Example
```sql
COMMIT;
```

After commit:
- Data is written to disk
- Recovery logs ensure persistence

✔ Data survives crashes

---

## ACID Summary Table

| Principle   | Meaning                  | Ensures |
|------------|--------------------------|--------|
| Atomicity  | All or nothing           | No partial updates |
| Consistency| Rules are preserved      | Data integrity |
| Isolation  | No interference          | Safe concurrency |
| Durability | Permanent storage        | Crash recovery |

---

##  Why ACID is Important
- Financial systems
- Banking applications
- E‑commerce platforms
- Enterprise applications

Any system where **data correctness matters** relies on ACID.

---

##  Quick Tip
Most relational databases support ACID:
- MySQL (InnoDB)
- PostgreSQL
- Oracle
- SQL Server

---

## Key Takeaway
> ACID guarantees that your database is **reliable, consistent, and trustworthy**.

Happy Learning! 
