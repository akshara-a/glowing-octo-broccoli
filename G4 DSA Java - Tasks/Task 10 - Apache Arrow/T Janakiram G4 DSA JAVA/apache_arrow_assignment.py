import pandas as pd
import pyarrow as pa
import pyarrow.compute as pc
import pyarrow.ipc as ipc
import pyarrow.parquet as pq

print("--- Task 1: Create an Arrow Table ---")
data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya", "Arjun"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"],
}
employee_table = pa.table(data)
print(employee_table, "\n")

print("--- Task 2: Display Schema ---")
print(employee_table.schema)
print("Data type of employee_id:", employee_table.schema.field("employee_id").type)
print("Data type of name:", employee_table.schema.field("name").type)
print("Data type of salary:", employee_table.schema.field("salary").type, "\n")

print("--- Task 3: Inspect Table ---")
print("Rows:", employee_table.num_rows)
print("Columns:", employee_table.num_columns)
print("Column names:", employee_table.column_names)
print("The 'name' column:\n", employee_table.column("name"))
print("First three rows:\n", employee_table.slice(0, 3), "\n")

print("--- Task 4: Select Specific Columns ---")
selected_table = employee_table.select(["name", "department", "salary"])
print(selected_table, "\n")

print("--- Task 5: Salary > 50000 ---")
salary_filter = pc.greater(employee_table["salary"], 50000)
high_salary_table = employee_table.filter(salary_filter)
print(high_salary_table, "\n")

print("--- Task 6: Department == 'IT' ---")
department_filter = pc.equal(employee_table["department"], "IT")
it_employees = employee_table.filter(department_filter)
print(it_employees, "\n")

print("--- Task 7: Calculations on Salary ---")
salary_column = employee_table["salary"]
print("Average salary:", pc.mean(salary_column).as_py())
print("Maximum salary:", pc.max(salary_column).as_py())
print("Minimum salary:", pc.min(salary_column).as_py())
print("Total salary:", pc.sum(salary_column).as_py(), "\n")

print("--- Task 8: Add 'bonus' Column ---")
bonus_column = pc.multiply(employee_table["salary"], 0.10)
employee_table = employee_table.append_column("bonus", bonus_column)
print(employee_table, "\n")

print("--- Task 9: Arrow to Pandas DataFrame ---")
employee_df = employee_table.to_pandas()
print(employee_df, "\n")

print("--- Task 10: Pandas back to Arrow Table ---")
new_arrow_table = pa.Table.from_pandas(employee_df, preserve_index=False)
print(new_arrow_table, "\n")

print("--- Task 11: Save to employees.parquet ---")
pq.write_table(employee_table, "employees.parquet")
print("employees.parquet created successfully.\n")

print("--- Task 12: Read employees.parquet ---")
loaded_table = pq.read_table("employees.parquet")
print(loaded_table, "\n")

print("--- Task 13: Save to employees.arrow ---")
with ipc.new_file("employees.arrow", employee_table.schema) as writer:
    writer.write_table(employee_table)
print("employees.arrow created successfully.\n")

print("--- Task 14: Read employees.arrow ---")
with ipc.open_file("employees.arrow") as reader:
    ipc_table = reader.read_all()
print(ipc_table, "\n")

print("--- Bonus 1: Employees who work in Delhi ---")
delhi_filter = pc.equal(employee_table["city"], "Delhi")
print(employee_table.filter(delhi_filter), "\n")

print("--- Bonus 2: Salary between 50000 and 65000 ---")
salary_between_filter = pc.and_(
    pc.greater_equal(employee_table["salary"], 50000),
    pc.less_equal(employee_table["salary"], 65000)
)
print(employee_table.filter(salary_between_filter), "\n")

print("--- Bonus 3: Add 'annual_salary' Column (salary * 12) ---")
annual_salary_column = pc.multiply(employee_table["salary"], 12)
employee_table_with_annual = employee_table.append_column("annual_salary", annual_salary_column)
print(employee_table_with_annual, "\n")

print("--- Bonus 4: Save IT employees to it_employees.parquet ---")
it_table = employee_table.filter(pc.equal(employee_table["department"], "IT"))
pq.write_table(it_table, "it_employees.parquet")
print("it_employees.parquet created successfully.\n")

print("--- Bonus 5: Read only 'name' and 'salary' from Parquet ---")
selected_columns = pq.read_table("employees.parquet", columns=["name", "salary"])
print(selected_columns, "\n")

print("--- Bonus 6: Sort employees by salary (DESC) ---")
sorted_indices = pc.sort_indices(employee_table["salary"], sort_keys=[("salary", "descending")])
sorted_table = employee_table.take(sorted_indices)
print(sorted_table, "\n")
