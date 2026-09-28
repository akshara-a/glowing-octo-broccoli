import pyarrow as pa
#-----Task 1------
data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya", "Arjun"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)

print(employee_table)

#-----Task 2------

print(employee_table.schema)

#-----Task 3------

print("Rows:", employee_table.num_rows)
print("Columns:", employee_table.num_columns)
print("Column names:", employee_table.column_names)

print(employee_table.column("name"))
print(employee_table.slice(0,3))

#-----Task 4------

selected_table = employee_table.select(
    ["name","department","salary"]
)

print(selected_table)

#-----Task 5------

import pyarrow.compute as pc

salary_filter = pc.greater(
    employee_table["salary"],
    50000
)

high_salary_table = employee_table.filter(
    salary_filter
)

print(high_salary_table)

#-----Task 6------

department_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_employees = employee_table.filter(
    department_filter
)

print(it_employees)

#-----Task 7------

salary_column = employee_table["salary"]

print("Average Salary:", pc.mean(salary_column).as_py())

print("Maximum Salary:", pc.max(salary_column).as_py())

print("Minimum Salary:", pc.min(salary_column).as_py())

print("Total Salary:", pc.sum(salary_column).as_py())

#-----Task 8------

bonus_column = pc.multiply(
    employee_table["salary"],
    0.10
)

employee_table = employee_table.append_column(
    "bonus",
    bonus_column
)

print(employee_table)

#-----Task 9------

employee_df = employee_table.to_pandas()

print(employee_df)

#-----Task 10------

new_arrow_table = pa.Table.from_pandas(
    employee_df,
    preserve_index=False
)

print(new_arrow_table)

#-----Task 11------

import pyarrow.parquet as pq

pq.write_table(
    employee_table,
    "employees.parquet"
)

print("Parquet file created successfully.")

#-----Task 12------

loaded_table = pq.read_table(
    "employees.parquet"
)

print(loaded_table)

#-----Task 13------

import pyarrow.ipc as ipc

with ipc.new_file(
    "employees.arrow",
    employee_table.schema
) as writer:

    writer.write_table(employee_table)

print("Arrow IPC file created successfully.")

#-----Task 14------

with ipc.open_file(
    "employees.arrow"
) as reader:

    ipc_table = reader.read_all()

print(ipc_table)