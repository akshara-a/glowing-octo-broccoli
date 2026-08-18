import duckdb

result = duckdb.sql("""
    SELECT
        name,
        Salary,
        CASE
            WHEN Salary >= 65000 THEN 'High'
            WHEN Salary >= 50000 THEN 'Medium'
            ELSE 'Low'
        END AS salary_category
    FROM read_parquet('employees.parquet')
""").df()

print(result)