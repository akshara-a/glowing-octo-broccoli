import duckdb

duckdb.sql("""
COPY (
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE Salary > 50000
)
TO 'high_salary_employees.parquet'
(FORMAT PARQUET)
""")

print("Parquet file created successfully!")