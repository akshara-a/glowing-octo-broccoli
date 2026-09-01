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

employees_df = pd.DataFrame(data)

employees_df.to_parquet(
    "employees.parquet",
    index=False
)

print("=========================================")
print("TASK 1: CREATE PARQUET FILE")
print("=========================================")
print("employees.parquet created successfully.")

# ==========================================
# TASK 2: READ PARQUET USING DUCKDB
# ==========================================

print("\n=========================================")
print("TASK 2: READ PARQUET FILE")
print("=========================================")

all_employees = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
""").df()

print(all_employees)

# ==========================================
# TASK 3.1: EMPLOYEES WITH SALARY > 50000
# ==========================================

print("\n=========================================")
print("TASK 3.1: SALARY GREATER THAN 50000")
print("=========================================")

salary_result = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE salary > 50000
""").df()

print(salary_result)

# ==========================================
# TASK 3.2: IT DEPARTMENT
# ==========================================

print("\n=========================================")
print("TASK 3.2: IT EMPLOYEES")
print("=========================================")

it_result = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department = 'IT'
""").df()

print(it_result)

# ==========================================
# TASK 3.3: EMPLOYEES FROM DELHI
# ==========================================

print("\n=========================================")
print("TASK 3.3: EMPLOYEES FROM DELHI")
print("=========================================")

delhi_result = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE city = 'Delhi'
""").df()

print(delhi_result)

# ==========================================
# TASK 3.4: IT EMPLOYEES WITH SALARY > 65000
# ==========================================

print("\n=========================================")
print("TASK 3.4: IT EMPLOYEES WITH SALARY > 65000")
print("=========================================")

it_salary = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department='IT'
AND salary>65000
""").df()

print(it_salary)
# ==========================================
# TASK 4: SELECT SPECIFIC COLUMNS
# ==========================================

print("\n=========================================")
print("TASK 4: NAME, DEPARTMENT AND SALARY")
print("=========================================")

selected_columns = duckdb.sql("""
SELECT
    name,
    department,
    salary
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
""").df()

print(selected_columns)

# ==========================================
# TASK 5: PERFORM AGGREGATIONS
# ==========================================

print("\n=========================================")
print("TASK 5: AGGREGATE FUNCTIONS")
print("=========================================")

summary = duckdb.sql("""
SELECT
    AVG(salary) AS average_salary,
    MAX(salary) AS maximum_salary,
    MIN(salary) AS minimum_salary,
    COUNT(*) AS total_employees,
    SUM(salary) AS total_salary
FROM read_parquet('employees.parquet')
""").df()

print(summary)

# ==========================================
# TASK 6: GROUP DATA BY DEPARTMENT
# ==========================================

print("\n=========================================")
print("TASK 6: DEPARTMENT SUMMARY")
print("=========================================")

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

print("\n=========================================")
print("TASK 7: CREATE DUCKDB DATABASE")
print("=========================================")

connection = duckdb.connect("company.duckdb")

connection.execute("""
CREATE OR REPLACE TABLE employees AS
SELECT *
FROM read_parquet('employees.parquet')
""")

print("Employees table created successfully.")

employees_table = connection.execute("""
SELECT *
FROM employees
""").df()

print("\nEmployees Table")
print(employees_table)
# ==========================================
# TASK 8: EXPORT HIGH SALARY EMPLOYEES
# ==========================================

print("\n=========================================")
print("TASK 8: EXPORT QUERY RESULTS TO PARQUET")
print("=========================================")

connection.execute("""
COPY (
    SELECT *
    FROM employees
    WHERE salary > 50000
)
TO 'high_salary_employees.parquet'
(FORMAT PARQUET)
""")

print("high_salary_employees.parquet created successfully.")

# ==========================================
# TASK 9: VERIFY EXPORTED PARQUET FILE
# ==========================================

print("\n=========================================")
print("TASK 9: VERIFY EXPORTED PARQUET FILE")
print("=========================================")

exported_file = connection.execute("""
SELECT *
FROM read_parquet('high_salary_employees.parquet')
""").df()

print(exported_file)

# ==========================================
# BONUS 1: SECOND HIGHEST SALARY
# ==========================================

print("\n=========================================")
print("BONUS 1: SECOND HIGHEST SALARY")
print("=========================================")

second_highest = connection.execute("""
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1
""").df()

print(second_highest)

# ==========================================
# BONUS 2: TOP 3 HIGHEST PAID EMPLOYEES
# ==========================================

print("\n=========================================")
print("BONUS 2: TOP 3 HIGHEST PAID EMPLOYEES")
print("=========================================")

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

print("\n=========================================")
print("BONUS 3: AVERAGE SALARY BY CITY")
print("=========================================")

city_average = connection.execute("""
SELECT
    city,
    AVG(salary) AS average_salary
FROM employees
GROUP BY city
ORDER BY average_salary DESC
""").df()

print(city_average)

# ==========================================
# BONUS 4: DEPARTMENTS WITH AVG SALARY > 55000
# ==========================================

print("\n=========================================")
print("BONUS 4: DEPARTMENTS WITH HIGH AVERAGE SALARY")
print("=========================================")

high_average = connection.execute("""
SELECT
    department,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 55000
""").df()

print(high_average)

# ==========================================
# BONUS 5: SALARY CATEGORY
# ==========================================

print("\n=========================================")
print("BONUS 5: SALARY CATEGORY")
print("=========================================")

salary_category = connection.execute("""
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

print(salary_category)

# ==========================================
# CLOSE DATABASE
# ==========================================

connection.close()

print("\n=========================================")
print("DuckDB Assignment Completed Successfully")
print("=========================================")
