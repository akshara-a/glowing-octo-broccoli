import duckdb
import pandas as pd

print("--- Task 1: Creating employees.parquet ---")
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
        "Karan",
    ],
    "department": [
        "IT",
        "HR",
        "IT",
        "Finance",
        "HR",
        "Finance",
        "IT",
        "Sales",
    ],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000, 75000, 50000],
    "city": [
        "Delhi",
        "Mumbai",
        "Bengaluru",
        "Delhi",
        "Mumbai",
        "Chennai",
        "Bengaluru",
        "Delhi",
    ],
}
df = pd.DataFrame(data)
df.to_parquet("employees.parquet", index=False)
print("employees.parquet created successfully.\n")

print("--- Task 2: Read All Employee Records ---")
all_employees = duckdb.sql("SELECT * FROM read_parquet('employees.parquet')").df()
print(all_employees, "\n")

print("--- Task 3.1: Salary > 50000 ---")
print(
    duckdb.sql(
        "SELECT * FROM read_parquet('employees.parquet') WHERE salary > 50000"
    ).df(),
    "\n",
)

print("--- Task 3.2: Department = 'IT' ---")
print(
    duckdb.sql(
        "SELECT * FROM read_parquet('employees.parquet') WHERE department = 'IT'"
    ).df(),
    "\n",
)

print("--- Task 3.3: City = 'Delhi' ---")
print(
    duckdb.sql(
        "SELECT * FROM read_parquet('employees.parquet') WHERE city = 'Delhi'"
    ).df(),
    "\n",
)

print("--- Task 3.4: Department = 'IT' AND Salary > 65000 ---")
print(
    duckdb.sql(
        """
    SELECT * 
    FROM read_parquet('employees.parquet') 
    WHERE department = 'IT' AND salary > 65000
"""
    ).df(),
    "\n",
)

print("--- Task 4: Selected Columns Sorted by Salary DESC ---")
selected_cols = duckdb.sql(
    """
    SELECT name, department, salary
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
"""
).df()
print(selected_cols, "\n")

print("--- Task 5: Salary & Count Aggregations ---")
summary = duckdb.sql(
    """
    SELECT
        COUNT(*) AS employee_count,
        AVG(salary) AS average_salary,
        MAX(salary) AS maximum_salary,
        MIN(salary) AS minimum_salary,
        SUM(salary) AS total_salary
    FROM read_parquet('employees.parquet')
"""
).df()
print(summary, "\n")

print("--- Task 6: Group by Department ---")
dept_summary = duckdb.sql(
    """
    SELECT
        department,
        COUNT(*) AS employee_count,
        AVG(salary) AS average_salary,
        MAX(salary) AS highest_salary,
        SUM(salary) AS total_salary
    FROM read_parquet('employees.parquet')
    GROUP BY department
    ORDER BY average_salary DESC
"""
).df()
print(dept_summary, "\n")

print("--- Task 7: Create Persistent Table in company.duckdb ---")
connection = duckdb.connect("company.duckdb")
connection.execute(
    """
    CREATE OR REPLACE TABLE employees AS
    SELECT *
    FROM read_parquet('employees.parquet')
"""
)
db_table_result = connection.execute("SELECT * FROM employees").df()
print(db_table_result, "\n")
connection.close()

print("--- Task 8: Export Salary > 50000 to Parquet ---")
duckdb.sql(
    """
    COPY (
        SELECT *
        FROM read_parquet('employees.parquet')
        WHERE salary > 50000
    )
    TO 'high_salary_employees.parquet'
    (FORMAT PARQUET)
"""
)
print("high_salary_employees.parquet created successfully.\n")

print("--- Task 9: Read high_salary_employees.parquet ---")
exported_data = duckdb.sql(
    "SELECT * FROM read_parquet('high_salary_employees.parquet')"
).df()
print(exported_data, "\n")

print("--- Bonus 1: Second-Highest Salary Employee ---")
print(
    duckdb.sql(
        """
    SELECT name, department, salary
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
"""
    ).df(),
    "\n",
)

print("--- Bonus 2: Top 3 Highest-Paid Employees ---")
print(
    duckdb.sql(
        """
    SELECT name, department, salary
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
    LIMIT 3
"""
    ).df(),
    "\n",
)

print("--- Bonus 3: Average Salary by City ---")
print(
    duckdb.sql(
        """
    SELECT
        city,
        COUNT(*) AS employee_count,
        AVG(salary) AS avg_salary
    FROM read_parquet('employees.parquet')
    GROUP BY city
    ORDER BY avg_salary DESC
"""
    ).df(),
    "\n",
)

print("--- Bonus 4: Departments with Average Salary > 55000 ---")
print(
    duckdb.sql(
        """
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM read_parquet('employees.parquet')
    GROUP BY department
    HAVING AVG(salary) > 55000
    ORDER BY avg_salary DESC
"""
    ).df(),
    "\n",
)

print("--- Bonus 5: Salary Categorization ---")
print(
    duckdb.sql(
        """
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
"""
    ).df(),
    "\n",
)
