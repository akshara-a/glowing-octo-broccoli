import pyarrow as pa
import pyarrow.compute as pc
import pyarrow.parquet as pq
import pyarrow.ipc as ipc
import pandas as pd

# =====================================================
# Task 1: Create Arrow Table
# =====================================================

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya", "Arjun"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)

print("===== Employee Table =====")
print(employee_table)

# =====================================================
# Task 2: Display Schema
# =====================================================

print("\n===== Schema =====")
print(employee_table.schema)

# =====================================================
# Task 3: Inspect Table
# =====================================================

print("\nRows:", employee_table.num_rows)
print("Columns:", employee_table.num_columns)
print("Column Names:", employee_table.column_names)

print("\n===== Name Column =====")
print(employee_table.column("name"))

print("\n===== First Three Rows =====")
print(employee_table.slice(0, 3))

# =====================================================
# Task 4: Select Columns
# =====================================================

selected_table = employee_table.select(
    ["name", "department", "salary"]
)

print("\n===== Selected Columns =====")
print(selected_table)

# =====================================================
# Task 5: Filter Salary > 50000
# =====================================================

salary_filter = pc.greater(
    employee_table["salary"],
    50000
)

high_salary = employee_table.filter(salary_filter)

print("\n===== Salary > 50000 =====")
print(high_salary)

# =====================================================
# Task 6: IT Department
# =====================================================

department_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_employees = employee_table.filter(department_filter)

print("\n===== IT Employees =====")
print(it_employees)

# =====================================================
# Task 7: Calculations
# =====================================================

salary = employee_table["salary"]

print("\n===== Salary Statistics =====")

print("Average Salary :", pc.mean(salary).as_py())
print("Maximum Salary :", pc.max(salary).as_py())
print("Minimum Salary :", pc.min(salary).as_py())
print("Total Salary   :", pc.sum(salary).as_py())

# =====================================================
# Task 8: Add Bonus Column
# =====================================================

bonus = pc.multiply(
    employee_table["salary"],
    0.10
)

employee_table = employee_table.append_column(
    "bonus",
    bonus
)

print("\n===== Table with Bonus =====")
print(employee_table)

# =====================================================
# Task 9: Arrow to Pandas
# =====================================================

employee_df = employee_table.to_pandas()

print("\n===== Pandas DataFrame =====")
print(employee_df)

# =====================================================
# Task 10: Pandas to Arrow
# =====================================================

new_arrow_table = pa.Table.from_pandas(
    employee_df,
    preserve_index=False
)

print("\n===== Arrow Table Again =====")
print(new_arrow_table)

# =====================================================
# Task 11: Save Parquet
# =====================================================

pq.write_table(
    employee_table,
    "employees.parquet"
)

print("\nemployees.parquet created successfully.")

# =====================================================
# Task 12: Read Parquet
# =====================================================

loaded_table = pq.read_table(
    "employees.parquet"
)

print("\n===== Loaded Parquet =====")
print(loaded_table)

# =====================================================
# Task 13: Save Arrow IPC
# =====================================================

with ipc.new_file(
    "employees.arrow",
    employee_table.schema
) as writer:
    writer.write_table(employee_table)

print("\nemployees.arrow created successfully.")

# =====================================================
# Task 14: Read Arrow IPC
# =====================================================

with ipc.open_file("employees.arrow") as reader:
    ipc_table = reader.read_all()

print("\n===== Arrow IPC Data =====")
print(ipc_table)

# =====================================================
# Bonus Task 1
# =====================================================

print("\n===== Employees in Delhi =====")

delhi = employee_table.filter(
    pc.equal(employee_table["city"], "Delhi")
)

print(delhi)

# =====================================================
# Bonus Task 2
# =====================================================

between_salary = employee_table.filter(
    pc.and_(
        pc.greater_equal(employee_table["salary"], 50000),
        pc.less_equal(employee_table["salary"], 65000)
    )
)

print("\n===== Salary Between 50000 and 65000 =====")
print(between_salary)

# =====================================================
# Bonus Task 3
# =====================================================

annual_salary = pc.multiply(
    employee_table["salary"],
    12
)

employee_table = employee_table.append_column(
    "annual_salary",
    annual_salary
)

print("\n===== Annual Salary Added =====")
print(employee_table)

# =====================================================
# Bonus Task 4
# =====================================================

it_table = employee_table.filter(
    pc.equal(employee_table["department"], "IT")
)

pq.write_table(
    it_table,
    "it_employees.parquet"
)

print("\nit_employees.parquet created successfully.")

# =====================================================
# Bonus Task 5
# =====================================================

selected_columns = pq.read_table(
    "employees.parquet",
    columns=["name", "salary"]
)

print("\n===== Name and Salary =====")
print(selected_columns)

# =====================================================
# Bonus Task 6
# =====================================================

sorted_df = employee_table.to_pandas().sort_values(
    by="salary",
    ascending=False
)

sorted_table = pa.Table.from_pandas(
    sorted_df,
    preserve_index=False
)

print("\n===== Sorted by Salary =====")
print(sorted_table)