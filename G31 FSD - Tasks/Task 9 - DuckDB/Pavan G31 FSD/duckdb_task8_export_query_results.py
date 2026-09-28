import duckdb

# Connect to the database
con = duckdb.connect("company.duckdb")

# Export employees with salary greater than 50000
con.execute("""
    COPY (
        SELECT *
        FROM employees
        WHERE salary > 50000
    )
    TO 'high_salary_employees.parquet'
    (FORMAT PARQUET)
""")

print("Export completed successfully!")
print("Created file: high_salary_employees.parquet")

# Close the connection
con.close()