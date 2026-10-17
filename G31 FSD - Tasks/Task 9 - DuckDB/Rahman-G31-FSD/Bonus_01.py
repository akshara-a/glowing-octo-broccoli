import duckdb

result = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    ORDER BY Salary DESC
    LIMIT 1 OFFSET 1
""").df()

print(result)