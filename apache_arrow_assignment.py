import pyarrow as pa
import pyarrow.compute as pc
import pyarrow.parquet as pq
import pyarrow.ipc as ipc
import pandas as pd

# --------------------------------------------------
# Task 1: Create an Arrow Table
# --------------------------------------------------

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya", "Arjun"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)

print("Task 1: Arrow Table")
print(employee_table)

# --------------------------------------------------
# Task 2: Display Schema
# --------------------------------------------------

print("\nTask 2: Schema")
print(employee_table.schema)

print("\nData Types")
print("employee_id:", employee_table.schema.field("employee_id").type)
print("name:", employee_table.schema.field("name").type)
print("salary:", employee_table.schema.field("salary").type)

# --------------------------------------------------
# Task 3: Inspect the Table
# --------------------------------------------------

print("\nTask 3: Table Information")

print("Number of Rows:", employee_table.num_rows)
print("Number of Columns:", employee_table.num_columns)
print("Column Names:", employee_table.column_names)

print("\nName Column")
print(employee_table.column("name"))

print("\nFirst Three Rows")
print(employee_table.slice(0, 3))

# --------------------------------------------------
# Task 4: Select Specific Columns
# --------------------------------------------------

print("\nTask 4: Selected Columns")

selected_table = employee_table.select(
    ["name", "department", "salary"]
)

print(selected_table)

# --------------------------------------------------
# Task 5: Filter Salary > 50000
# --------------------------------------------------

print("\nTask 5: Salary Greater Than 50000")

salary_filter = pc.greater(
    employee_table["salary"],
    50000
)

high_salary_table = employee_table.filter(salary_filter)

print(high_salary_table)

# --------------------------------------------------
# Task 6: IT Employees
# --------------------------------------------------

print("\nTask 6: IT Employees")

department_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_employees = employee_table.filter(department_filter)

print(it_employees)

# --------------------------------------------------
# Task 7: Salary Calculations
# --------------------------------------------------

print("\nTask 7: Salary Calculations")

salary_column = employee_table["salary"]

print("Average Salary:", pc.mean(salary_column).as_py())
print("Maximum Salary:", pc.max(salary_column).as_py())
print("Minimum Salary:", pc.min(salary_column).as_py())
print("Total Salary:", pc.sum(salary_column).as_py())

# --------------------------------------------------
# Task 8: Add Bonus Column
# --------------------------------------------------

print("\nTask 8: Bonus Column")

bonus_column = pc.multiply(
    employee_table["salary"],
    0.10
)

employee_table = employee_table.append_column(
    "bonus",
    bonus_column
)

print(employee_table)

# --------------------------------------------------
# Task 9: Arrow to Pandas
# --------------------------------------------------

print("\nTask 9: Arrow to Pandas")

employee_df = employee_table.to_pandas()

print(employee_df)

# --------------------------------------------------
# Task 10: Pandas to Arrow
# --------------------------------------------------

print("\nTask 10: Pandas to Arrow")

new_arrow_table = pa.Table.from_pandas(
    employee_df,
    preserve_index=False
)

print(new_arrow_table)

# --------------------------------------------------
# Task 11: Save as Parquet
# --------------------------------------------------

pq.write_table(
    employee_table,
    "employees.parquet"
)

print("\nTask 11: employees.parquet created successfully.")

# --------------------------------------------------
# Task 12: Read Parquet
# --------------------------------------------------

print("\nTask 12: Read Parquet")

loaded_table = pq.read_table(
    "employees.parquet"
)

print(loaded_table)

# --------------------------------------------------
# Task 13: Save Arrow IPC File
# --------------------------------------------------

with ipc.new_file(
    "employees.arrow",
    employee_table.schema
) as writer:
    writer.write_table(employee_table)

print("\nTask 13: employees.arrow created successfully.")

# --------------------------------------------------
# Task 14: Read Arrow IPC File
# --------------------------------------------------

print("\nTask 14: Read Arrow IPC File")

with ipc.open_file("employees.arrow") as reader:
    ipc_table = reader.read_all()

print(ipc_table)

# ==================================================
# BONUS TASKS
# ==================================================

print("\nBonus 1: Employees from Delhi")

delhi_filter = pc.equal(
    employee_table["city"],
    "Delhi"
)

print(employee_table.filter(delhi_filter))

print("\nBonus 2: Salary Between 50000 and 65000")

salary_range = pc.and_(
    pc.greater_equal(employee_table["salary"], 50000),
    pc.less_equal(employee_table["salary"], 65000)
)

print(employee_table.filter(salary_range))

print("\nBonus 3: Annual Salary")

annual_salary = pc.multiply(
    employee_table["salary"],
    12
)

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

print("it_employees.parquet created successfully.")

print("\nBonus 5: Read Only Name and Salary")

selected_columns = pq.read_table(
    "employees.parquet",
    columns=["name", "salary"]
)

print(selected_columns)

print("\nBonus 6: Sort by Salary Descending")

sorted_df = employee_table.to_pandas()

sorted_df = sorted_df.sort_values(
    by="salary",
    ascending=False
)

print(sorted_df)