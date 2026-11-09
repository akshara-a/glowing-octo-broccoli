import duckdb

name = duckdb.sql(""" 
    SELECT name
    FROM read_parquet('employees.parquet')

""").df()
print(name)

Department = duckdb.sql(""" 
    SELECT Department
    FROM read_parquet('employees.parquet')

""").df()
print(Department)

Salary = duckdb.sql(""" 
    SELECT Salary
    FROM read_parquet('employees.parquet')

""").df()
print(Salary)

Salary_highest_to_lowest = duckdb.sql(""" 
    SELECT Salary
    FROM read_parquet('employees.parquet')
    ORDER BY Salary DESC

""").df()
print(Salary_highest_to_lowest)


