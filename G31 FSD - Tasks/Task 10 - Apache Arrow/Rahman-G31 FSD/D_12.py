import pyarrow as pa
import pyarrow.parquet as pq

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Sharif", "Sam", "Saim", "Waq", "Rashid", "Abhi"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}


loaded_table = pq.read_table(
    "employees.parquet"
)

print("\n=== TASK 12: READ PARQUET ===")
print(loaded_table)
