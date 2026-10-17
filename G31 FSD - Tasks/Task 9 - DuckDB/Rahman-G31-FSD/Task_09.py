import duckdb

# Read the exported Parquet file
result = duckdb.sql("""
SELECT *
FROM read_parquet('high_salary_employees.parquet')
""").df()

# Display the data
print(result)