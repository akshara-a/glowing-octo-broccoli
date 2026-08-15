import pyarrow as pa
import pyarrow.compute as pc
import pyarrow.parquet as pq
import pyarrow.ipc as ipc


# ============================================================
# TASK 1: CREATE AN ARROW TABLE
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

print("\n========================================")
print("TASK 1: CREATE ARROW TABLE")
print("========================================")

print(employee_table)


# ============================================================
# TASK 2: DISPLAY THE SCHEMA
# ============================================================

print("\n========================================")
print("TASK 2: DISPLAY SCHEMA")
print("========================================")

print(employee_table.schema)

print("\nData Type of employee_id:",
      employee_table.schema.field("employee_id").type)

print("Data Type of name:",
      employee_table.schema.field("name").type)

print("Data Type of salary:",
      employee_table.schema.field("salary").type)


# ============================================================
# TASK 3: INSPECT THE TABLE
# ============================================================

print("\n========================================")
print("TASK 3: INSPECT TABLE")
print("========================================")

# Number of rows
print("Number of rows:",
      employee_table.num_rows)

# Number of columns
print("Number of columns:",
      employee_table.num_columns)

# Column names
print("Column names:",
      employee_table.column_names)

# Name column
print("\nName column:")
print(employee_table.column("name"))

# First three rows
print("\nFirst three rows:")
print(employee_table.slice(0, 3))


# ============================================================
# TASK 4: SELECT SPECIFIC COLUMNS
# ============================================================

print("\n========================================")
print("TASK 4: SELECT SPECIFIC COLUMNS")
print("========================================")

selected_table = employee_table.select(
    ["name", "department", "salary"]
)

print(selected_table)


# ============================================================
# TASK 5: FILTER SALARY GREATER THAN 50000
# ============================================================

print("\n========================================")
print("TASK 5: SALARY GREATER THAN 50000")
print("========================================")

salary_filter = pc.greater(
    employee_table["salary"],
    50000
)

high_salary_table = employee_table.filter(
    salary_filter
)

print(high_salary_table)


# ============================================================
# TASK 6: FILTER BY DEPARTMENT - IT
# ============================================================

print("\n========================================")
print("TASK 6: IT DEPARTMENT EMPLOYEES")
print("========================================")

department_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_employees = employee_table.filter(
    department_filter
)

print(it_employees)


# ============================================================
# TASK 7: PERFORM CALCULATIONS
# ============================================================

print("\n========================================")
print("TASK 7: SALARY CALCULATIONS")
print("========================================")

salary_column = employee_table["salary"]

average_salary = pc.mean(
    salary_column
).as_py()

maximum_salary = pc.max(
    salary_column
).as_py()

minimum_salary = pc.min(
    salary_column
).as_py()

total_salary = pc.sum(
    salary_column
).as_py()

print("Average salary:", average_salary)
print("Maximum salary:", maximum_salary)
print("Minimum salary:", minimum_salary)
print("Total salary:", total_salary)


# ============================================================
# TASK 8: ADD BONUS COLUMN
# ============================================================

print("\n========================================")
print("TASK 8: ADD BONUS COLUMN")
print("========================================")

bonus_column = pc.multiply(
    employee_table["salary"],
    0.10
)

employee_table = employee_table.append_column(
    "bonus",
    bonus_column
)

print(employee_table)


# ============================================================
# TASK 9: CONVERT ARROW TO PANDAS
# ============================================================

print("\n========================================")
print("TASK 9: ARROW TO PANDAS")
print("========================================")

employee_df = employee_table.to_pandas()

print(employee_df)


# ============================================================
# TASK 10: CONVERT PANDAS TO ARROW
# ============================================================

print("\n========================================")
print("TASK 10: PANDAS TO ARROW")
print("========================================")

new_arrow_table = pa.Table.from_pandas(
    employee_df,
    preserve_index=False
)

print(new_arrow_table)


# ============================================================
# TASK 11: SAVE AS PARQUET FILE
# ============================================================

print("\n========================================")
print("TASK 11: SAVE AS PARQUET")
print("========================================")

pq.write_table(
    employee_table,
    "employees.parquet"
)

print("employees.parquet created successfully.")


# ============================================================
# TASK 12: READ PARQUET FILE
# ============================================================

print("\n========================================")
print("TASK 12: READ PARQUET FILE")
print("========================================")

loaded_table = pq.read_table(
    "employees.parquet"
)

print(loaded_table)


# ============================================================
# TASK 13: SAVE AS ARROW IPC FILE
# ============================================================

print("\n========================================")
print("TASK 13: SAVE AS ARROW IPC FILE")
print("========================================")

with ipc.new_file(
    "employees.arrow",
    employee_table.schema
) as writer:

    writer.write_table(
        employee_table
    )

print("employees.arrow created successfully.")


# ============================================================
# TASK 14: READ ARROW IPC FILE
# ============================================================

print("\n========================================")
print("TASK 14: READ ARROW IPC FILE")
print("========================================")

with ipc.open_file(
    "employees.arrow"
) as reader:

    ipc_table = reader.read_all()

print(ipc_table)


# ============================================================
# BONUS 1: EMPLOYEES WORKING IN DELHI
# ============================================================

print("\n========================================")
print("BONUS 1: EMPLOYEES IN DELHI")
print("========================================")

delhi_filter = pc.equal(
    employee_table["city"],
    "Delhi"
)

delhi_employees = employee_table.filter(
    delhi_filter
)

print(delhi_employees)


# ============================================================
# BONUS 2: SALARY BETWEEN 50000 AND 65000
# ============================================================

print("\n========================================")
print("BONUS 2: SALARY BETWEEN 50000 AND 65000")
print("========================================")

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

print(salary_range)


# ============================================================
# BONUS 3: ADD ANNUAL SALARY COLUMN
# ============================================================

print("\n========================================")
print("BONUS 3: ADD ANNUAL SALARY")
print("========================================")

annual_salary_column = pc.multiply(
    employee_table["salary"],
    12
)

employee_table = employee_table.append_column(
    "annual_salary",
    annual_salary_column
)

print(employee_table)


# ============================================================
# BONUS 4: SAVE ONLY IT EMPLOYEES
# ============================================================

print("\n========================================")
print("BONUS 4: SAVE IT EMPLOYEES")
print("========================================")

it_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_employees = employee_table.filter(
    it_filter
)

pq.write_table(
    it_employees,
    "it_employees.parquet"
)

print("it_employees.parquet created successfully.")

print("\nIT employees:")
print(it_employees)


# ============================================================
# BONUS 5: READ ONLY NAME AND SALARY COLUMNS
# ============================================================

print("\n========================================")
print("BONUS 5: READ NAME AND SALARY")
print("========================================")

selected_columns = pq.read_table(
    "employees.parquet",
    columns=["name", "salary"]
)

print(selected_columns)


# ============================================================
# BONUS 6: SORT EMPLOYEES BY SALARY
# ============================================================

print("\n========================================")
print("BONUS 6: SORT BY SALARY DESCENDING")
print("========================================")

sort_indices = pc.sort_indices(
    employee_table,
    sort_keys=[
        ("salary", "descending")
    ]
)

sorted_table = employee_table.take(
    sort_indices
)

print(sorted_table)


# ============================================================
# FINAL MESSAGE
# ============================================================

print("\n========================================")
print("ALL TASKS AND BONUS TASKS COMPLETED!")
print("========================================")

print("\nRequired files created:")
print("1. apache_arrow_assignment.py")
print("2. employees.parquet")
print("3. employees.arrow")

print("\nBonus file created:")
print("4. it_employees.parquet")