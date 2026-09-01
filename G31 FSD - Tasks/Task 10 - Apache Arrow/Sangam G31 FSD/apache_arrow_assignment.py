print("==========Taks 1: Create an arrow table =========")
import pyarrow as pa

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya", "Arjun"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)

print(employee_table)

print('======= Task 2=======')
print(employee_table.schema)
print('=======Task 3=======')
print("Rows:", employee_table.num_rows)
print("Columns:", employee_table.num_columns)
print("Column names:", employee_table.column_names)

print(employee_table.column("name"))
print(employee_table.slice(0, 3))

print('=======Task 4: Select Specific Columns=======')
selected_table = employee_table.select(
    ["name", "department", "salary"]
)

print(selected_table)

print('=======Task 5: Filter Records=======')
import pyarrow.compute as pc

salary_filter = pc.greater(
    employee_table["salary"],
    50000
)

high_salary_table = employee_table.filter(salary_filter)

print(high_salary_table)

print('======Task 6: Filter by Department========')

department_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_employees = employee_table.filter(department_filter)

print(it_employees)

print('=======Task 7: Perform Calculations=======')

salary_column = employee_table["salary"]

print("Average salary:", pc.mean(salary_column).as_py())
print("Maximum salary:", pc.max(salary_column).as_py())
print("Minimum salary:", pc.min(salary_column).as_py())
print("Total salary:", pc.sum(salary_column).as_py())

print('=======Task 8: Add a New Column=======')
bonus_column = pc.multiply(
    employee_table["salary"],
    0.10
)

employee_table = employee_table.append_column(
    "bonus",
    bonus_column
)

print(employee_table)

print('=======Task 9: Convert Arrow to Pandas=======')
employee_df = employee_table.to_pandas()

print(employee_df)


print('=======Task 10: Convert Pandas to Arrow=======')
new_arrow_table = pa.Table.from_pandas(
    employee_df,
    preserve_index=False
)

print(new_arrow_table)

print('=======Task 11 : Save as a Parquet file=======')
import pyarrow.parquet as pq

pq.write_table(
    employee_table,
    "employees.parquet"
)

print("Parquet file created successfully.")


print('=======Task 12: Read the Parquet File=======')
loaded_table = pq.read_table(
    "employees.parquet"
)

print(loaded_table)

print('=======Task 13: Save as an Arrow IPC File=======')
import pyarrow.ipc as ipc

with ipc.new_file(
    "employees.arrow",
    employee_table.schema
) as writer:
    writer.write_table(employee_table)

print("Arrow IPC file created successfully.")


print('=======Task 14: Read the Arrow IPC File=======')
with ipc.open_file("employees.arrow") as reader:
    ipc_table = reader.read_all()

print(ipc_table)


print('=======Task 15: Display employees who work in Delhi=======')
display_employees = pc.equal(
    employee_table["city"],
    "Delhi"
)

it_employees = employee_table.filter(display_employees)

print(it_employees)


print('==========BONUS TASKS============')
print('=======Task 16: Display employees with salaries between 50000 and 65000.=======')

lower_limit = pc.greater_equal(
    employee_table["salary"],
    50000
)

upper_limit = pc.less_equal(
    employee_table["salary"],
    65000
)

salary_filter = pc.and_(
    lower_limit,
    upper_limit
)

employees_between_salary = employee_table.filter(salary_filter)

print(employees_between_salary)

print('========Task 17 : Add a column named annual_salary by multiplying salary by 12.=======')
annual_salary = pc.multiply(
    employee_table["salary"],
    12
)

employee_table = employee_table.append_column(
    "annual_salary",
    annual_salary
)

print(employee_table)

print('========Task 18: Save only IT employees to it_employees.parquet.=======')

import pyarrow.parquet as pq

department_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_employees = employee_table.filter(department_filter)


pq.write_table(
    it_employees,
    "it_employees.parquet"
)

print("Parquet file created successfully.")


print('=======Task 19: Read only the name and salary columns from the Parquet file.=====')

read_specific_columns = pq.read_table(
    "employees.parquet",
    columns = ['name','salary']
)

print(read_specific_columns)

print('=======Task 20: Sort employees by salary from highest to lowest.=====')

sorted_indices = pc.sort_indices(
    employee_table,
    sort_keys=[("salary", "descending")]
)

sorted_employees = employee_table.take(sorted_indices)

print(sorted_employees)
