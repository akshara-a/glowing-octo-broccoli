
# PERFORMANCE TESTING OF DUCKDB 

# 1. Average salary of all employees

import duckdb
average_salary = duckdb.sql(""" 
    SELECT AVG(Salary) AS Average_Salary
    FROM read_parquet('employees.parquet')
""").df()
print("The avg salary of all employees is:")
print(average_salary)
print("___________________________________________________")

# 2. Maximum salary

maximum_salary = duckdb.sql(""" 
    SELECT MAX(Salary) AS Maximum_Salary
    FROM read_parquet('employees.parquet')
""").df()
print("The maximum salary of all employees is:")
print(maximum_salary)
print("___________________________________________________")


# 3. Minimum salary
minimum_salary = duckdb.sql(""" 
    SELECT MIN(Salary) AS Minimum_Salary
    FROM read_parquet('employees.parquet')
""").df()
print("The minimum salary of all employees is:")
print(minimum_salary)
print("___________________________________________________")

# 4. total nnumer of the employees

total_employees = duckdb.sql("""
    SELECT COUNT(*) AS Total_Employees
    FROM read_parquet('employees.parquet')
""").df()
print("The total number of employees is:")
print(total_employees)
print("___________________________________________________")

# 05. Total salary paid of all employees

total_Salary_paid = duckdb.sql("""
    SELECT SUM(Salary) As total_Salary_paid
    from read_parquet('employees.parquet') 
""").df()
print("Total Salary paid to all employees is:")
print(total_Salary_paid)
print("___________________________________________________")
