import duckdb

result = duckdb.sql("""

   SELECT CIty,
   AVG (Salary) AS average_salary

   FROM read_parquet('employees.parquet')
   GROUP BY City
   ORDER BY average_salary DESC
""").df()

print(result)