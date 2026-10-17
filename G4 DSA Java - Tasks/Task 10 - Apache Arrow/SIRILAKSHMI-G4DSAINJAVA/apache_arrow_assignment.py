import pyarrow as pa

# -----------------------------
# Task 1: Create an Arrow Table
# -----------------------------

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya", "Arjun"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)

print("========== Task 1: Arrow Table ==========")
print(employee_table)


# -----------------------------
# Task 2: Display the Schema
# -----------------------------

print("\n========== Task 2: Schema ==========")
print(employee_table.schema)

print("\nAnswers:")
print("employee_id data type :", employee_table.schema.field("employee_id").type)
print("name data type        :", employee_table.schema.field("name").type)
print("salary data type      :", employee_table.schema.field("salary").type)


# -----------------------------
# Task 3: Inspect the Table
# -----------------------------

print("\n========== Task 3: Table Information ==========")

print("Number of Rows:", employee_table.num_rows)
print("Number of Columns:", employee_table.num_columns)
print("Column Names:", employee_table.column_names)

print("\nName Column:")
print(employee_table.column("name"))

print("\nFirst Three Rows:")
print(employee_table.slice(0, 3))


# -----------------------------
# Task 4: Select Specific Columns
# -----------------------------

selected_table = employee_table.select(
    ["name", "department", "salary"]
)

print("\n========== Task 4: Selected Columns ==========")
print(selected_table)
# -----------------------------
# Task 5: Filter Records
# -----------------------------
import pyarrow.compute as pc

salary_filter = pc.greater(
    employee_table["salary"],
    50000
)

high_salary_table = employee_table.filter(salary_filter)

print("Employees with salary > 50000:")
print(high_salary_table)


# -----------------------------
# Task 6: Filter by Department
# -----------------------------
department_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_employees = employee_table.filter(department_filter)

print("\nIT Department Employees:")
print(it_employees)


# -----------------------------
# Task 7: Perform Calculations
# -----------------------------
salary_column = employee_table["salary"]

print("\nSalary Statistics")
print("Average Salary:", pc.mean(salary_column).as_py())
print("Maximum Salary:", pc.max(salary_column).as_py())
print("Minimum Salary:", pc.min(salary_column).as_py())
print("Total Salary:", pc.sum(salary_column).as_py())


# -----------------------------
# Task 8: Add a New Column
# -----------------------------
bonus_column = pc.multiply(
    employee_table["salary"],
    0.10
)

employee_table = employee_table.append_column(
    "bonus",
    bonus_column
)

print("\nEmployee Table with Bonus Column:")
print(employee_table)


# -----------------------------
# Task 9: Convert Arrow to Pandas
# -----------------------------
employee_df = employee_table.to_pandas()

print("\nPandas DataFrame:")
print(employee_df)


# -----------------------------
# Task 10: Convert Pandas to Arrow
# -----------------------------
import pyarrow as pa

new_arrow_table = pa.Table.from_pandas(
    employee_df,
    preserve_index=False
)

print("\nArrow Table:")
print(new_arrow_table)
# -----------------------------
# Task 11: Save as a Parquet File
# -----------------------------
import pyarrow.parquet as pq

pq.write_table(
    employee_table,
    "employees.parquet"
)

print("Parquet file created successfully.")


# -----------------------------
# Task 12: Read the Parquet File
# -----------------------------
loaded_table = pq.read_table(
    "employees.parquet"
)

print("\nContents of employees.parquet:")
print(loaded_table)


# -----------------------------
# Task 13: Save as an Arrow IPC File
# -----------------------------
import pyarrow.ipc as ipc

with ipc.new_file(
    "employees.arrow",
    employee_table.schema
) as writer:
    writer.write_table(employee_table)

print("\nArrow IPC file created successfully.")


# -----------------------------
# Task 14: Read the Arrow IPC File
# -----------------------------
with ipc.open_file("employees.arrow") as reader:
    ipc_table = reader.read_all()

print("\nContents of employees.arrow:")
print(ipc_table)
# -----------------------------
# Bonus Task 1:
# Display employees who work in Delhi
# -----------------------------
import pyarrow.compute as pc
import pyarrow.parquet as pq

city_filter = pc.equal(
    employee_table["city"],
    "Delhi"
)

delhi_employees = employee_table.filter(city_filter)

print("Employees in Delhi:")
print(delhi_employees)


# -----------------------------
# Bonus Task 2:
# Display employees with salaries
# between 50000 and 65000
# -----------------------------
salary_filter = pc.and_(
    pc.greater_equal(employee_table["salary"], 50000),
    pc.less_equal(employee_table["salary"], 65000)
)

salary_range = employee_table.filter(salary_filter)

print("\nEmployees with salary between 50000 and 65000:")
print(salary_range)


# -----------------------------
# Bonus Task 3:
# Add annual_salary column
# -----------------------------
annual_salary = pc.multiply(
    employee_table["salary"],
    12
)

employee_table = employee_table.append_column(
    "annual_salary",
    annual_salary
)

print("\nEmployee Table with Annual Salary:")
print(employee_table)


# -----------------------------
# Bonus Task 4:
# Save only IT employees
# to it_employees.parquet
# -----------------------------
it_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_employees = employee_table.filter(it_filter)

pq.write_table(
    it_employees,
    "it_employees.parquet"
)

print("\nit_employees.parquet created successfully.")


# -----------------------------
# Bonus Task 5:
# Read only name and salary columns
# -----------------------------
selected_columns = pq.read_table(
    "employees.parquet",
    columns=["name", "salary"]
)

print("\nSelected Columns:")
print(selected_columns)


# -----------------------------
# Bonus Task 6:
# Sort employees by salary
# (Highest to Lowest)
# -----------------------------
sorted_table = employee_table.sort_by(
    [("salary", "descending")]
)

print("\nEmployees sorted by salary (Highest to Lowest):")
print(sorted_table)