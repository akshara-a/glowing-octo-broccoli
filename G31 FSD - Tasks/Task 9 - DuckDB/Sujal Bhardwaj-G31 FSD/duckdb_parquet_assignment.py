import pandas as pd
import duckdb

# ==================================================
# Task 1: Create DataFrame
# ==================================================

data = {
    "employee_id": [1,2,3,4,5,6,7,8],
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

print("===== Employee Data =====")
print(df)

# Save as Parquet

df.to_parquet(
    "employees.parquet",
    index=False
)

print("\nemployees.parquet created successfully.")

# ==================================================
# Task 2: Read Parquet using DuckDB
# ==================================================

print("\n===== Reading Parquet File =====")

result = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
""").df()

print(result)

# ==================================================
# Task 3: Filtering
# ==================================================

print("\n===== Salary > 50000 =====")

high_salary = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE salary > 50000
""").df()

print(high_salary)

print("\n===== IT Department =====")

it = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department='IT'
""").df()

print(it)

print("\n===== Employees in Delhi =====")

delhi = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE city='Delhi'
""").df()

print(delhi)

print("\n===== IT Employees with Salary >65000 =====")

it_high = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department='IT'
AND salary>65000
""").df()

print(it_high)

# ==================================================
# Task 4: Select Specific Columns
# ==================================================

print("\n===== Name Department Salary =====")

selected = duckdb.sql("""
SELECT
    name,
    department,
    salary
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
""").df()

print(selected)

# ==================================================
# Task 5: Aggregation
# ==================================================

print("\n===== Summary =====")

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

# ==================================================
# Task 6: Group By
# ==================================================

print("\n===== Department Summary =====")

grouped = duckdb.sql("""

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

print(grouped)

# ==================================================
# Task 7: DuckDB Database
# ==================================================

connection = duckdb.connect("company.duckdb")

connection.execute("""

CREATE OR REPLACE TABLE employees AS

SELECT *

FROM read_parquet('employees.parquet')

""")

print("\n===== Employees Table =====")

print(connection.execute("SELECT * FROM employees").df())

connection.close()

# ==================================================
# Task 8: Export High Salary Employees
# ==================================================

duckdb.sql("""

COPY(

SELECT *

FROM read_parquet('employees.parquet')

WHERE salary>50000

)

TO 'high_salary_employees.parquet'

(FORMAT PARQUET)

""")

print("\nhigh_salary_employees.parquet created successfully.")

# ==================================================
# Task 9: Verify Export
# ==================================================

print("\n===== Exported Data =====")

verify = duckdb.sql("""

SELECT *

FROM read_parquet('high_salary_employees.parquet')

""").df()

print(verify)

# ==================================================
# Bonus Task 1
# ==================================================

print("\n===== Second Highest Salary =====")

second = duckdb.sql("""

SELECT *

FROM read_parquet('employees.parquet')

ORDER BY salary DESC

LIMIT 1 OFFSET 1

""").df()

print(second)

# ==================================================
# Bonus Task 2
# ==================================================

print("\n===== Top Three Salaries =====")

top3 = duckdb.sql("""

SELECT *

FROM read_parquet('employees.parquet')

ORDER BY salary DESC

LIMIT 3

""").df()

print(top3)

# ==================================================
# Bonus Task 3
# ==================================================

print("\n===== Average Salary by City =====")

city_avg = duckdb.sql("""

SELECT

city,

AVG(salary) AS average_salary

FROM read_parquet('employees.parquet')

GROUP BY city

""").df()

print(city_avg)

# ==================================================
# Bonus Task 4
# ==================================================

print("\n===== Departments Average Salary >55000 =====")

dept_avg = duckdb.sql("""

SELECT

department,

AVG(salary) AS average_salary

FROM read_parquet('employees.parquet')

GROUP BY department

HAVING AVG(salary)>55000

""").df()

print(dept_avg)

# ==================================================
# Bonus Task 5
# ==================================================

print("\n===== Salary Category =====")

category = duckdb.sql("""

SELECT

name,

salary,

CASE

WHEN salary>=65000 THEN 'High'

WHEN salary>=50000 THEN 'Medium'

ELSE 'Low'

END AS salary_category

FROM read_parquet('employees.parquet')

""").df()

print(category)