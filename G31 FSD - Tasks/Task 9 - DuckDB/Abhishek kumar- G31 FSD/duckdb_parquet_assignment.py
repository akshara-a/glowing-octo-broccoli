"""
DuckDB Assignment Using Parquet
Complete solution for all tasks (1-9) + Bonus tasks
"""

import pandas as pd
import duckdb

print("=" * 60)
print("TASK 1: Create the Parquet File")
print("=" * 60)

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
print("Parquet file created successfully.\n")


print("=" * 60)
print("TASK 2: Read Parquet Using DuckDB")
print("=" * 60)

result = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
""").df()
print(result, "\n")


print("=" * 60)
print("TASK 3: Filter Employee Records")
print("=" * 60)

print("-- Employees with salary > 50000 --")
high_salary = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE salary > 50000
""").df()
print(high_salary, "\n")

print("-- Employees from IT department --")
it_dept = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE department = 'IT'
""").df()
print(it_dept, "\n")

print("-- Employees who work in Delhi --")
delhi_emp = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE city = 'Delhi'
""").df()
print(delhi_emp, "\n")

print("-- IT department employees with salary > 65000 --")
it_high_salary = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE department = 'IT' AND salary > 65000
""").df()
print(it_high_salary, "\n")


print("=" * 60)
print("TASK 4: Select Specific Columns (sorted by salary DESC)")
print("=" * 60)

selected_cols = duckdb.sql("""
    SELECT name, department, salary
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
""").df()
print(selected_cols, "\n")


print("=" * 60)
print("TASK 5: Perform Aggregations")
print("=" * 60)

summary = duckdb.sql("""
    SELECT
        COUNT(*) AS employee_count,
        AVG(salary) AS average_salary,
        MAX(salary) AS maximum_salary,
        MIN(salary) AS minimum_salary,
        SUM(salary) AS total_salary
    FROM read_parquet('employees.parquet')
""").df()
print(summary, "\n")


print("=" * 60)
print("TASK 6: Group Data by Department")
print("=" * 60)

dept_summary = duckdb.sql("""
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
print(dept_summary, "\n")


print("=" * 60)
print("TASK 7: Create a DuckDB Table (company.duckdb)")
print("=" * 60)

connection = duckdb.connect("company.duckdb")

connection.execute("""
    CREATE OR REPLACE TABLE employees AS
    SELECT *
    FROM read_parquet('employees.parquet')
""")

result = connection.execute("""
    SELECT *
    FROM employees
""").df()

print(result, "\n")
connection.close()


print("=" * 60)
print("TASK 8: Export Query Results to Parquet")
print("=" * 60)

duckdb.sql("""
    COPY (
        SELECT *
        FROM read_parquet('employees.parquet')
        WHERE salary > 50000
    )
    TO 'high_salary_employees.parquet'
    (FORMAT PARQUET)
""")
print("Filtered Parquet file created.\n")


print("=" * 60)
print("TASK 9: Verify the Exported File")
print("=" * 60)

result = duckdb.sql("""
    SELECT *
    FROM read_parquet('high_salary_employees.parquet')
""").df()
print(result, "\n")


print("=" * 60)
print("BONUS TASKS")
print("=" * 60)

print("-- 1. Employee with the second-highest salary --")
second_highest = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
""").df()
print(second_highest, "\n")

print("-- 2. Top three highest-paid employees --")
top_three = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
    LIMIT 3
""").df()
print(top_three, "\n")

print("-- 3. Average salary for each city --")
avg_by_city = duckdb.sql("""
    SELECT
        city,
        AVG(salary) AS average_salary
    FROM read_parquet('employees.parquet')
    GROUP BY city
    ORDER BY average_salary DESC
""").df()
print(avg_by_city, "\n")

print("-- 4. Departments with average salary > 55000 --")
dept_above_55k = duckdb.sql("""
    SELECT
        department,
        AVG(salary) AS average_salary
    FROM read_parquet('employees.parquet')
    GROUP BY department
    HAVING AVG(salary) > 55000
    ORDER BY average_salary DESC
""").df()
print(dept_above_55k, "\n")

print("-- 5. Calculated column: salary_category --")
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
    ORDER BY salary DESC
""").df()
print(salary_category, "\n")

print("=" * 60)
print("ALL TASKS COMPLETED SUCCESSFULLY")
print("=" * 60)
