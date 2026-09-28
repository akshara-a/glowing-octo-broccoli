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

print("Arrow Table")
print(employee_table)

print("\nSchema")
print(employee_table.schema)

print("\nRows:", employee_table.num_rows)
print("Columns:", employee_table.num_columns)
print("Column Names:", employee_table.column_names)

print("\nName Column")
print(employee_table.column("name"))

print("\nFirst Three Rows")
print(employee_table.slice(0, 3))

selected_table = employee_table.select(["name", "department", "salary"])

print("\nSelected Columns")
print(selected_table)

salary_filter = pc.greater(employee_table["salary"], 50000)
high_salary = employee_table.filter(salary_filter)

print("\nSalary > 50000")
print(high_salary)

department_filter = pc.equal(employee_table["department"], "IT")
it_employees = employee_table.filter(department_filter)

print("\nIT Employees")
print(it_employees)

salary = employee_table["salary"]

print("\nAverage Salary:", pc.mean(salary).as_py())
print("Maximum Salary:", pc.max(salary).as_py())
print("Minimum Salary:", pc.min(salary).as_py())
print("Total Salary:", pc.sum(salary).as_py())

bonus = pc.multiply(employee_table["salary"], 0.10)

employee_table = employee_table.append_column("bonus", bonus)

print("\nTable with Bonus")
print(employee_table)

employee_df = employee_table.to_pandas()

print("\nArrow to Pandas")
print(employee_df)

new_table = pa.Table.from_pandas(employee_df, preserve_index=False)

print("\nPandas to Arrow")
print(new_table)

pq.write_table(employee_table, "employees.parquet")

print("\nemployees.parquet created")

loaded_table = pq.read_table("employees.parquet")

print("\nRead Parquet File")
print(loaded_table)

with ipc.new_file("employees.arrow", employee_table.schema) as writer:
    writer.write_table(employee_table)

print("\nemployees.arrow created")

with ipc.open_file("employees.arrow") as reader:
    ipc_table = reader.read_all()

print("\nRead Arrow File")
print(ipc_table)

delhi = employee_table.filter(pc.equal(employee_table["city"], "Delhi"))

print("\nEmployees from Delhi")
print(delhi)

salary_range = employee_table.filter(
    pc.and_(
        pc.greater_equal(employee_table["salary"], 50000),
        pc.less_equal(employee_table["salary"], 65000)
    )
)

print("\nSalary Between 50000 and 65000")
print(salary_range)

annual_salary = pc.multiply(employee_table["salary"], 12)

employee_table = employee_table.append_column("annual_salary", annual_salary)

print("\nTable with Annual Salary")
print(employee_table)

pq.write_table(it_employees, "it_employees.parquet")

print("\nit_employees.parquet created")

selected = pq.read_table(
    "employees.parquet",
    columns=["name", "salary"]
)

print("\nSelected Columns from Parquet")
print(selected)

sorted_table = employee_table.sort_by([("salary", "descending")])

print("\nSorted by Salary")
print(sorted_table)