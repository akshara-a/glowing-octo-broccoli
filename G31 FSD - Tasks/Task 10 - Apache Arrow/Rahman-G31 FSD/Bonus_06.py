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

sort_indices = pc.sort_indices(
    employee_table,
    sort_keys=[
        ("salary", "descending")
    ]
)

sorted_table = employee_table.take(
    sort_indices
)

print("\n=== BONUS 6: SALARY HIGHEST TO LOWEST ===")
print(sorted_table)