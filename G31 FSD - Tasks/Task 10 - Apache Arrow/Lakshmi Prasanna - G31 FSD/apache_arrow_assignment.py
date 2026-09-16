import pyarrow as pa
import pyarrow.compute as pc
import pyarrow.parquet as pq
import pyarrow.ipc as ipc

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya", "Arjun"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)

print(employee_table)

print(employee_table.schema)

print("Rows:", employee_table.num_rows)
print("Columns:", employee_table.num_columns)
print("Column names:", employee_table.column_names)

print(employee_table.column("name"))
print(employee_table.slice(0, 3))

selected_table = employee_table.select(
    ["name", "department", "salary"]
)

print(selected_table)

salary_filter = pc.greater(
    employee_table["salary"], 50000
)

high_salary_table = employee_table.filter(salary_filter)

print(high_salary_table)

department_filter = pc.equal(
    employee_table["department"], "IT"
)

it_employees = employee_table.filter(department_filter)

print(it_employees)

salary_column = employee_table["salary"]

print("Average salary:", pc.mean(salary_column).as_py())
print("Maximum salary:", pc.max(salary_column).as_py())
print("Minimum salary:", pc.min(salary_column).as_py())
print("Total salary:", pc.sum(salary_column).as_py())

bonus_column = pc.multiply(
    employee_table["salary"], 0.10
)

employee_table = employee_table.append_column(
    "bonus", bonus_column
)

print(employee_table)

employee_df = employee_table.to_pandas()

print(employee_df)

new_arrow_table = pa.Table.from_pandas(
    employee_df, preserve_index=False
)

print(new_arrow_table)

pq.write_table(
    employee_table, "employees.parquet"
)

print("Parquet file created successfully.")

loaded_table = pq.read_table(
    "employees.parquet"
)

print(loaded_table)

with ipc.new_file(
    "employees.arrow",
    employee_table.schema
) as writer:
    writer.write_table(employee_table)

print("Arrow IPC file created successfully.")

with ipc.open_file("employees.arrow") as reader:
    ipc_table = reader.read_all()

print(ipc_table)

it_table = employee_table.filter(department_filter)

pq.write_table(
    it_table, "it_employees.parquet"
)

print("IT employees file created successfully.")
