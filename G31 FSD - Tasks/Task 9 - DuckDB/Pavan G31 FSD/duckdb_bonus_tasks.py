import duckdb

print("========== Bonus Task 1 ==========")
result = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    WHERE salary > 60000
""").df()
print(result)

print("\n========== Bonus Task 2 ==========")
result = duckdb.sql("""
    SELECT *
    FROM read_parquet('employees.parquet')
    ORDER BY name ASC
""").df()
print(result)

print("\n========== Bonus Task 3 ==========")
result = duckdb.sql("""
    SELECT
        city,
        SUM(salary) AS total_salary
    FROM read_parquet('employees.parquet')
    GROUP BY city
    ORDER BY total_salary DESC
""").df()
print(result)