import pandas as pd
import duckdb

# ==========================================
# TASK 1: CREATE PARQUET FILE
# ==========================================

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

# Convert dictionary into DataFrame
df = pd.DataFrame(data)

# Save DataFrame as Parquet
df.to_parquet("employees.parquet", index=False)

print("Task 1 completed!")
print("employees.parquet created successfully.")


# ==========================================
# TASK 2: READ PARQUET USING DUCKDB
# ==========================================

print("\nAll Employee Records:")

result = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
""").df()

print(result)


# ==========================================
# TASK 3.1: SALARY GREATER THAN 50000
# ==========================================

print("\nEmployees with salary greater than 50000:")

high_salary = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE salary > 50000
""").df()

print(high_salary)


# ==========================================
# TASK 3.2: IT DEPARTMENT
# ==========================================

print("\nEmployees from IT department:")

it_employees = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE department = 'IT'
""").df()

print(it_employees)


# ==========================================
# TASK 3.3: EMPLOYEES FROM DELHI
# ==========================================

print("\nEmployees working in Delhi:")

delhi_employees = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE city = 'Delhi'
""").df()

print(delhi_employees)


# ==========================================
# TASK 3.4: IT + SALARY GREATER THAN 65000
# ==========================================

print("\nIT employees with salary greater than 65000:")

it_high_salary = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE department = 'IT'
    AND salary > 65000
""").df()

print(it_high_salary)
# ==========================================
# TASK 5: PERFORM AGGREGATIONS
# ==========================================

print("\nOverall Employee Salary Summary:")

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

# ==========================================
# TASK 6: GROUP DATA BY DEPARTMENT
# ==========================================

print("\nDepartment-wise Employee Summary:")

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
# ==========================================
# TASK 7: CREATE DUCKDB DATABASE
# ==========================================

print("\n==========================================")
print("TASK 7: CREATE DUCKDB DATABASE")
print("==========================================")

# Connect to DuckDB database
connection = duckdb.connect("company.duckdb")

# Create employees table using Parquet file
connection.execute("""
    CREATE OR REPLACE TABLE employees AS
    SELECT *
    FROM read_parquet('employees.parquet')
""")

print("Employees table created successfully!")

# Read data from employees table
database_result = connection.execute("""
    SELECT *
    FROM employees
""").df()

print("\nEmployees table data:")
print(database_result)
# ==========================================
# TASK 8: EXPORT HIGH-SALARY EMPLOYEES
# ==========================================

print("\n==========================================")
print("TASK 8: EXPORT HIGH-SALARY EMPLOYEES")
print("==========================================")

connection.execute("""
    COPY (
        SELECT *
        FROM employees
        WHERE salary > 50000
    )
    TO 'high_salary_employees.parquet'
    (FORMAT PARQUET)
""")

print("high_salary_employees.parquet created successfully!")
# ==========================================
# TASK 9: VERIFY EXPORTED PARQUET FILE
# ==========================================

print("\n==========================================")
print("TASK 9: VERIFY EXPORTED PARQUET FILE")
print("==========================================")

exported_result = connection.execute("""
    SELECT *
    FROM read_parquet('high_salary_employees.parquet')
""").df()

print("High-salary employees:")
print(exported_result)

# Close database connection


print("\nDatabase connection closed.")
print("Tasks 7, 8, and 9 completed successfully!")
# ==========================================
# BONUS 1: SECOND-HIGHEST SALARY
# ==========================================

print("\n==========================================")
print("BONUS 1: SECOND-HIGHEST SALARY")
print("==========================================")

second_highest = connection.execute("""
    SELECT *
    FROM employees
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
""").df()

print(second_highest)
# ==========================================
# BONUS 2: TOP 3 HIGHEST-PAID EMPLOYEES
# ==========================================

print("\n==========================================")
print("BONUS 2: TOP 3 HIGHEST-PAID EMPLOYEES")
print("==========================================")

top_three = connection.execute("""
    SELECT *
    FROM employees
    ORDER BY salary DESC
    LIMIT 3
""").df()

print(top_three)
# ==========================================
# BONUS 3: AVERAGE SALARY BY CITY
# ==========================================

print("\n==========================================")
print("BONUS 3: AVERAGE SALARY BY CITY")
print("==========================================")

city_salary = connection.execute("""
    SELECT
        city,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY city
    ORDER BY average_salary DESC
""").df()

print(city_salary)
# ==========================================
# BONUS 4: DEPARTMENTS WITH AVG SALARY > 55000
# ==========================================

print("\n==========================================")
print("BONUS 4: DEPARTMENTS WITH AVG SALARY > 55000")
print("==========================================")

high_average_departments = connection.execute("""
    SELECT
        department,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department
    HAVING AVG(salary) > 55000
""").df()

print(high_average_departments)
# ==========================================
# BONUS 5: SALARY CATEGORY
# ==========================================

print("\n==========================================")
print("BONUS 5: SALARY CATEGORY")
print("==========================================")

salary_categories = connection.execute("""
    SELECT
        name,
        salary,
        CASE
            WHEN salary >= 65000 THEN 'High'
            WHEN salary >= 50000 THEN 'Medium'
            ELSE 'Low'
        END AS salary_category
    FROM employees
""").df()

print(salary_categories)
connection.close()