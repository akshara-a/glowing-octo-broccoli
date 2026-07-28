import duckdb

# Employees with salary greater than 50000
high_salary = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE salary > 50000
""").df()

print("Employees with salary greater than 50000")
print(high_salary)

# Employees from IT department
it_department = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE department = 'IT'
""").df()

print("\nEmployees from IT Department")
print(it_department)

# Employees working in Delhi
delhi_employees = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE city = 'Delhi'
""").df()

print("\nEmployees working in Delhi")
print(delhi_employees)

# IT employees with salary greater than 65000
it_high_salary = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE department = 'IT'
      AND salary > 65000
""").df()

print("\nIT employees with salary greater than 65000")
print(it_high_salary)