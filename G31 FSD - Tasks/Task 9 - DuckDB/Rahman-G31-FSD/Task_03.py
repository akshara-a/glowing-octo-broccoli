
import duckdb

high_salary = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE salary > 50000
""").df()

print(high_salary)
print("___________________________________________________")

IT_department = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE Department = 'IT'
""").df()
print(IT_department)
print("___________________________________________________")


working_in_Delhi = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE City = 'Delhi'
""").df()
print(working_in_Delhi)
print("___________________________________________________")

employees_in_IT = duckdb.sql(""" 
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE Department = 'IT'
    AND Salary > 65000
""").df()
print(employees_in_IT)
print("___________________________________________________")
