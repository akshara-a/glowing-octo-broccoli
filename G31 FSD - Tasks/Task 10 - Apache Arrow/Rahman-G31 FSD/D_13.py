import pyarrow as pa
import pyarrow.ipc as ipc

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Sharif", "Sam", "Saim", "Waq", "Rashid", "Abhi"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)

with ipc.new_file(
    "employees.arrow",
    employee_table.schema
) as writer:

    writer.write_table(employee_table)

print("\n=== TASK 13 ===")
print("Arrow IPC file created successfully.")