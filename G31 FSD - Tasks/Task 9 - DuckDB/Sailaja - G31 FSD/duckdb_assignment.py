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

result = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
""").df()

print("All Employees\n")
print(result)

high_salary = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE salary > 50000
""").df()

print("\nEmployees with Salary > 50000\n")
print(high_salary)

it_employees = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department='IT'
""").df()

print("\nIT Department Employees\n")
print(it_employees)

delhi = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE city='Delhi'
""").df()

print("\nEmployees from Delhi\n")
print(delhi)

it_high = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department='IT'
AND salary > 65000
""").df()

print("\nIT Employees with Salary > 65000\n")
print(it_high)

selected = duckdb.sql("""
SELECT
name,
department,
salary
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
""").df()

print("\nSelected Columns\n")
print(selected)

summary = duckdb.sql("""
SELECT
COUNT(*) AS employee_count,
AVG(salary) AS average_salary,
MAX(salary) AS maximum_salary,
MIN(salary) AS minimum_salary,
SUM(salary) AS total_salary
FROM read_parquet('employees.parquet')
""").df()

print("\nSummary Statistics\n")
print(summary)

department = duckdb.sql("""
SELECT
department,
COUNT(*) AS employee_count,
AVG(salary) AS average_salary,
MAX(salary) AS highest_salary,
SUM(salary) AS total_salary
FROM read_parquet('employees.parquet')
GROUP BY department
ORDER BY average_salary DESC
""").df()

print("\nDepartment Summary\n")
print(department)

connection = duckdb.connect("company.duckdb")

connection.execute("""
CREATE OR REPLACE TABLE employees AS
SELECT *
FROM read_parquet('employees.parquet')
""")

table = connection.execute("""
SELECT *
FROM employees
""").df()

print("\nEmployees Table in DuckDB\n")
print(table)

duckdb.sql("""
COPY (
SELECT *
FROM read_parquet('employees.parquet')
WHERE salary > 50000
)
TO 'high_salary_employees.parquet'
(FORMAT PARQUET)
""")

print("\nhigh_salary_employees.parquet created successfully.\n")

verify = duckdb.sql("""
SELECT *
FROM read_parquet('high_salary_employees.parquet')
""").df()

print("Contents of high_salary_employees.parquet\n")
print(verify)

second = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
LIMIT 1 OFFSET 1
""").df()

print("\nSecond Highest Salary\n")
print(second)

top3 = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
LIMIT 3
""").df()

print("\nTop Three Highest Paid Employees\n")
print(top3)

city = duckdb.sql("""
SELECT
city,
AVG(salary) AS average_salary
FROM read_parquet('employees.parquet')
GROUP BY city
""").df()

print("\nAverage Salary by City\n")
print(city)

avg = duckdb.sql("""
SELECT
department,
AVG(salary) AS average_salary
FROM read_parquet('employees.parquet')
GROUP BY department
HAVING AVG(salary) > 55000
""").df()

print("\nDepartments with Average Salary > 55000\n")
print(avg)

category = duckdb.sql("""
SELECT
name,
salary,
CASE
WHEN salary >= 65000 THEN 'High'
WHEN salary >= 50000 THEN 'Medium'
ELSE 'Low'
END AS salary_category
FROM read_parquet('employees.parquet')
""").df()

print("\nSalary Category\n")
print(category)

connection.close()