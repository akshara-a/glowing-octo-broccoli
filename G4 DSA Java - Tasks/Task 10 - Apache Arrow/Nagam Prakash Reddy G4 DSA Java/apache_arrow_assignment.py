import pyarrow as pa
import pyarrow.compute as pc
import pyarrow.parquet as pq
import pyarrow.ipc as ipc


# ============================================================
# TASK 1: Create an Arrow Table
# ============================================================

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],

    "name": [
        "Asha",
        "Rahul",
        "Neha",
        "Vikram",
        "Priya",
        "Arjun"
    ],

    "department": [
        "IT",
        "HR",
        "IT",
        "Finance",
        "HR",
        "Finance"
    ],

    "salary": [
        60000,
        45000,
        70000,
        55000,
        48000,
        65000
    ],

    "city": [
        "Delhi",
        "Mumbai",
        "Bengaluru",
        "Delhi",
        "Mumbai",
        "Chennai"
    ]
}


employee_table = pa.table(data)

print("================================================")
print("TASK 1: Arrow Table")
print("================================================")
print(employee_table)
print()


# ============================================================
# TASK 2: Display Schema
# ============================================================

print("================================================")
print("TASK 2: Arrow Table Schema")
print("================================================")
print(employee_table.schema)

print("\nData Types:")
print("employee_id:", employee_table.schema.field("employee_id").type)
print("name:", employee_table.schema.field("name").type)
print("salary:", employee_table.schema.field("salary").type)
print()


# ============================================================
# TASK 3: Inspect the Table
# ============================================================

print("================================================")
print("TASK 3: Inspect Table")
print("================================================")

print("Rows:", employee_table.num_rows)
print("Columns:", employee_table.num_columns)
print("Column names:", employee_table.column_names)

print("\nName column:")
print(employee_table.column("name"))

print("\nFirst three rows:")
print(employee_table.slice(0, 3))
print()


# ============================================================
# TASK 4: Select Specific Columns
# ============================================================

selected_table = employee_table.select(
    ["name", "department", "salary"]
)

print("================================================")
print("TASK 4: Selected Columns")
print("================================================")
print(selected_table)
print()


# ============================================================
# TASK 5: Filter Salary > 50000
# ============================================================

salary_filter = pc.greater(
    employee_table["salary"],
    50000
)

high_salary_table = employee_table.filter(
    salary_filter
)

print("================================================")
print("TASK 5: Salary Greater Than 50000")
print("================================================")
print(high_salary_table)
print()


# ============================================================
# TASK 6: Filter IT Department
# ============================================================

department_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_employees = employee_table.filter(
    department_filter
)

print("================================================")
print("TASK 6: IT Department Employees")
print("================================================")
print(it_employees)
print()


# ============================================================
# TASK 7: Perform Calculations
# ============================================================

salary_column = employee_table["salary"]

average_salary = pc.mean(salary_column).as_py()
maximum_salary = pc.max(salary_column).as_py()
minimum_salary = pc.min(salary_column).as_py()
total_salary = pc.sum(salary_column).as_py()

print("================================================")
print("TASK 7: Salary Calculations")
print("================================================")

print("Average salary:", average_salary)
print("Maximum salary:", maximum_salary)
print("Minimum salary:", minimum_salary)
print("Total salary:", total_salary)
print()


# ============================================================
# TASK 8: Add Bonus Column
# ============================================================

bonus_column = pc.multiply(
    employee_table["salary"],
    0.10
)

employee_table = employee_table.append_column(
    "bonus",
    bonus_column
)

print("================================================")
print("TASK 8: Table With Bonus Column")
print("================================================")
print(employee_table)
print()


# ============================================================
# TASK 9: Convert Arrow to Pandas
# ============================================================

employee_df = employee_table.to_pandas()

print("================================================")
print("TASK 9: Arrow To Pandas")
print("================================================")
print(employee_df)
print()


# ============================================================
# TASK 10: Convert Pandas to Arrow
# ============================================================

new_arrow_table = pa.Table.from_pandas(
    employee_df,
    preserve_index=False
)

print("================================================")
print("TASK 10: Pandas To Arrow")
print("================================================")
print(new_arrow_table)
print()


# ============================================================
# TASK 11: Save as Parquet
# ============================================================

pq.write_table(
    employee_table,
    "employees.parquet"
)

print("================================================")
print("TASK 11: Save Parquet")
print("================================================")
print("employees.parquet created successfully.")
print()


# ============================================================
# TASK 12: Read Parquet File
# ============================================================

loaded_table = pq.read_table(
    "employees.parquet"
)

print("================================================")
print("TASK 12: Read Parquet")
print("================================================")
print(loaded_table)
print()


# ============================================================
# TASK 13: Save as Apache Arrow IPC File
# ============================================================

with ipc.new_file(
    "employees.arrow",
    employee_table.schema
) as writer:

    writer.write_table(employee_table)


print("================================================")
print("TASK 13: Save Arrow IPC File")
print("================================================")
print("employees.arrow created successfully.")
print()


# ============================================================
# TASK 14: Read Arrow IPC File
# ============================================================

with ipc.open_file("employees.arrow") as reader:

    ipc_table = reader.read_all()


print("================================================")
print("TASK 14: Read Arrow IPC File")
print("================================================")
print(ipc_table)
print()


# ============================================================
# BONUS 1: Employees From Delhi
# ============================================================

delhi_filter = pc.equal(
    employee_table["city"],
    "Delhi"
)

delhi_employees = employee_table.filter(
    delhi_filter
)

print("================================================")
print("BONUS 1: Employees From Delhi")
print("================================================")
print(delhi_employees)
print()


# ============================================================
# BONUS 2: Salary Between 50000 and 65000
# ============================================================

salary_min = pc.greater_equal(
    employee_table["salary"],
    50000
)

salary_max = pc.less_equal(
    employee_table["salary"],
    65000
)

salary_range_filter = pc.and_(
    salary_min,
    salary_max
)

salary_range = employee_table.filter(
    salary_range_filter
)

print("================================================")
print("BONUS 2: Salary Between 50000 and 65000")
print("================================================")
print(salary_range)
print()


# ============================================================
# BONUS 3: Add Annual Salary Column
# ============================================================

annual_salary = pc.multiply(
    employee_table["salary"],
    12
)

employee_table = employee_table.append_column(
    "annual_salary",
    annual_salary
)

print("================================================")
print("BONUS 3: Annual Salary Column")
print("================================================")
print(employee_table)
print()


# ============================================================
# BONUS 4: Save IT Employees
# ============================================================

it_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_table = employee_table.filter(
    it_filter
)

pq.write_table(
    it_table,
    "it_employees.parquet"
)

print("================================================")
print("BONUS 4: IT Employees Parquet")
print("================================================")
print("it_employees.parquet created successfully.")
print()


# ============================================================
# BONUS 5: Read Only Name and Salary
# ============================================================

selected_columns = pq.read_table(
    "employees.parquet",
    columns=["name", "salary"]
)

print("================================================")
print("BONUS 5: Name and Salary Only")
print("================================================")
print(selected_columns)
print()


# ============================================================
# BONUS 6: Sort By Salary Highest To Lowest
# ============================================================

sort_indices = pc.sort_indices(
    employee_table,
    sort_keys=[
        ("salary", "descending")
    ]
)

sorted_employees = pc.take(
    employee_table,
    sort_indices
)

print("================================================")
print("BONUS 6: Employees Sorted By Salary")
print("================================================")
print(sorted_employees)
print()


# ============================================================
# COMPLETED
# ============================================================

print("================================================")
print("All Apache Arrow Tasks Completed Successfully!")
print("================================================")