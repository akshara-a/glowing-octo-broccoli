import duckdb

result = duckdb.sql("""

SELECT
    Department,
    AVG (Salary) AS average_salary
FROM read_parquet('employees.parquet')

WHERE Salary > 50000
GROUP BY Department


""").df()

print(result)