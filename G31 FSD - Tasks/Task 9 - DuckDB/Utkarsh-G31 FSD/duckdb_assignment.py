import pandas as pd
import duckdb

# Task 1: Create DataFrame
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
print("Employees Parquet file created successfully.\n")

# Task 2: Read Parquet
print("All Employees:")
result = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
""").df()
print(result)


# Task 3: Filter Records
print("\nEmployees with salary > 50000")
print(duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE salary > 50000
""").df())

print("\nEmployees in IT Department")
print(duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department='IT'
""").df())

print("\nEmployees from Delhi")
print(duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE city='Delhi'
""").df())

print("\nIT Employees with salary > 65000")
print(duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department='IT'
AND salary>65000
""").df())



# Task 4: Select Columns
print("\nName, Department and Salary")
print(duckdb.sql("""
SELECT name, department, salary
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
""").df())


# Task 5: Aggregations
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


# Task 6: Group By Department
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


# Task 7: Create DuckDB Database
connection = duckdb.connect("company.duckdb")
connection.execute("""
CREATE OR REPLACE TABLE employees AS
SELECT *
FROM read_parquet('employees.parquet')
""")

print("\nEmployees Table from DuckDB")
print(connection.execute("""
SELECT *
FROM employees
""").df())

connection.close()


# Task 8: Export to Parquet
duckdb.sql("""
COPY(
SELECT *
FROM read_parquet('employees.parquet')
WHERE salary>50000
)
TO 'high_salary_employees.parquet'
(FORMAT PARQUET)
""")

print("\nFiltered Parquet File Created")


# Task 9: Verify Export
print("\nHigh Salary Employees")
print(duckdb.sql("""
SELECT *
FROM read_parquet('high_salary_employees.parquet')
""").df())


# Bonus 1
print("\nSecond Highest Salary")
print(duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
LIMIT 1 OFFSET 1
""").df())


# Bonus 2
print("\nTop Three Highest Paid Employees")
print(duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
LIMIT 3
""").df())


# Bonus 3
print("\nAverage Salary by City")
print(duckdb.sql("""
SELECT
city,
AVG(salary) AS average_salary
FROM read_parquet('employees.parquet')
GROUP BY city
""").df())


# Bonus 4
print("\nDepartments with Average Salary > 55000")
print(duckdb.sql("""
SELECT
department,
AVG(salary) AS average_salary
FROM read_parquet('employees.parquet')
GROUP BY department
HAVING AVG(salary)>55000
""").df())


# Bonus 5
print("\nSalary Category")
print(duckdb.sql("""
SELECT
name,
salary,
CASE
WHEN salary>=65000 THEN 'High'
WHEN salary>=50000 THEN 'Medium'
ELSE 'Low'
END AS salary_category
FROM read_parquet('employees.parquet')
""").df())