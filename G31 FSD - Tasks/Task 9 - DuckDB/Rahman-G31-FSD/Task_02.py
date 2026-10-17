import duckdb

result = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet') 
""").df()
print(result)