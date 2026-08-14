# SQL Operations – Detailed Beginner-Friendly Guide

This guide covers the major SQL operations used to create, read, modify, secure, and manage relational databases, with special attention to the difference between **DELETE**, **TRUNCATE**, and **DROP**.

---

# 1. Main Categories of SQL Commands

SQL commands are commonly grouped into five categories:

| Category | Full Form | Purpose | Common Commands |
|---|---|---|---|
| DDL | Data Definition Language | Defines database structure | `CREATE`, `ALTER`, `DROP`, `TRUNCATE` |
| DML | Data Manipulation Language | Changes table data | `INSERT`, `UPDATE`, `DELETE` |
| DQL | Data Query Language | Reads data | `SELECT` |
| DCL | Data Control Language | Controls permissions | `GRANT`, `REVOKE` |
| TCL | Transaction Control Language | Manages transactions | `COMMIT`, `ROLLBACK`, `SAVEPOINT` |

---

# 2. CREATE

`CREATE` is used to create database objects such as databases, tables, views, indexes, and schemas.

## Create a Database

```sql
CREATE DATABASE company_db;
```

## Create a Table

```sql
CREATE TABLE department (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(500),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

## Create Another Table with a Foreign Key

```sql
CREATE TABLE employee (
    id BIGSERIAL PRIMARY KEY,
    employee_code VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    email VARCHAR(255) NOT NULL UNIQUE,
    department_id BIGINT,
    salary NUMERIC(12,2),
    date_of_joining DATE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id)
        REFERENCES department(id)
);
```

---

# 3. INSERT

`INSERT` is used to add new rows into a table.

## Insert One Row

```sql
INSERT INTO department (name, description)
VALUES ('Engineering', 'Software development department');
```

## Insert Multiple Rows

```sql
INSERT INTO department (name, description)
VALUES
    ('Finance', 'Finance and accounting'),
    ('HR', 'Human resources'),
    ('Sales', 'Sales department');
```

## Insert Employee

```sql
INSERT INTO employee (
    employee_code,
    first_name,
    last_name,
    email,
    department_id,
    salary,
    date_of_joining
)
VALUES (
    'EMP001',
    'Arun',
    'Kumar',
    'arun@example.com',
    1,
    75000,
    '2026-01-10'
);
```

---

# 4. SELECT

`SELECT` retrieves data from one or more tables.

## Select All Columns

```sql
SELECT *
FROM employee;
```

## Select Specific Columns

```sql
SELECT first_name, last_name, email
FROM employee;
```

## Filter with WHERE

```sql
SELECT *
FROM employee
WHERE department_id = 1;
```

## Multiple Conditions

```sql
SELECT *
FROM employee
WHERE department_id = 1
  AND is_active = TRUE;
```

## OR

```sql
SELECT *
FROM employee
WHERE department_id = 1
   OR department_id = 2;
```

## NOT

```sql
SELECT *
FROM employee
WHERE NOT is_active;
```

---

# 5. Comparison Operators

| Operator | Meaning |
|---|---|
| `=` | Equal |
| `<>` or `!=` | Not equal |
| `>` | Greater than |
| `<` | Less than |
| `>=` | Greater than or equal |
| `<=` | Less than or equal |

Example:

```sql
SELECT *
FROM employee
WHERE salary >= 50000;
```

---

# 6. BETWEEN

Used to search within a range.

```sql
SELECT *
FROM employee
WHERE salary BETWEEN 50000 AND 100000;
```

Equivalent to:

```sql
SELECT *
FROM employee
WHERE salary >= 50000
  AND salary <= 100000;
```

---

# 7. IN

Used when checking multiple possible values.

```sql
SELECT *
FROM employee
WHERE department_id IN (1, 2, 3);
```

---

# 8. LIKE

Used for pattern matching.

## Starts With

```sql
SELECT *
FROM employee
WHERE first_name LIKE 'A%';
```

## Ends With

```sql
SELECT *
FROM employee
WHERE first_name LIKE '%n';
```

## Contains

```sql
SELECT *
FROM employee
WHERE first_name LIKE '%ru%';
```

---

# 9. NULL Checks

Never compare `NULL` using `= NULL`.

Wrong:

```sql
SELECT *
FROM employee
WHERE department_id = NULL;
```

Correct:

```sql
SELECT *
FROM employee
WHERE department_id IS NULL;
```

For non-null values:

```sql
SELECT *
FROM employee
WHERE department_id IS NOT NULL;
```

---

# 10. DISTINCT

Removes duplicate values from query results.

```sql
SELECT DISTINCT department_id
FROM employee;
```

---

# 11. ORDER BY

Sorts results.

## Ascending

```sql
SELECT *
FROM employee
ORDER BY salary ASC;
```

## Descending

```sql
SELECT *
FROM employee
ORDER BY salary DESC;
```

Multiple columns:

```sql
SELECT *
FROM employee
ORDER BY department_id ASC, salary DESC;
```

---

# 12. LIMIT

Restricts the number of returned rows.

PostgreSQL/MySQL:

```sql
SELECT *
FROM employee
LIMIT 10;
```

With offset:

```sql
SELECT *
FROM employee
LIMIT 10 OFFSET 20;
```

This can be used for pagination.

---

# 13. UPDATE

`UPDATE` modifies existing rows.

## Update One Employee

```sql
UPDATE employee
SET salary = 80000
WHERE id = 1;
```

## Update Multiple Columns

```sql
UPDATE employee
SET
    salary = 85000,
    is_active = TRUE
WHERE id = 1;
```

## Update Multiple Rows

```sql
UPDATE employee
SET salary = salary * 1.10
WHERE department_id = 1;
```

> Always verify the `WHERE` clause before executing an `UPDATE`.

Without `WHERE`:

```sql
UPDATE employee
SET salary = 0;
```

This updates **every row**.

---

# 14. DELETE

`DELETE` removes rows from a table.

## Delete One Row

```sql
DELETE FROM employee
WHERE id = 10;
```

## Delete Multiple Rows

```sql
DELETE FROM employee
WHERE is_active = FALSE;
```

## Delete Every Row

```sql
DELETE FROM employee;
```

The table still exists after the command.

---

# 15. TRUNCATE

`TRUNCATE` removes all rows from a table.

```sql
TRUNCATE TABLE employee;
```

The table structure remains.

In PostgreSQL, identity/sequence values can also be reset:

```sql
TRUNCATE TABLE employee RESTART IDENTITY;
```

If related tables reference it and you intentionally want cascading behavior:

```sql
TRUNCATE TABLE employee CASCADE;
```

Use `CASCADE` carefully.

---

# 16. DROP

`DROP` completely removes a database object.

## Drop Table

```sql
DROP TABLE employee;
```

After this:

- Rows are gone.
- Columns are gone.
- Constraints are gone.
- Indexes belonging to the table are gone.
- The table itself no longer exists.

## Drop Only if It Exists

```sql
DROP TABLE IF EXISTS employee;
```

---

# 17. DELETE vs TRUNCATE vs DROP

This is one of the most important SQL differences.

| Feature | DELETE | TRUNCATE | DROP |
|---|---|---|---|
| Removes rows | Yes | Yes, all rows | Yes |
| Removes table structure | No | No | Yes |
| Supports `WHERE` | Yes | No | No |
| Can remove selected rows | Yes | No | No |
| Table remains usable | Yes | Yes | No |
| Usually logs row-by-row changes | Yes | Usually less logging | Object removal |
| Usually faster for clearing a whole table | Slower | Faster | Fast |
| Triggers | DB-specific; row delete triggers normally fire | Behavior varies by DB | Not row deletion |
| Identity reset | Usually no | Can reset depending on DB | Object is removed |
| Typical use | Delete specific data | Empty a table quickly | Remove the table |

## Easy Way to Remember

### DELETE

> Remove **data rows**.

```sql
DELETE FROM employee
WHERE id = 5;
```

Table remains:

```text
employee
├── id
├── name
├── email
└── ...
```

Only matching data is removed.

---

### TRUNCATE

> Empty the **entire table**, but keep the table.

```sql
TRUNCATE TABLE employee;
```

Before:

```text
employee
---------
1 | Arun
2 | Maya
3 | John
```

After:

```text
employee
---------
(no rows)
```

But you can still run:

```sql
INSERT INTO employee (...);
```

because the table still exists.

---

### DROP

> Remove the **table itself**.

```sql
DROP TABLE employee;
```

Afterward:

```sql
SELECT *
FROM employee;
```

will fail because the table no longer exists.

---

# 18. Practical Example

Suppose an `employee` table has 10,000 rows.

## Requirement 1: Remove one employee

Use:

```sql
DELETE FROM employee
WHERE id = 100;
```

Do **not** use `TRUNCATE`.

---

## Requirement 2: Remove inactive employees only

Use:

```sql
DELETE FROM employee
WHERE is_active = FALSE;
```

---

## Requirement 3: Remove every employee but keep the table

Use:

```sql
TRUNCATE TABLE employee;
```

or:

```sql
DELETE FROM employee;
```

`TRUNCATE` is generally more appropriate when you intentionally want to clear the entire table.

---

## Requirement 4: The employee table is no longer required

Use:

```sql
DROP TABLE employee;
```

---

# 19. ALTER TABLE

`ALTER TABLE` modifies an existing table structure.

## Add Column

```sql
ALTER TABLE department
ADD COLUMN department_code VARCHAR(20);
```

## Rename Column

PostgreSQL:

```sql
ALTER TABLE department
RENAME COLUMN department_code TO code;
```

## Change Data Type

PostgreSQL:

```sql
ALTER TABLE department
ALTER COLUMN code TYPE VARCHAR(50);
```

## Add NOT NULL

```sql
ALTER TABLE department
ALTER COLUMN code SET NOT NULL;
```

## Remove NOT NULL

```sql
ALTER TABLE department
ALTER COLUMN code DROP NOT NULL;
```

## Add Default

```sql
ALTER TABLE department
ALTER COLUMN is_active SET DEFAULT TRUE;
```

## Drop Column

```sql
ALTER TABLE department
DROP COLUMN description;
```

---

# 20. Primary Key

A primary key uniquely identifies each row.

```sql
CREATE TABLE role (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
```

Properties:

- Must be unique.
- Cannot be `NULL`.
- A table normally has one primary key.
- A primary key can contain multiple columns.

Composite primary key example:

```sql
CREATE TABLE employee_role (
    employee_id BIGINT,
    role_id BIGINT,

    PRIMARY KEY (employee_id, role_id)
);
```

---

# 21. Foreign Key

A foreign key creates a relationship between tables.

```sql
ALTER TABLE employee
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (department_id)
REFERENCES department(id);
```

It helps maintain referential integrity.

Example:

```text
department
-----------
1 Engineering
2 Finance

employee
--------
101 Arun  department_id = 1
102 Maya  department_id = 2
```

---

# 22. UNIQUE Constraint

Prevents duplicate values.

```sql
ALTER TABLE employee
ADD CONSTRAINT uq_employee_email
UNIQUE (email);
```

---

# 23. CHECK Constraint

Restricts accepted values.

```sql
ALTER TABLE employee
ADD CONSTRAINT chk_salary
CHECK (salary >= 0);
```

---

# 24. DEFAULT Constraint

Provides a value automatically when one is not supplied.

```sql
CREATE TABLE project (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(200),
    is_active BOOLEAN DEFAULT TRUE
);
```

---

# 25. JOIN Operations

Joins combine rows from related tables.

## INNER JOIN

Returns rows that match in both tables.

```sql
SELECT
    e.id,
    e.first_name,
    d.name AS department_name
FROM employee e
INNER JOIN department d
    ON d.id = e.department_id;
```

---

## LEFT JOIN

Returns every row from the left table and matching rows from the right.

```sql
SELECT
    e.first_name,
    d.name AS department_name
FROM employee e
LEFT JOIN department d
    ON d.id = e.department_id;
```

Employees without a department still appear.

---

## RIGHT JOIN

Returns every row from the right table.

```sql
SELECT
    e.first_name,
    d.name
FROM employee e
RIGHT JOIN department d
    ON d.id = e.department_id;
```

---

## FULL OUTER JOIN

Returns matching and non-matching rows from both tables.

```sql
SELECT
    e.first_name,
    d.name
FROM employee e
FULL OUTER JOIN department d
    ON d.id = e.department_id;
```

---

## CROSS JOIN

Returns every possible combination.

```sql
SELECT *
FROM employee
CROSS JOIN role;
```

If there are:

- 10 employees
- 5 roles

the result has:

```text
10 × 5 = 50 rows
```

---

# 26. Aggregate Functions

Aggregate functions summarize multiple rows.

## COUNT

```sql
SELECT COUNT(*)
FROM employee;
```

## SUM

```sql
SELECT SUM(salary)
FROM employee;
```

## AVG

```sql
SELECT AVG(salary)
FROM employee;
```

## MIN

```sql
SELECT MIN(salary)
FROM employee;
```

## MAX

```sql
SELECT MAX(salary)
FROM employee;
```

---

# 27. GROUP BY

Groups rows before applying aggregate functions.

```sql
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employee
GROUP BY department_id;
```

Average salary per department:

```sql
SELECT
    department_id,
    AVG(salary) AS average_salary
FROM employee
GROUP BY department_id;
```

---

# 28. HAVING

`HAVING` filters grouped results.

```sql
SELECT
    department_id,
    COUNT(*) AS employee_count
FROM employee
GROUP BY department_id
HAVING COUNT(*) > 5;
```

Difference:

```text
WHERE  -> filters rows before grouping
HAVING -> filters groups after GROUP BY
```

---

# 29. Aliases

Aliases temporarily rename columns or tables.

Column alias:

```sql
SELECT
    first_name AS employee_name
FROM employee;
```

Table alias:

```sql
SELECT
    e.first_name,
    d.name
FROM employee e
JOIN department d
    ON d.id = e.department_id;
```

---

# 30. Subqueries

A subquery is a query inside another query.

Example:

```sql
SELECT *
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);
```

This returns employees whose salaries are above the company average.

---

# 31. EXISTS

Checks whether a subquery returns any rows.

```sql
SELECT *
FROM department d
WHERE EXISTS (
    SELECT 1
    FROM employee e
    WHERE e.department_id = d.id
);
```

Returns departments that have at least one employee.

---

# 32. Common Table Expressions – CTE

A CTE makes complex queries easier to read.

```sql
WITH high_salary_employees AS (
    SELECT *
    FROM employee
    WHERE salary > 100000
)
SELECT *
FROM high_salary_employees;
```

---

# 33. CASE Expression

`CASE` adds conditional logic to SQL.

```sql
SELECT
    first_name,
    salary,
    CASE
        WHEN salary >= 100000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category
FROM employee;
```

---

# 34. UNION

Combines query results and removes duplicates.

```sql
SELECT email
FROM employee

UNION

SELECT email
FROM contractor;
```

---

# 35. UNION ALL

Combines results without removing duplicates.

```sql
SELECT email
FROM employee

UNION ALL

SELECT email
FROM contractor;
```

`UNION ALL` is usually faster because duplicate removal is not required.

---

# 36. INDEX

Indexes help the database locate rows faster.

```sql
CREATE INDEX idx_employee_email
ON employee(email);
```

Multi-column index:

```sql
CREATE INDEX idx_employee_department_active
ON employee(department_id, is_active);
```

Delete an index:

```sql
DROP INDEX idx_employee_email;
```

Indexes can improve reads but may add overhead to:

- `INSERT`
- `UPDATE`
- `DELETE`

because the index may also need to be updated.

---

# 37. VIEW

A view stores a query definition.

```sql
CREATE VIEW active_employees AS
SELECT
    id,
    first_name,
    last_name,
    email
FROM employee
WHERE is_active = TRUE;
```

Use it:

```sql
SELECT *
FROM active_employees;
```

Delete it:

```sql
DROP VIEW active_employees;
```

---

# 38. TRANSACTIONS

Transactions group multiple SQL operations into one logical unit.

Example:

```sql
BEGIN;

UPDATE account
SET balance = balance - 1000
WHERE id = 1;

UPDATE account
SET balance = balance + 1000
WHERE id = 2;

COMMIT;
```

If something goes wrong:

```sql
ROLLBACK;
```

---

# 39. COMMIT

Permanently saves transaction changes.

```sql
BEGIN;

UPDATE employee
SET salary = 90000
WHERE id = 1;

COMMIT;
```

---

# 40. ROLLBACK

Cancels changes made in the current transaction.

```sql
BEGIN;

DELETE FROM employee
WHERE department_id = 5;

ROLLBACK;
```

The deletion is cancelled.

---

# 41. SAVEPOINT

Creates a point inside a transaction that can be rolled back to.

```sql
BEGIN;

UPDATE employee
SET salary = 70000
WHERE id = 1;

SAVEPOINT salary_updated;

DELETE FROM employee
WHERE id = 2;

ROLLBACK TO salary_updated;

COMMIT;
```

The update can remain while the later delete is undone.

---

# 42. GRANT

Provides permissions.

```sql
GRANT SELECT ON employee TO reporting_user;
```

Multiple permissions:

```sql
GRANT SELECT, INSERT, UPDATE
ON employee
TO application_user;
```

---

# 43. REVOKE

Removes previously granted permissions.

```sql
REVOKE UPDATE
ON employee
FROM application_user;
```

---

# 44. SQL CRUD Mapping

CRUD is frequently used in application development.

| CRUD | SQL |
|---|---|
| Create | `INSERT` |
| Read | `SELECT` |
| Update | `UPDATE` |
| Delete | `DELETE` |

Example:

```sql
-- CREATE
INSERT INTO department (name)
VALUES ('Legal');

-- READ
SELECT *
FROM department;

-- UPDATE
UPDATE department
SET name = 'Legal & Compliance'
WHERE id = 4;

-- DELETE
DELETE FROM department
WHERE id = 4;
```

---

# 45. Useful PostgreSQL Date/Time Examples

Current date:

```sql
SELECT CURRENT_DATE;
```

Current timestamp:

```sql
SELECT CURRENT_TIMESTAMP;
```

Rows created today:

```sql
SELECT *
FROM employee
WHERE created_at::date = CURRENT_DATE;
```

Rows from the last seven days:

```sql
SELECT *
FROM employee
WHERE created_at >= CURRENT_TIMESTAMP - INTERVAL '7 days';
```

---

# 46. UPDATE Using Another Table

PostgreSQL supports `UPDATE ... FROM`.

```sql
UPDATE employee e
SET department_id = d.id
FROM department d
WHERE d.name = 'Engineering'
  AND e.email = 'arun@example.com';
```

---

# 47. DELETE Using Another Table

PostgreSQL example:

```sql
DELETE FROM employee e
USING department d
WHERE e.department_id = d.id
  AND d.name = 'Temporary';
```

---

# 48. INSERT from SELECT

Rows can be copied from another query.

```sql
INSERT INTO archived_employee (
    id,
    first_name,
    last_name,
    email
)
SELECT
    id,
    first_name,
    last_name,
    email
FROM employee
WHERE is_active = FALSE;
```

---

# 49. Safe UPDATE and DELETE Practice

Before executing:

```sql
DELETE FROM employee
WHERE department_id = 3;
```

first run:

```sql
SELECT *
FROM employee
WHERE department_id = 3;
```

Verify the exact rows.

Then execute the modification inside a transaction:

```sql
BEGIN;

DELETE FROM employee
WHERE department_id = 3;

-- verify
SELECT *
FROM employee
WHERE department_id = 3;

COMMIT;
```

If incorrect:

```sql
ROLLBACK;
```

---

# 50. Important DELETE / TRUNCATE / DROP Interview Question

## Question

What is the difference between `DELETE`, `TRUNCATE`, and `DROP`?

## Answer

`DELETE` removes rows from a table and supports a `WHERE` clause.

```sql
DELETE FROM employee
WHERE id = 5;
```

`TRUNCATE` removes all rows from the table while keeping the table structure.

```sql
TRUNCATE TABLE employee;
```

`DROP` removes the entire table, including its structure.

```sql
DROP TABLE employee;
```

### Short Memory Trick

```text
DELETE   = Remove selected/all DATA
TRUNCATE = Empty all DATA, keep TABLE
DROP     = Remove TABLE itself
```

---

# 51. Quick Command Summary

```sql
-- Create table
CREATE TABLE employee (...);

-- Insert
INSERT INTO employee (...) VALUES (...);

-- Read
SELECT * FROM employee;

-- Update
UPDATE employee
SET salary = 50000
WHERE id = 1;

-- Delete selected rows
DELETE FROM employee
WHERE id = 1;

-- Delete all rows
DELETE FROM employee;

-- Quickly empty the whole table
TRUNCATE TABLE employee;

-- Remove table completely
DROP TABLE employee;

-- Add column
ALTER TABLE employee
ADD COLUMN phone VARCHAR(20);

-- Remove column
ALTER TABLE employee
DROP COLUMN phone;

-- Create index
CREATE INDEX idx_employee_email
ON employee(email);

-- Transaction
BEGIN;
UPDATE employee SET salary = 60000 WHERE id = 2;
COMMIT;

-- Undo transaction
ROLLBACK;
```

---

# Final Cheat Sheet

| Requirement | Command |
|---|---|
| Create a table | `CREATE TABLE` |
| Add rows | `INSERT` |
| Read rows | `SELECT` |
| Modify rows | `UPDATE` |
| Delete specific rows | `DELETE ... WHERE` |
| Delete all rows but keep table | `TRUNCATE` |
| Delete table completely | `DROP TABLE` |
| Change table structure | `ALTER TABLE` |
| Combine tables | `JOIN` |
| Group data | `GROUP BY` |
| Filter grouped data | `HAVING` |
| Improve lookup performance | `CREATE INDEX` |
| Save transaction | `COMMIT` |
| Undo transaction | `ROLLBACK` |
| Give permission | `GRANT` |
| Remove permission | `REVOKE` |

## Final Rule

Before running any destructive SQL command, especially:

```sql
DELETE
TRUNCATE
DROP
```

confirm that you understand exactly what will be removed and whether a transaction, backup, or recovery strategy is required.
