import duckdb   # "Load the DuckDB library so I can use its features."

# Create/Open database
connection = duckdb.connect("company.duckdb") # It stores the connection to the database. 

# Create employees table from Parquet
connection.execute("""
CREATE OR REPLACE TABLE employees AS
SELECT *
FROM read_parquet('employees.parquet')
""")

# Read the table
result = connection.execute("""
SELECT *
FROM employees
""").df()

# Display data
print(result)

# Close database
connection.close()
