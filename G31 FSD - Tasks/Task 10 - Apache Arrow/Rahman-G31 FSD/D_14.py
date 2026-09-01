import pyarrow.ipc as ipc

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Sharif", "Sam", "Saim", "Waq", "Rashid", "Abhi"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}


with ipc.open_file("employees.arrow") as reader:

    ipc_table = reader.read_all()

print("\n=== TASK 14: READ IPC ===")
print(ipc_table)