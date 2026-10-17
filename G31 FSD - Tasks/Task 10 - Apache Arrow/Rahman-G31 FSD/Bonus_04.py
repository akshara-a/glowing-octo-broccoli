import pyarrow as pa
import pyarrow.compute as pc
import pyarrow.parquet as pq

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Sharif", "Sam", "Saim", "Waq", "Rashid", "Abhi"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)

it_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_employees = employee_table.filter(
    it_filter
)
pq.write_table(
    it_employees,
    "it_employees.parquet"
)

print("\n=== BONUS 4 ===")
print("IT employees saved to it_employees.parquet")