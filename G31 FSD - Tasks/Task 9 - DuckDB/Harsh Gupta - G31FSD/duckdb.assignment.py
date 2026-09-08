import pandas as pd
import duckdb

data = {
    "employee_id": [1, 2, 3, 4, 5, 6, 7, 8],
    "name": [
        "Asha",
        "Rahul",
        "Neha",
        "Vikram",
        "Priya",
        "Arjun",
        "Meera",
        "Karan"
    ],
    "department": [
        "IT",
        "HR",
        "IT",
        "Finance",
        "HR",
        "Finance",
        "IT",
        "Sales"
    ],
    "salary": [
        60000,
        45000,
        70000,
        55000,
        48000,
        65000,
        75000,
        50000
    ],
    "city": [
        "Delhi",
        "Mumbai",
        "Bengaluru",
        "Delhi",
        "Mumbai",
        "Chennai",
        "Bengaluru",
        "Delhi"
    ]
}

df = pd.DataFrame(data)

df.to_parquet("employees.parquet", index=False)

print("employees.parquet created successfully.\n")

print("Task 2: All Employees")
result = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
""").df()

print(result)

print("\nEmployees with salary > 50000")
print(duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE salary > 50000
""").df())

print("\nEmployees in IT department")
print(duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department = 'IT'
""").df())

print("\nEmployees working in Delhi")
print(duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE city = 'Delhi'
""").df())

print("\nIT employees with salary > 65000")
print(duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department = 'IT'
AND salary > 65000
""").df())

print("\nSelected Columns")
print(duckdb.sql("""
SELECT
    name,
    department,
    salary
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
""").df())

print("\nSummary Statistics")
print(duckdb.sql("""
SELECT
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary,
    MAX(salary) AS maximum_salary,
    MIN(salary) AS minimum_salary,
    SUM(salary) AS total_salary
FROM read_parquet('employees.parquet')
""").df())

print("\nDepartment Summary")
print(duckdb.sql("""
SELECT
    department,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary,
    MAX(salary) AS highest_salary,
    SUM(salary) AS total_salary
FROM read_parquet('employees.parquet')
GROUP BY department
ORDER BY average_salary DESC
""").df())

connection = duckdb.connect("company.duckdb")

connection.execute("""
CREATE OR REPLACE TABLE employees AS
SELECT *
FROM read_parquet('employees.parquet')
""")

print("\nEmployees Table in company.duckdb")
print(connection.execute("""
SELECT *
FROM employees
""").df())

connection.close()

duckdb.sql("""
COPY (
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE salary > 50000
)
TO 'high_salary_employees.parquet'
(FORMAT PARQUET)
""")

print("\nhigh_salary_employees.parquet created successfully.")

print("\nContents of high_salary_employees.parquet")
print(duckdb.sql("""
SELECT *
FROM read_parquet('high_salary_employees.parquet')
""").df())

print("\nSecond Highest Salary")
print(duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
LIMIT 1 OFFSET 1
""").df())

print("\nTop 3 Highest Paid Employees")
print(duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
LIMIT 3
""").df())

print("\nAverage Salary by City")
print(duckdb.sql("""
SELECT
    city,
    AVG(salary) AS average_salary
FROM read_parquet('employees.parquet')
GROUP BY city
ORDER BY average_salary DESC
""").df())

print("\nDepartments with Average Salary > 55000")
print(duckdb.sql("""
SELECT
    department,
    AVG(salary) AS average_salary
FROM read_parquet('employees.parquet')
GROUP BY department
HAVING AVG(salary) > 55000
""").df())

print("\nSalary Categories")
print(duckdb.sql("""
SELECT
    name,
    salary,
    CASE
        WHEN salary >= 65000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category
FROM read_parquet('employees.parquet')
""").df())
