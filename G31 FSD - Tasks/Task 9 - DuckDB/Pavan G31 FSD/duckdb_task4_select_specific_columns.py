import duckdb

selected_columns = duckdb.sql("""
    SELECT
        name,
        department,
        salary
    FROM read_parquet('employees.parquet')
    ORDER BY salary DESC
""").df()

print("Employees sorted by salary (Highest to Lowest)")
print(selected_columns)