# Subqueries in SQL

A **subquery** is a SQL query written **inside another SQL query**.

The inner query produces a result, and the outer query uses that result.

## Basic Syntax

```sql
SELECT column_name
FROM table_name
WHERE column_name = (
    SELECT column_name
    FROM another_table
    WHERE condition
);
```

---

# Example Tables

## Employees

| id | name | salary | dept_id |
|---:|------|-------:|--------:|
| 1 | Rahul | 50000 | 10 |
| 2 | Priya | 70000 | 20 |
| 3 | Amit | 60000 | 10 |
| 4 | Neha | 80000 | 20 |

## Departments

| id | name |
|---:|------|
| 10 | IT |
| 20 | Sales |
| 30 | Finance |

---

# 1. Single-Row Subquery

A **single-row subquery** returns only one value or one row.

### Example

Find employees earning more than the average salary.

```sql
SELECT name, salary
FROM Employees
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees
);
```

The inner query is:

```sql
SELECT AVG(salary)
FROM Employees;
```

It returns:

```text
65000
```

So the outer query effectively becomes:

```sql
SELECT name, salary
FROM Employees
WHERE salary > 65000;
```

### Result

| name | salary |
|------|-------:|
| Priya | 70000 |
| Neha | 80000 |

---

# 2. Subquery with `IN`

Use `IN` when the subquery can return **multiple values**.

### Example

Find employees who belong to IT or Sales departments.

```sql
SELECT name
FROM Employees
WHERE dept_id IN (
    SELECT id
    FROM Departments
    WHERE name IN ('IT', 'Sales')
);
```

The inner query returns:

```text
10
20
```

So SQL checks:

```sql
WHERE dept_id IN (10, 20)
```

---

# 3. Subquery with `NOT IN`

`NOT IN` is used when we want to exclude values returned by a subquery.

### Example

Find employees who are not in the Sales department.

```sql
SELECT name
FROM Employees
WHERE dept_id NOT IN (
    SELECT id
    FROM Departments
    WHERE name = 'Sales'
);
```

The inner query returns:

```text
20
```

So SQL effectively checks:

```sql
WHERE dept_id NOT IN (20)
```

---

# 4. Subquery with `MAX()`

### Example

Find the employee with the highest salary.

```sql
SELECT name, salary
FROM Employees
WHERE salary = (
    SELECT MAX(salary)
    FROM Employees
);
```

The inner query:

```sql
SELECT MAX(salary)
FROM Employees;
```

returns:

```text
80000
```

### Result

| name | salary |
|------|-------:|
| Neha | 80000 |

---

# 5. Subquery with `MIN()`

### Example

Find the employee with the lowest salary.

```sql
SELECT name, salary
FROM Employees
WHERE salary = (
    SELECT MIN(salary)
    FROM Employees
);
```

### Result

| name | salary |
|------|-------:|
| Rahul | 50000 |

---

# 6. Subquery Inside `SELECT`

A subquery can also be written inside the `SELECT` clause.

### Example

Display every employee along with the overall average salary.

```sql
SELECT
    name,
    salary,
    (SELECT AVG(salary) FROM Employees) AS average_salary
FROM Employees;
```

### Result

| name | salary | average_salary |
|------|-------:|---------------:|
| Rahul | 50000 | 65000 |
| Priya | 70000 | 65000 |
| Amit | 60000 | 65000 |
| Neha | 80000 | 65000 |

---

# 7. Subquery Inside `FROM`

A subquery inside `FROM` behaves like a temporary table.

It is also called a **derived table**.

### Example

Calculate the average salary for each department.

```sql
SELECT dept_id, avg_salary
FROM (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM Employees
    GROUP BY dept_id
) AS dept_average;
```

The inner query creates a temporary result:

| dept_id | avg_salary |
|--------:|-----------:|
| 10 | 55000 |
| 20 | 75000 |

The outer query then reads from this result.

---

# 8. Correlated Subquery

A **correlated subquery** depends on the current row of the outer query.

### Example

Find employees earning more than the average salary of their own department.

```sql
SELECT e1.name, e1.salary, e1.dept_id
FROM Employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM Employees e2
    WHERE e2.dept_id = e1.dept_id
);
```

The important condition is:

```sql
WHERE e2.dept_id = e1.dept_id
```

The inner query uses a value from the outer query.

### Department 10

```text
Rahul = 50000
Amit  = 60000

Average = 55000
```

Amit earns more than the department average.

### Department 20

```text
Priya = 70000
Neha  = 80000

Average = 75000
```

Neha earns more than the department average.

### Result

| name | salary | dept_id |
|------|-------:|--------:|
| Amit | 60000 | 10 |
| Neha | 80000 | 20 |

---

# 9. Subquery with `EXISTS`

`EXISTS` checks whether the subquery returns **at least one row**.

### Example

Find departments that have at least one employee.

```sql
SELECT d.name
FROM Departments d
WHERE EXISTS (
    SELECT 1
    FROM Employees e
    WHERE e.dept_id = d.id
);
```

`EXISTS` only checks whether a matching row exists.

That is why we commonly write:

```sql
SELECT 1
```

The actual value selected is not important.

---

# 10. Subquery with `NOT EXISTS`

`NOT EXISTS` checks whether no matching rows exist.

### Example

Find departments that have no employees.

```sql
SELECT d.name
FROM Departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM Employees e
    WHERE e.dept_id = d.id
);
```

### Result

```text
Finance
```

---

# 11. Nested Subqueries

A subquery can contain another subquery.

### Example

```sql
SELECT name
FROM Employees
WHERE dept_id = (
    SELECT id
    FROM Departments
    WHERE name = (
        SELECT department_name
        FROM Settings
        WHERE setting_id = 1
    )
);
```

Structure:

```text
Outer Query
    ↓
Subquery
    ↓
Another Subquery
```

This is called a **nested subquery**.

---

# `=` vs `IN`

This is an important difference.

## Use `=` when the subquery returns one value

```sql
SELECT name
FROM Employees
WHERE salary = (
    SELECT MAX(salary)
    FROM Employees
);
```

## Use `IN` when the subquery can return multiple values

```sql
SELECT name
FROM Employees
WHERE dept_id IN (
    SELECT id
    FROM Departments
);
```

If a subquery returns multiple rows, using `=` will usually cause an error.

---

# Second Highest Salary Using a Subquery

This is a common SQL interview question.

```sql
SELECT MAX(salary)
FROM Employees
WHERE salary < (
    SELECT MAX(salary)
    FROM Employees
);
```

### How it works

First, the inner query finds the highest salary:

```sql
SELECT MAX(salary)
FROM Employees;
```

Result:

```text
80000
```

Then the outer query finds the maximum salary below `80000`.

```sql
SELECT MAX(salary)
FROM Employees
WHERE salary < 80000;
```

Result:

```text
70000
```

So the second-highest salary is:

```text
70000
```

---

# Quick Summary

| Subquery Type | Purpose |
|---------------|---------|
| Single-row subquery | Returns one value |
| Multi-row subquery | Returns multiple values |
| `IN` | Checks against multiple returned values |
| `NOT IN` | Excludes returned values |
| `SELECT` subquery | Adds a calculated value |
| `FROM` subquery | Creates a temporary result table |
| Correlated subquery | Depends on the outer query |
| `EXISTS` | Checks whether matching rows exist |
| `NOT EXISTS` | Checks whether matching rows do not exist |
| Nested subquery | A subquery inside another subquery |

---

# Easy Way to Remember

> **Subquery = Query inside another Query**

Example:

```sql
SELECT name
FROM Employees
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees
);
```

Execution:

```text
Step 1:
Find average salary

        ↓

      65000

Step 2:
Find employees whose salary > 65000

        ↓

   Priya, Neha
```
