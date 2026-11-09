import duckdb

result = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    ORDER BY Salary DESC
    LIMIT 3
""").df()

print(result)