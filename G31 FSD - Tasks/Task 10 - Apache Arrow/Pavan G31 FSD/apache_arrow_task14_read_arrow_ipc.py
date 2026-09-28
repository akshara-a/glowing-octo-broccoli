import pyarrow.ipc as ipc

with ipc.open_file("employees.arrow") as reader:
    employee_table = reader.read_all()

print(employee_table)