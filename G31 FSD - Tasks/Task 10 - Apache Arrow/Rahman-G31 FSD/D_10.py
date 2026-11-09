import pyarrow as pa

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Sharif", "Sam", "Saim", "Waq", "Rashid", "Abhi"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)

employee_df = employee_table.to_pandas()

# print("\n=== TASK 9: ARROW → PANDAS ===")
# print(employee_df)

arrow = pa.Table.from_pandas(
    employee_df,
    preserve_index=False
)

print("\n=== TASK 10: PANDAS → ARROW ===")
print(arrow)