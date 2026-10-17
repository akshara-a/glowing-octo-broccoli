# -------------------------
# Task 1: Create Parquet
# -------------------------

import pandas as pd

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

print("Parquet file created successfully.")


# -------------------------
# Task 2: Read Parquet
# -------------------------

import duckdb

result = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
""").df()

print(result)


# -------------------------
# Task 3: Filter Employee Records
# -------------------------

high_salary = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE salary > 50000
""").df()

print(high_salary)

# -------------------------
# Task 4: Select Specific Columns
# -------------------------
specific_columns = duckdb.sql("""
    SELECT name, department, salary
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC;
""").df()
print(specific_columns)



# -------------------------
# Task 5: Perform Aggregations
# -------------------------
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


# -------------------------
# Task 6: Group Data
# -------------------------
group_data = duckdb.sql("""
    SELECT
    department,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary,
    MAX(salary) AS highest_salary,
    SUM(salary) AS total_salary
    FROM read_parquet('employees.parquet')
    GROUP BY department
    ORDER BY average_salary DESC;
""")
print(group_data)

# -------------------------
# Task 7: Create a DuckDB Table
# -------------------------
import duckdb

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

print(result)

connection.close()

# -------------------------
# Task 8: Export Query Results to Parquet
# -------------------------
import duckdb

duckdb.sql("""
    COPY (
        SELECT *
        FROM read_parquet('employees.parquet')
        WHERE salary > 50000
    )
    TO 'high_salary_employees.parquet'
    (FORMAT PARQUET)
""")

print("Filtered Parquet file created.")

# -------------------------
# Task 9: Verify the Exported File
# -------------------------
result = duckdb.sql("""
    SELECT *
    FROM read_parquet(
        'high_salary_employees.parquet'
    )
""").df()

print(result)

# -------------------------
# Task 10: Bonus Tasks- Find the employee with the second-highest salary.
# -------------------------
second_highest_salary = duckdb.sql('''
    SELECT * 
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
    ''').df()
print(second_highest_salary)

# -------------------------
# Task 11: Display the top three highest-paid employees.
# -------------------------
top_three = duckdb.sql("""
    SELECT * FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
    LIMIT 3
    """)
print(top_three)
# -------------------------
# Task 12: Calculate the average salary for each city.
# -------------------------
avg_sal = duckdb.sql('''
    SELECT city,AVG(salary)
    FROM read_parquet('employees.parquet')
    GROUP BY city 
    ''')
print(avg_sal)
# -------------------------
# Task 13: Find departments with an average salary greater than 55000.
# -------------------------
dept_by_avg_sal = duckdb.sql("""
    SELECT department, AVG(salary) as average_salary
    FROM read_parquet('employees.parquet')
    GROUP BY department
    HAVING avg(salary) > 55000
""").df()
print(dept_by_avg_sal)
# -------------------------
# Task 14: Add a calculated column named salary_category
# -------------------------
salary_category = duckdb.sql('''
    SELECT *, 
    CASE
    WHEN salary >= 65000 THEN 'High'
    WHEN salary >= 50000 THEN 'Medium'
    ELSE 'Low'
    END AS salary_category
    FROM read_parquet('employees.parquet')
''')
print(salary_category)
