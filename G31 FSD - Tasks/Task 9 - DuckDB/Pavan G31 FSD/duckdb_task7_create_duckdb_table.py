import duckdb

# Connect to DuckDB database
con = duckdb.connect("company.duckdb")

# Create employees table from the Parquet file
con.execute("""
    CREATE OR REPLACE TABLE employees AS
    SELECT *
    FROM read_parquet('employees.parquet')
""")

print("Employees table created successfully!")

# Show all tables
print("\nTables in the database:")
print(con.execute("SHOW TABLES").fetchdf())

# Show table structure
print("\nEmployees table structure:")
print(con.execute("DESCRIBE employees").fetchdf())

# Close the connection
con.close()