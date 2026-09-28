import pandas as pd
import duckdb
#-----Task 1-------
data = {
     "employee_id": [1, 2, 3, 4, 5, 6, 7, 8], "name": [ "Asha", "Rahul", "Neha", "Vikram", "Priya", "Arjun", "Meera", "Karan" ],
         "department": [ "IT", "HR", "IT", "Finance", "HR", "Finance", "IT", "Sales" ],
           "salary": [ 60000, 45000, 70000, 55000, 48000, 65000, 75000, 50000 ], 
           "city": [ "Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai", "Bengaluru", "Delhi" ]
             } 

df = pd.DataFrame(data) 
df.to_parquet( "employees.parquet", index=False )

print("Parquet file created successfully.")

#-----Task 2-------



result = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
""").df()

print(result)

#-----Task 3-------

high_salary = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE salary > 50000
""").df()

print(high_salary)

it_employees = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department = 'IT'
""").df()

print(it_employees)

delhi_employees = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE city = 'Delhi'
""").df()

print(delhi_employees)

it_high_salary = duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
WHERE department = 'IT'
AND salary > 65000
""").df()

print(it_high_salary)

#-----Task 4-------

display=duckdb.sql(""" 
SELECT name, department, salary FROM read_parquet('employees.parquet') ORDER BY salary DESC;""").df()
print(display)

#-----Task 5-------

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

#-----Task 6-------

group_data=duckdb.sql("""
SELECT department, COUNT(*) AS employee_count, AVG(salary) AS average_salary, MAX(salary) AS highest_salary, SUM(salary) AS total_salary FROM read_parquet('employees.parquet') GROUP BY department ORDER BY average_salary DESC;
""").df()
print(group_data)

#-----Task 7 duckdb table -------

connection = duckdb.connect("company.duckdb") 

connection.execute(""" CREATE OR REPLACE TABLE employees AS SELECT * FROM read_parquet('employees.parquet') """)
result = connection.execute(""" SELECT * FROM employees """).df()
print(result) 
connection.close()

#-----Task 8 exporting queries to parquet files-------

duckdb.sql(""" COPY ( SELECT * FROM read_parquet('employees.parquet') WHERE salary > 50000 ) TO 'high_salary_employees.parquet' (FORMAT PARQUET) """)

print("Filtered Parquet file created.")

#-----Task 9 verifying exported files -------

result = duckdb.sql(""" SELECT * FROM read_parquet( 'high_salary_employees.parquet' ) """).df()

print(result)


#-----Bonnus Task-------

bonus_task=duckdb.sql("""
SELECT *
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
LIMIT 1 OFFSET 1;


SELECT *
FROM read_parquet('employees.parquet')
ORDER BY salary DESC
LIMIT 3;


SELECT
city,
AVG(salary) AS average_salary
FROM read_parquet('employees.parquet')
GROUP BY city;


SELECT
department,
AVG(salary) AS average_salary
FROM read_parquet('employees.parquet')
GROUP BY department
HAVING AVG(salary) > 55000;


SELECT
name,
salary,
CASE
WHEN salary >= 65000 THEN 'High'
WHEN salary >= 50000 THEN 'Medium'
ELSE 'Low'
END AS salary_category
FROM read_parquet('employees.parquet');

""").df()

print(bonus_task)

