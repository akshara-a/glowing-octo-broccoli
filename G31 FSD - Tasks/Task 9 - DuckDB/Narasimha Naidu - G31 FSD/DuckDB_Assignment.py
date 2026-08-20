import pandas as pd
import duckdb


# ============================================================
# TASK 1: CREATE EMPLOYEE DATA AND SAVE AS PARQUET
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

print("Task 1: employees.parquet created successfully.")


# ============================================================
# TASK 2: READ PARQUET USING DUCKDB
# ============================================================

result = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
""").df()

print("\nTask 2: All Employee Records")
print(result)


# ============================================================
# TASK 3: FILTER EMPLOYEE RECORDS
# ============================================================

# 1. Salary greater than 50000

high_salary = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE salary > 50000
""").df()

print("\nTask 3.1: Employees with salary greater than 50000")
print(high_salary)


# 2. Employees from IT department

it_employees = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE department = 'IT'
""").df()

print("\nTask 3.2: Employees from IT department")
print(it_employees)


# 3. Employees working in Delhi

delhi_employees = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE city = 'Delhi'
""").df()

print("\nTask 3.3: Employees working in Delhi")
print(delhi_employees)


# 4. IT employees with salary greater than 65000

it_high_salary = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE department = 'IT'
    AND salary > 65000
""").df()

print("\nTask 3.4: IT employees with salary greater than 65000")
print(it_high_salary)


# ============================================================
# TASK 4: SELECT SPECIFIC COLUMNS AND SORT
# ============================================================

sorted_employees = duckdb.sql("""
    SELECT name, department, salary
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
""").df()

print("\nTask 4: Employees sorted by salary (Highest to Lowest)")
print(sorted_employees)


# ============================================================
# TASK 5: PERFORM AGGREGATIONS
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

print("\nTask 5: Salary Summary")
print(summary)


# ============================================================
# TASK 6: GROUP DATA BY DEPARTMENT
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

print("\nTask 6: Department Summary")
print(department_summary)


# ============================================================
# TASK 7: CREATE DUCKDB DATABASE
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

print("\nTask 7: Employees Table from DuckDB")
print(result)

connection.close()

print("\nTask 7: company.duckdb created successfully.")


# ============================================================
# TASK 8: EXPORT HIGH SALARY EMPLOYEES TO PARQUET
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

print("\nTask 8: high_salary_employees.parquet created successfully.")


# ============================================================
# TASK 9: VERIFY EXPORTED FILE
# ============================================================

result = duckdb.sql("""
    SELECT *
    FROM read_parquet('high_salary_employees.parquet')
""").df()

print("\nTask 9: High Salary Employees")
print(result)


# ============================================================
# BONUS 1: SECOND HIGHEST SALARY
# ============================================================

second_highest = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
""").df()

print("\nBonus 1: Second Highest Salary")
print(second_highest)


# ============================================================
# BONUS 2: TOP THREE HIGHEST-PAID EMPLOYEES
# ============================================================

top_three = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
    LIMIT 3
""").df()

print("\nBonus 2: Top Three Highest-Paid Employees")
print(top_three)


# ============================================================
# BONUS 3: AVERAGE SALARY FOR EACH CITY
# ============================================================

city_salary = duckdb.sql("""
    SELECT
        city,
        AVG(salary) AS average_salary
    FROM read_parquet('employees.parquet')
    GROUP BY city
    ORDER BY average_salary DESC
""").df()

print("\nBonus 3: Average Salary by City")
print(city_salary)


# ============================================================
# BONUS 4: DEPARTMENTS WITH AVERAGE SALARY GREATER THAN 55000
# ============================================================

departments = duckdb.sql("""
    SELECT
        department,
        AVG(salary) AS average_salary
    FROM read_parquet('employees.parquet')
    GROUP BY department
    HAVING AVG(salary) > 55000
""").df()

print("\nBonus 4: Departments with Average Salary Greater Than 55000")
print(departments)


# ============================================================
# BONUS 5: SALARY CATEGORY
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
""").df()

print("\nBonus 5: Salary Categories")
print(salary_category)


# ============================================================
# ASSIGNMENT COMPLETED
# ============================================================

print("\n==============================================")
print("ASSIGNMENT COMPLETED SUCCESSFULLY!")
print("==============================================")
print("Files created:")
print("1. employees.parquet")
print("2. high_salary_employees.parquet")
print("3. company.duckdb") 