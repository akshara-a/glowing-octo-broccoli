import pyarrow as pa
import pyarrow.compute as pc
import pyarrow.parquet as pq
import pyarrow.ipc as ipc


# Task 1: Create Arrow Table
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


# Task 2: Schema
print("\nSchema")
print(employee_table.schema)

print("\nAnswers:")
print("employee_id:", employee_table.schema.field("employee_id").type)
print("name:", employee_table.schema.field("name").type)
print("salary:", employee_table.schema.field("salary").type)


# Task 3: Inspect Table
print("\nRows:", employee_table.num_rows)
print("Columns:", employee_table.num_columns)
print("Column Names:", employee_table.column_names)
print("\nName Column")
print(employee_table.column("name"))
print("\nFirst Three Rows")
print(employee_table.slice(0, 3))


# Task 4: Select Columns
selected_table = employee_table.select(
    ["name", "department", "salary"]
)
print("\nSelected Columns")
print(selected_table)


# Task 5: Salary > 50000
salary_filter = pc.greater(
    employee_table["salary"],
    50000
)
high_salary_table = employee_table.filter(salary_filter)

print("\nSalary > 50000")
print(high_salary_table)


# Task 6: IT Employees
department_filter = pc.equal(
    employee_table["department"],
    "IT"
)
it_employees = employee_table.filter(department_filter)

print("\nIT Employees")
print(it_employees)


# Task 7: Calculations
salary_column = employee_table["salary"]

print("\nCalculations")
print("Average Salary:", pc.mean(salary_column).as_py())
print("Maximum Salary:", pc.max(salary_column).as_py())
print("Minimum Salary:", pc.min(salary_column).as_py())
print("Total Salary:", pc.sum(salary_column).as_py())


# Task 8: Bonus Column
bonus_column = pc.multiply(
    employee_table["salary"],
    0.10
)
employee_table = employee_table.append_column(
    "bonus",
    bonus_column
)

print("\nEmployee Table with Bonus")
print(employee_table)


# Task 9: Arrow -> Pandas
employee_df = employee_table.to_pandas()
print("\nPandas DataFrame")
print(employee_df)


# Task 10: Pandas -> Arrow
new_arrow_table = pa.Table.from_pandas(
    employee_df,
    preserve_index=False
)

print("\nArrow Table from Pandas")
print(new_arrow_table)


# Task 11: Save Parquet
pq.write_table(
    employee_table,
    "employees.parquet"
)

print("\nemployees.parquet created successfully.")


# Task 12: Read Parquet
loaded_table = pq.read_table(
    "employees.parquet"
)
print("\nLoaded Parquet")
print(loaded_table)


# Task 13: Save Arrow IPC
with ipc.new_file(
    "employees.arrow",
    employee_table.schema
) as writer:
    writer.write_table(employee_table)

print("\nemployees.arrow created successfully.")


# Task 14: Read Arrow IPC
with ipc.open_file(
    "employees.arrow"
) as reader:
    ipc_table = reader.read_all()

print("\nLoaded Arrow IPC")
print(ipc_table)


# Bonus Tasks
print("\nBonus 1: Employees in Delhi")
delhi_filter = pc.equal(employee_table["city"], "Delhi")
print(employee_table.filter(delhi_filter))

print("\nBonus 2: Salary between 50000 and 65000")
salary_between = pc.and_(
    pc.greater_equal(employee_table["salary"], 50000),
    pc.less_equal(employee_table["salary"], 65000)
)
print(employee_table.filter(salary_between))

print("\nBonus 3: Annual Salary")
annual_salary = pc.multiply(employee_table["salary"], 12)

employee_table = employee_table.append_column(
    "annual_salary",
    annual_salary
)
print(employee_table)

print("\nBonus 4: Save IT Employees")
pq.write_table(
    it_employees,
    "it_employees.parquet"
)
print("it_employees.parquet created.")

print("\nBonus 5: Read only Name and Salary")
selected_columns = pq.read_table(
    "employees.parquet",
    columns=["name", "salary"]
)
print(selected_columns)
print("\nBonus 6: Sort by Salary Descending")

salary_indices = pc.sort_indices(
    employee_table,
    sort_keys=[("salary", "descending")]
)
sorted_table = employee_table.take(salary_indices)
print(sorted_table)