print(" GROUP DATA")

import duckdb

# 1. Number of employees in the company

NO_OF_EMPLOYEES = duckdb.sql("""
    SELECT COUNT(*) AS total_employees
    FROM read_parquet('employees.parquet')
""").df()
print("NUMBER OF EMPLOYEESIN THE COMPANY IS :")
print(NO_OF_EMPLOYEES)
print("___________________________________________________")

# 02 Average salary of all employees

Avg_Salary = duckdb.sql("""
    SELECT AVG(Salary) AS Avg_Salary
    FROM read_parquet('employees.parquet')
""").df()
print("AVERAGE SALARY OF EMPLOYEES IS :")
print(Avg_Salary)
print("___________________________________________________")

# 03 HIGHEST SALARY OF EMPLOYEES

Highest_Salary = duckdb.sql("""
     SELECT MAX(Salary) AS Highest_Salary
     FROM read_parquet('employees.parquet')
""").df()
print(" HIGHEST SALARY OF THE EMPLYEEES IS :")
print(Highest_Salary)
print("_____________________________________________________")

# 04 TOTAL SALARY OF THE EMPLOYEES

Total_Salary = duckdb.sql("""
     SELECT Sum(Salary) AS Total_salary
     FROM read_parquet('employees.parquet')
""").df()
print("TOTAl SAlARY OF THE EMPLOYEES IS :")
print(Total_Salary)
print("_____________________________________________________")

