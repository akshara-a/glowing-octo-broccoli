import duckdb

# Read all employee records from the Parquet file
result = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
""").df()

# Display the result
print(result)