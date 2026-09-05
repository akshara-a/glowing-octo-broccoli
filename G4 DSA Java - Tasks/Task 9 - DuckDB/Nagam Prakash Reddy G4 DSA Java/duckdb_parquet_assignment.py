import pandas as pd
import duckdb


# ============================================================
# TASK 1: Create DataFrame and Save as Parquet
# ============================================================

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

df.to_parquet(
    "employees.parquet",
    index=False
)

print("================================================")
print("TASK 1: Parquet File Created")
print("================================================")
print("employees.parquet created successfully.\n")


# ============================================================
# TASK 2: Read Parquet Using DuckDB
# ============================================================

result = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
""").df()

print("================================================")
print("TASK 2: All Employee Records")
print("================================================")
print(result)
print()


# ============================================================
# TASK 3: Filter Employee Records
# ============================================================

# 3.1 Salary greater than 50000

high_salary = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE salary > 50000
""").df()

print("================================================")
print("TASK 3.1: Salary Greater Than 50000")
print("================================================")
print(high_salary)
print()


# 3.2 Employees from IT department

it_employees = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE department = 'IT'
""").df()

print("================================================")
print("TASK 3.2: IT Department Employees")
print("================================================")
print(it_employees)
print()


# 3.3 Employees from Delhi

delhi_employees = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE city = 'Delhi'
""").df()

print("================================================")
print("TASK 3.3: Employees From Delhi")
print("================================================")
print(delhi_employees)
print()


# 3.4 IT employees with salary greater than 65000

it_high_salary = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE department = 'IT'
      AND salary > 65000
""").df()

print("================================================")
print("TASK 3.4: IT Employees With Salary > 65000")
print("================================================")
print(it_high_salary)
print()


# ============================================================
# TASK 4: Select Specific Columns and Sort
# ============================================================

selected_columns = duckdb.sql("""
    SELECT
        name,
        department,
        salary
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
""").df()

print("================================================")
print("TASK 4: Name, Department and Salary")
print("Sorted by Salary - Highest to Lowest")
print("================================================")
print(selected_columns)
print()


# ============================================================
# TASK 5: Perform Aggregations
# ============================================================

summary = duckdb.sql("""
    SELECT
        COUNT(*) AS employee_count,
        AVG(salary) AS average_salary,
        MAX(salary) AS maximum_salary,
        MIN(salary) AS minimum_salary,
        SUM(salary) AS total_salary
    FROM read_parquet('employees.parquet')
""").df()

print("================================================")
print("TASK 5: Employee Salary Summary")
print("================================================")
print(summary)
print()


# ============================================================
# TASK 6: Group Data By Department
# ============================================================

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

print("================================================")
print("TASK 6: Department Summary")
print("================================================")
print(department_summary)
print()


# ============================================================
# TASK 7: Create DuckDB Database and Table
# ============================================================

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

print("================================================")
print("TASK 7: Employees Table From DuckDB")
print("================================================")
print(result)
print()

connection.close()

print("company.duckdb created successfully.\n")


# ============================================================
# TASK 8: Export Query Results to Parquet
# ============================================================

duckdb.sql("""
    COPY (
        SELECT *
        FROM read_parquet('employees.parquet')
        WHERE salary > 50000
    )
    TO 'high_salary_employees.parquet'
    (FORMAT PARQUET)
""")

print("================================================")
print("TASK 8: Export Filtered Data")
print("================================================")
print("high_salary_employees.parquet created successfully.\n")


# ============================================================
# TASK 9: Verify Exported Parquet File
# ============================================================

exported_data = duckdb.sql("""
    SELECT *
    FROM read_parquet('high_salary_employees.parquet')
""").df()

print("================================================")
print("TASK 9: Verify High Salary Parquet File")
print("================================================")
print(exported_data)
print()


# ============================================================
# BONUS 1: Second Highest Salary
# ============================================================

second_highest = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
""").df()

print("================================================")
print("BONUS 1: Second Highest Salary")
print("================================================")
print(second_highest)
print()


# ============================================================
# BONUS 2: Top Three Highest Paid Employees
# ============================================================

top_three = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
    LIMIT 3
""").df()

print("================================================")
print("BONUS 2: Top Three Highest Paid Employees")
print("================================================")
print(top_three)
print()


# ============================================================
# BONUS 3: Average Salary For Each City
# ============================================================

city_salary = duckdb.sql("""
    SELECT
        city,
        COUNT(*) AS employee_count,
        AVG(salary) AS average_salary
    FROM read_parquet('employees.parquet')
    GROUP BY city
    ORDER BY average_salary DESC
""").df()

print("================================================")
print("BONUS 3: Average Salary By City")
print("================================================")
print(city_salary)
print()


# ============================================================
# BONUS 4: Departments With Average Salary > 55000
# ============================================================

departments_above_55000 = duckdb.sql("""
    SELECT
        department,
        AVG(salary) AS average_salary
    FROM read_parquet('employees.parquet')
    GROUP BY department
    HAVING AVG(salary) > 55000
    ORDER BY average_salary DESC
""").df()

print("================================================")
print("BONUS 4: Departments With Average Salary > 55000")
print("================================================")
print(departments_above_55000)
print()


# ============================================================
# BONUS 5: Salary Category
# ============================================================

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

print("================================================")
print("BONUS 5: Salary Category")
print("================================================")
print(salary_category)
print()


# ============================================================
# PROGRAM COMPLETED
# ============================================================

print("================================================")
print("All DuckDB + Parquet Tasks Completed Successfully!")
print("================================================")