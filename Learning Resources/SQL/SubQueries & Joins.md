# SQL Subqueries and Joins

## 1. Introduction

Two important SQL concepts used to retrieve data from multiple sources are:

- **Joins** — combine rows from two or more tables.
- **Subqueries** — place one SQL query inside another SQL query.

Both can sometimes solve the same problem, but they are useful in different situations.

---

# Sample Tables

We will use the following tables in the examples.

## Department

| id | name |
|---:|---|
| 1 | Engineering |
| 2 | HR |
| 3 | Finance |
| 4 | Marketing |

## Employee

| id | name | salary | department_id | manager_id |
|---:|---|---:|---:|---:|
| 1 | Arun | 70000 | 1 | NULL |
| 2 | Meera | 60000 | 1 | 1 |
| 3 | Rahul | 50000 | 2 | NULL |
| 4 | Priya | 80000 | 3 | NULL |
| 5 | Kiran | 45000 | NULL | 1 |

---

# 2. SQL Joins

A **JOIN** combines related rows from different tables using a matching condition.

Basic syntax:

```sql
SELECT columns
FROM table1
JOIN table2
    ON table1.column = table2.column;
```

---

# 3. INNER JOIN

An `INNER JOIN` returns only rows that have matching values in both tables.

```sql
SELECT
    e.name AS employee_name,
    d.name AS department_name
FROM employee e
INNER JOIN department d
    ON e.department_id = d.id;
```

Result:

```text
Arun   | Engineering
Meera  | Engineering
Rahul  | HR
Priya  | Finance
```

Kiran is not returned because `department_id` is `NULL`.

### Simple meaning

> Give me employees who have a matching department.

---

# 4. LEFT JOIN

A `LEFT JOIN` returns:

- All rows from the left table
- Matching rows from the right table
- `NULL` when no matching row exists

```sql
SELECT
    e.name AS employee_name,
    d.name AS department_name
FROM employee e
LEFT JOIN department d
    ON e.department_id = d.id;
```

Result:

```text
Arun   | Engineering
Meera  | Engineering
Rahul  | HR
Priya  | Finance
Kiran  | NULL
```

### Simple meaning

> Give me every employee, even if the employee does not have a department.

---

# 5. RIGHT JOIN

A `RIGHT JOIN` returns:

- All rows from the right table
- Matching rows from the left table
- `NULL` when there is no matching row

```sql
SELECT
    e.name AS employee_name,
    d.name AS department_name
FROM employee e
RIGHT JOIN department d
    ON e.department_id = d.id;
```

Marketing appears even though no employee belongs to it.

### Note

In practice, many developers prefer rewriting `RIGHT JOIN` as a `LEFT JOIN` because it is usually easier to read.

Instead of:

```sql
FROM employee e
RIGHT JOIN department d
```

you can write:

```sql
FROM department d
LEFT JOIN employee e
```

---

# 6. FULL OUTER JOIN

A `FULL OUTER JOIN` returns:

- Matching rows
- Unmatched rows from the left table
- Unmatched rows from the right table

```sql
SELECT
    e.name AS employee_name,
    d.name AS department_name
FROM employee e
FULL OUTER JOIN department d
    ON e.department_id = d.id;
```

This would include:

- Employees with departments
- Kiran with `NULL` department
- Marketing with `NULL` employee

---

# 7. CROSS JOIN

A `CROSS JOIN` returns every possible combination of rows.

```sql
SELECT
    e.name,
    d.name
FROM employee e
CROSS JOIN department d;
```

If there are:

```text
5 employees
4 departments
```

the result contains:

```text
5 × 4 = 20 rows
```

### Use carefully

A cross join can create a very large result set.

---

# 8. SELF JOIN

A self join joins a table with itself.

This is useful for hierarchical relationships such as:

- Employee → Manager
- Category → Parent Category
- User → Supervisor

Example:

```sql
SELECT
    e.name AS employee,
    m.name AS manager
FROM employee e
LEFT JOIN employee m
    ON e.manager_id = m.id;
```

Possible result:

```text
Arun   | NULL
Meera  | Arun
Rahul  | NULL
Priya  | NULL
Kiran  | Arun
```

Here:

```text
employee e
```

represents the employee.

```text
employee m
```

represents the manager.

They are the same table but are treated as two logical copies using aliases.

---

# 9. Joining More Than Two Tables

You can join multiple tables.

For example:

```text
Employee
EmployeeRole
Role
```

Query:

```sql
SELECT
    e.name AS employee_name,
    r.name AS role_name
FROM employee e
INNER JOIN employee_role er
    ON e.id = er.employee_id
INNER JOIN role r
    ON er.role_id = r.id;
```

The relationship is:

```text
Employee
   |
   | employee_id
   v
EmployeeRole
   |
   | role_id
   v
Role
```

---

# 10. Filtering After a JOIN

Example:

```sql
SELECT
    e.name,
    d.name AS department
FROM employee e
INNER JOIN department d
    ON e.department_id = d.id
WHERE e.salary > 60000;
```

The `ON` clause defines how tables are related.

The `WHERE` clause filters the resulting rows.

---

# 11. Important LEFT JOIN Mistake

Consider:

```sql
SELECT
    e.name,
    d.name
FROM employee e
LEFT JOIN department d
    ON e.department_id = d.id
WHERE d.name = 'Engineering';
```

Although this uses `LEFT JOIN`, the `WHERE` clause removes rows where `d.name` is `NULL`.

It behaves similarly to an `INNER JOIN`.

If the intention is to keep all employees and match only Engineering departments, use:

```sql
SELECT
    e.name,
    d.name
FROM employee e
LEFT JOIN department d
    ON e.department_id = d.id
    AND d.name = 'Engineering';
```

This distinction is important.

---

# 12. Finding Rows Without a Match

Example: find employees without departments.

```sql
SELECT
    e.*
FROM employee e
LEFT JOIN department d
    ON e.department_id = d.id
WHERE d.id IS NULL;
```

Result:

```text
Kiran
```

---

# 13. What Is a Subquery?

A **subquery** is a query written inside another SQL query.

Example:

```sql
SELECT *
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);
```

The inner query:

```sql
SELECT AVG(salary)
FROM employee;
```

calculates the average salary.

The outer query finds employees earning more than that average.

---

# 14. Types of Subqueries

Common subquery types include:

1. Scalar subquery
2. Single-row subquery
3. Multiple-row subquery
4. Correlated subquery
5. Subquery in `SELECT`
6. Subquery in `FROM`
7. Subquery in `WHERE`

---

# 15. Scalar Subquery

A scalar subquery returns exactly one value.

Example:

```sql
SELECT
    name,
    salary,
    (
        SELECT AVG(salary)
        FROM employee
    ) AS company_average_salary
FROM employee;
```

Example result:

```text
Arun   | 70000 | 61000
Meera  | 60000 | 61000
Rahul  | 50000 | 61000
Priya  | 80000 | 61000
Kiran  | 45000 | 61000
```

---

# 16. Subquery with WHERE

Example:

```sql
SELECT *
FROM employee
WHERE department_id = (
    SELECT id
    FROM department
    WHERE name = 'Engineering'
);
```

The inner query finds the Engineering department ID.

The outer query retrieves employees belonging to that department.

---

# 17. Subquery with IN

Use `IN` when a subquery can return multiple values.

```sql
SELECT *
FROM employee
WHERE department_id IN (
    SELECT id
    FROM department
    WHERE name IN ('Engineering', 'Finance')
);
```

### Why not use `=`?

This may fail:

```sql
WHERE department_id = (
    SELECT id
    FROM department
);
```

because the subquery can return several rows.

Use `IN` instead:

```sql
WHERE department_id IN (
    SELECT id
    FROM department
);
```

---

# 18. NOT IN

Example:

```sql
SELECT *
FROM employee
WHERE department_id NOT IN (
    SELECT id
    FROM department
    WHERE name = 'Engineering'
);
```

### NULL warning

`NOT IN` can behave unexpectedly if the subquery contains `NULL`.

For many real-world cases, `NOT EXISTS` is safer.

---

# 19. EXISTS

`EXISTS` checks whether a matching row exists.

Example:

```sql
SELECT *
FROM department d
WHERE EXISTS (
    SELECT 1
    FROM employee e
    WHERE e.department_id = d.id
);
```

This returns departments that have at least one employee.

### Why `SELECT 1`?

The actual selected value does not matter.

`EXISTS` only checks whether at least one matching row exists.

---

# 20. NOT EXISTS

Find departments without employees:

```sql
SELECT *
FROM department d
WHERE NOT EXISTS (
    SELECT 1
    FROM employee e
    WHERE e.department_id = d.id
);
```

Result:

```text
Marketing
```

---

# 21. Correlated Subquery

A correlated subquery refers to a column from the outer query.

Example:

```sql
SELECT
    e.name,
    e.salary,
    e.department_id
FROM employee e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employee e2
    WHERE e2.department_id = e.department_id
);
```

This asks:

> Which employees earn more than the average salary of their own department?

The inner query depends on the current row of the outer query.

---

# 22. Normal Subquery vs Correlated Subquery

## Normal subquery

```sql
SELECT *
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);
```

The inner query can be evaluated independently.

## Correlated subquery

```sql
SELECT *
FROM employee e
WHERE salary > (
    SELECT AVG(e2.salary)
    FROM employee e2
    WHERE e2.department_id = e.department_id
);
```

The inner query depends on the current outer row.

---

# 23. Subquery in SELECT

Example:

```sql
SELECT
    d.name,
    (
        SELECT COUNT(*)
        FROM employee e
        WHERE e.department_id = d.id
    ) AS employee_count
FROM department d;
```

This counts employees for every department.

---

# 24. Subquery in FROM

A subquery in `FROM` is sometimes called a **derived table**.

```sql
SELECT *
FROM (
    SELECT
        department_id,
        AVG(salary) AS average_salary
    FROM employee
    GROUP BY department_id
) department_salary
WHERE average_salary > 55000;
```

The inner query first produces a temporary result.

The outer query filters that result.

---

# 25. Subquery with MAX

Find the highest-paid employee:

```sql
SELECT *
FROM employee
WHERE salary = (
    SELECT MAX(salary)
    FROM employee
);
```

---

# 26. Second Highest Salary Using a Subquery

```sql
SELECT MAX(salary)
FROM employee
WHERE salary < (
    SELECT MAX(salary)
    FROM employee
);
```

---

# 27. Employees Earning More Than the Average Salary

```sql
SELECT
    name,
    salary
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);
```

---

# 28. Employees in the Same Department as Meera

```sql
SELECT *
FROM employee
WHERE department_id = (
    SELECT department_id
    FROM employee
    WHERE name = 'Meera'
);
```

To exclude Meera:

```sql
SELECT *
FROM employee
WHERE department_id = (
    SELECT department_id
    FROM employee
    WHERE name = 'Meera'
)
AND name <> 'Meera';
```

---

# 29. JOIN vs Subquery

Consider this requirement:

> Get employees who belong to Engineering.

## Using JOIN

```sql
SELECT e.*
FROM employee e
INNER JOIN department d
    ON e.department_id = d.id
WHERE d.name = 'Engineering';
```

## Using subquery

```sql
SELECT *
FROM employee
WHERE department_id = (
    SELECT id
    FROM department
    WHERE name = 'Engineering'
);
```

Both can be correct.

---

# 30. When Should I Use JOIN?

A `JOIN` is usually a good choice when:

- You need columns from multiple tables.
- You need to combine related data.
- Relationships between tables are central to the query.
- The query is easier to understand as table relationships.

Example:

```sql
SELECT
    e.name,
    d.name
FROM employee e
JOIN department d
    ON e.department_id = d.id;
```

You need data from both tables, so a join is natural.

---

# 31. When Should I Use a Subquery?

A subquery is often useful when:

- You need the result of one query as a condition for another.
- You need an aggregate such as `AVG`, `MAX`, or `COUNT`.
- You are performing an existence check.
- The nested form makes the query easier to understand.

Example:

```sql
SELECT *
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);
```

---

# 32. JOIN vs EXISTS

Requirement:

> Find departments that contain at least one employee.

Using JOIN:

```sql
SELECT DISTINCT d.*
FROM department d
JOIN employee e
    ON e.department_id = d.id;
```

Using EXISTS:

```sql
SELECT *
FROM department d
WHERE EXISTS (
    SELECT 1
    FROM employee e
    WHERE e.department_id = d.id
);
```

`EXISTS` clearly expresses the intention:

> Return the department if at least one matching employee exists.

---

# 33. JOIN Summary

| Join | Returns |
|---|---|
| `INNER JOIN` | Matching rows only |
| `LEFT JOIN` | All left rows + matching right rows |
| `RIGHT JOIN` | All right rows + matching left rows |
| `FULL OUTER JOIN` | All matching and non-matching rows |
| `CROSS JOIN` | Every possible combination |
| `SELF JOIN` | A table joined to itself |

---

# 34. Subquery Operators

| Operator | Purpose |
|---|---|
| `=` | Compare with one value |
| `>` | Greater than one result |
| `<` | Less than one result |
| `IN` | Match one of several values |
| `NOT IN` | Exclude several values |
| `EXISTS` | Check whether matching rows exist |
| `NOT EXISTS` | Check whether matching rows do not exist |
| `ANY` | Compare against any returned value |
| `ALL` | Compare against all returned values |

---

# 35. ANY Example

```sql
SELECT *
FROM employee
WHERE salary > ANY (
    SELECT salary
    FROM employee
    WHERE department_id = 2
);
```

This means:

> Salary must be greater than at least one salary returned by the subquery.

---

# 36. ALL Example

```sql
SELECT *
FROM employee
WHERE salary > ALL (
    SELECT salary
    FROM employee
    WHERE department_id = 2
);
```

This means:

> Salary must be greater than every salary returned by the subquery.

---

# 37. Common Mistakes

## Mistake 1: Missing JOIN condition

Incorrect:

```sql
SELECT *
FROM employee e
JOIN department d;
```

This can produce an unintended Cartesian product.

Correct:

```sql
SELECT *
FROM employee e
JOIN department d
    ON e.department_id = d.id;
```

---

## Mistake 2: Ambiguous column name

Incorrect:

```sql
SELECT id, name
FROM employee
JOIN department
    ON department_id = id;
```

Both tables may contain `id` and `name`.

Better:

```sql
SELECT
    e.id,
    e.name,
    d.name AS department_name
FROM employee e
JOIN department d
    ON e.department_id = d.id;
```

---

## Mistake 3: Using `=` for multiple subquery results

Incorrect:

```sql
SELECT *
FROM employee
WHERE department_id = (
    SELECT id
    FROM department
);
```

If multiple department IDs are returned, this fails.

Use:

```sql
SELECT *
FROM employee
WHERE department_id IN (
    SELECT id
    FROM department
);
```

---

## Mistake 4: Using NOT IN with NULL values

This may produce surprising results:

```sql
SELECT *
FROM employee
WHERE department_id NOT IN (
    SELECT department_id
    FROM some_table
);
```

If the subquery returns a `NULL`, the comparison may become unknown.

Prefer `NOT EXISTS` when appropriate.

---

# 38. Performance Notes

There is no universal rule that:

```text
JOIN is always faster than a subquery
```

or:

```text
Subquery is always faster than JOIN
```

Modern database optimizers can often transform queries internally.

Performance depends on:

- Table size
- Indexes
- Join columns
- Filtering
- Data distribution
- Database engine
- Query execution plan

Always inspect the execution plan for performance-sensitive SQL.

In PostgreSQL, a useful command is:

```sql
EXPLAIN ANALYZE
SELECT ...
```

---

# 39. Useful Index for JOINs

If this relationship is frequently queried:

```sql
employee.department_id = department.id
```

an index on the foreign-key column can help:

```sql
CREATE INDEX idx_employee_department_id
ON employee(department_id);
```

Primary keys such as:

```sql
department.id
```

are generally already indexed.

---

# 40. Practical Examples

## Find every employee and department

```sql
SELECT
    e.name,
    d.name AS department
FROM employee e
LEFT JOIN department d
    ON e.department_id = d.id;
```

---

## Find only employees with departments

```sql
SELECT
    e.name,
    d.name AS department
FROM employee e
INNER JOIN department d
    ON e.department_id = d.id;
```

---

## Find employees without departments

```sql
SELECT
    e.name
FROM employee e
LEFT JOIN department d
    ON e.department_id = d.id
WHERE d.id IS NULL;
```

---

## Find departments without employees

```sql
SELECT d.*
FROM department d
WHERE NOT EXISTS (
    SELECT 1
    FROM employee e
    WHERE e.department_id = d.id
);
```

---

## Find highest-paid employees

```sql
SELECT *
FROM employee
WHERE salary = (
    SELECT MAX(salary)
    FROM employee
);
```

---

## Find employees above company average

```sql
SELECT *
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);
```

---

## Find employees above their department average

```sql
SELECT e.*
FROM employee e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employee e2
    WHERE e2.department_id = e.department_id
);
```

---

## Count employees per department

Using JOIN:

```sql
SELECT
    d.name,
    COUNT(e.id) AS employee_count
FROM department d
LEFT JOIN employee e
    ON e.department_id = d.id
GROUP BY d.id, d.name;
```

Using a subquery:

```sql
SELECT
    d.name,
    (
        SELECT COUNT(*)
        FROM employee e
        WHERE e.department_id = d.id
    ) AS employee_count
FROM department d;
```

---

# 41. Visual JOIN Reference

Imagine two sets:

```text
Employee        Department
   A                B
```

### INNER JOIN

```text
Only A ∩ B
```

Only matching records.

### LEFT JOIN

```text
All A + matching B
```

### RIGHT JOIN

```text
All B + matching A
```

### FULL OUTER JOIN

```text
All A + All B
```

---

# 42. Interview Questions

### 1. What is a JOIN?

A JOIN combines rows from two or more tables using a related column.

### 2. What is the difference between INNER JOIN and LEFT JOIN?

`INNER JOIN` returns only matching rows.

`LEFT JOIN` returns every row from the left table even when there is no match.

### 3. What is a subquery?

A query written inside another SQL query.

### 4. What is a correlated subquery?

A subquery that references data from the outer query.

### 5. What is the difference between IN and EXISTS?

`IN` compares a value against a collection of returned values.

`EXISTS` checks whether at least one matching row exists.

### 6. What is a SELF JOIN?

A table joined with itself, often used for hierarchical relationships.

### 7. What is a CROSS JOIN?

A join that produces every possible combination of rows from two tables.

### 8. Can a subquery return multiple rows?

Yes. Operators such as `IN`, `ANY`, and `ALL` can work with multiple-row subqueries.

### 9. Can a subquery be used in SELECT?

Yes.

```sql
SELECT
    name,
    (SELECT AVG(salary) FROM employee)
FROM employee;
```

### 10. Is JOIN always faster than a subquery?

No. Performance depends on the database optimizer, indexes, data volume, and query structure.

---

# 43. Practice Questions

Try writing SQL for the following.

1. Display every employee with their department name.
2. Display employees who do not have a department.
3. Display departments with no employees.
4. Find the highest-paid employee.
5. Find employees earning more than the company average.
6. Find employees earning more than their department average.
7. Display employee names and manager names using a self join.
8. Find all employees working in Engineering using a subquery.
9. Count employees in each department.
10. Find the second-highest salary.
11. Find departments that contain at least one employee using `EXISTS`.
12. Find employees who belong to Engineering or Finance using `IN`.
13. Display all departments even if they have zero employees.
14. Find employees whose salary is higher than all employees in HR.
15. Join Employee, EmployeeRole, and Role to display each employee's roles.

---

# 44. Quick Cheat Sheet

```sql
-- INNER JOIN
SELECT *
FROM a
JOIN b ON a.id = b.a_id;
```

```sql
-- LEFT JOIN
SELECT *
FROM a
LEFT JOIN b ON a.id = b.a_id;
```

```sql
-- RIGHT JOIN
SELECT *
FROM a
RIGHT JOIN b ON a.id = b.a_id;
```

```sql
-- FULL OUTER JOIN
SELECT *
FROM a
FULL OUTER JOIN b ON a.id = b.a_id;
```

```sql
-- CROSS JOIN
SELECT *
FROM a
CROSS JOIN b;
```

```sql
-- Basic subquery
SELECT *
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);
```

```sql
-- IN
SELECT *
FROM employee
WHERE department_id IN (
    SELECT id
    FROM department
);
```

```sql
-- EXISTS
SELECT *
FROM department d
WHERE EXISTS (
    SELECT 1
    FROM employee e
    WHERE e.department_id = d.id
);
```

```sql
-- NOT EXISTS
SELECT *
FROM department d
WHERE NOT EXISTS (
    SELECT 1
    FROM employee e
    WHERE e.department_id = d.id
);
```

---

# Key Takeaways

- Use **JOINs** to combine related data from multiple tables.
- Use **INNER JOIN** when only matching records are required.
- Use **LEFT JOIN** when every row from the main table must be retained.
- Use **SELF JOIN** for hierarchical relationships such as employee-manager.
- Use **subqueries** when the result of one query is needed by another query.
- Use `IN` when multiple values can be returned.
- Use `EXISTS` and `NOT EXISTS` for existence checks.
- A **correlated subquery** depends on the current row of the outer query.
- Do not assume joins are always faster than subqueries.
- Use indexes and execution plans when optimizing database queries.
