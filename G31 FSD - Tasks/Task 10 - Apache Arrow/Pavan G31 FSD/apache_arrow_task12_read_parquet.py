import pyarrow.parquet as pq

employee_table = pq.read_table("employees.parquet")

print(employee_table)