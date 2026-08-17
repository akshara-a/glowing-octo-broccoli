import pandas as pd
import duckdb

# =====================================================
# Task 1: Create DataFrame and Save as Parquet
# =====================================================

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

print("=" * 60)
print("Task 1: Parquet file created successfully")
print("=" * 60)

# =====================================================
# Task 2: Read Parquet Using DuckDB
# =====================================================

print("\nTask 2: All Employees")

result = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
""").df()

print(result)

# =====================================================
# Task 3: Filter Employee Records
# =====================================================

print("\nTask 3.1: Salary > 50000")

high_salary = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE salary > 50000
""").df()

print(high_salary)

print("\nTask 3.2: IT Department")

it_department = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department='IT'
""").df()

print(it_department)

print("\nTask 3.3: Employees in Delhi")

delhi = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE city='Delhi'
""").df()

print(delhi)

print("\nTask 3.4: IT Department with Salary > 65000")

it_high = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department='IT'
AND salary > 65000
""").df()

print(it_high)

# =====================================================
# Task 4: Select Specific Columns
# =====================================================

print("\nTask 4: Name, Department, Salary (Descending)")

selected = duckdb.sql("""
SELECT
    name,
    department,
    salary
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
""").df()

print(selected)

# =====================================================
# Task 5: Aggregations
# =====================================================

print("\nTask 5: Aggregate Summary")

summary = duckdb.sql("""
SELECT
COUNT(*) AS employee_count,
AVG(salary) AS average_salary,
MAX(salary) AS maximum_salary,
MIN(salary) AS minimum_salary,
SUM(salary) AS total_salary
FROM read_parquet('employees.parquet')
""").df()

print(summary)

# =====================================================
# Task 6: Group Data
# =====================================================

print("\nTask 6: Department Summary")

department_summary = duckdb.sql("""
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

print(department_summary)

# =====================================================
# Task 7: Create DuckDB Database and Table
# =====================================================

print("\nTask 7: Creating company.duckdb")

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

print(table)

connection.close()

# =====================================================
# Task 8: Export High Salary Employees
# =====================================================

print("\nTask 8: Exporting High Salary Employees")

duckdb.sql("""
COPY (
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE salary > 50000
)
TO 'high_salary_employees.parquet'
(FORMAT PARQUET)
""")

print("high_salary_employees.parquet created successfully.")

# =====================================================
# Task 9: Verify Exported File
# =====================================================

print("\nTask 9: Verify Exported Parquet")

verify = duckdb.sql("""
SELECT *
FROM read_parquet('high_salary_employees.parquet')
""").df()

print(verify)

# =====================================================
# Bonus Task 1
# Second Highest Salary
# =====================================================

print("\nBonus 1: Second Highest Salary")

second_highest = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
LIMIT 1 OFFSET 1
""").df()

print(second_highest)

# =====================================================
# Bonus Task 2
# Top Three Salaries
# =====================================================

print("\nBonus 2: Top Three Highest Paid Employees")

top_three = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
LIMIT 3
""").df()

print(top_three)

# =====================================================
# Bonus Task 3
# Average Salary by City
# =====================================================

print("\nBonus 3: Average Salary by City")

city_avg = duckdb.sql("""
SELECT
city,
AVG(salary) AS average_salary
FROM read_parquet('employees.parquet')
GROUP BY city
ORDER BY average_salary DESC
""").df()

print(city_avg)

# =====================================================
# Bonus Task 4
# Departments with Avg Salary > 55000
# =====================================================

print("\nBonus 4: Departments with Average Salary > 55000")

dept_avg = duckdb.sql("""
SELECT
department,
AVG(salary) AS average_salary
FROM read_parquet('employees.parquet')
GROUP BY department
HAVING AVG(salary) > 55000
""").df()

print(dept_avg)

# =====================================================
# Bonus Task 5
# Salary Category
# =====================================================

print("\nBonus 5: Salary Categories")

salary_category = duckdb.sql("""
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

print(salary_category)

print("\nAll tasks completed successfully!")