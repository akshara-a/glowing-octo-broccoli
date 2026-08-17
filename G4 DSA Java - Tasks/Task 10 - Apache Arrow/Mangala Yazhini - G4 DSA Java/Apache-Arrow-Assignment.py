import pyarrow as pa
import pyarrow.compute as pc
import pyarrow.parquet as pq
import pyarrow.ipc as ipc
import pandas as pd


# Create Arrow Table


data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya", "Arjun"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)

print(employee_table)

print(employee_table.schema)

print("\nEmployee Schema")
print("employee_id datatype :", employee_table.schema.field("employee_id").type)
print("name datatype        :", employee_table.schema.field("name").type)
print("salary datatype      :", employee_table.schema.field("salary").type)
print("Number of Rows :", employee_table.num_rows)
print("Number of Columns :", employee_table.num_columns)
print("Column Names :", employee_table.column_names)


# Selecting three columns from employee table

specific_columns_data = employee_table.select(
    ["name", "department", "salary"]
)

print(specific_columns_data)


print("Retrieving Salary greater 50000")

employee_salary_filter = pc.greater(employee_table["salary"],50000)

high_salary_employee = employee_table.filter(employee_salary_filter)

print(high_salary_employee)



print("IT Department Employees")


employee_department_filter = pc.equal(employee_table["department"], "IT")

it_employees = employee_table.filter(employee_department_filter)

print(it_employees)




print("Employee Salary Calculations")


employee_salary_column = employee_table["salary"]

print("Average Salary :", pc.mean(employee_salary_column).as_py())
print("Maximum Salary :", pc.max(employee_salary_column).as_py())
print("Minimum Salary :", pc.min(employee_salary_column).as_py())
print("Total Salary   :", pc.sum(employee_salary_column).as_py())




print("Append bonus Column to employee table")

bonus_column = pc.multiply(employee_table["salary"],0.10)

employee_table = employee_table.append_column("bonus",bonus_column)

print(employee_table)



# Convert Arrow to Pandas

print("Conversion of Arrow to Pandas")

employee_df = employee_table.to_pandas()

print(employee_df)


# Convert Pandas to Arrow


print("Conversion of Pandas to Arrow")

new_arrow_table = pa.Table.from_pandas(employee_df,preserve_index=False)

print(new_arrow_table)


# Save arrow as Parquet file

print("Save arrow as parquet file")

pq.write_table(employee_table,"employees.parquet")


# Read the Parquet file

print("Read the Parquet file")

stored_employee_table = pq.read_table("employees.parquet")

print(stored_employee_table)


# Save arrow file into Arrow IPC File

print("Save arrow file into Arrow IPC File")

with ipc.new_file("employees.arrow", employee_table.schema) as writer:
    writer.write_table(employee_table)



# Reading the Arrow IPC File

print("Reading the Arrow IPC File")

with ipc.open_file("employees.arrow") as reader:
    ipc_table = reader.read_all()

print(ipc_table)


# Employees in Delhi

print("Employees in Delhi")


delhi_filter = pc.equal(employee_table["city"],"Delhi")

delhi_employees = employee_table.filter(delhi_filter)

print(delhi_employees)


# Employee with Salary Between 50000 and 65000

print("Employee with Salary Between 50000 and 65000")

salary_between = pc.and_(pc.greater_equal(employee_table["salary"], 50000), pc.less_equal(employee_table["salary"], 65000))

salary_between_table = employee_table.filter(salary_between)

print(salary_between_table)


# Annual Salary Column of Employee table

print("Annual Salary of Employee table")

annual_salary = pc.multiply( employee_table["salary"], 12)

employee_table = employee_table.append_column(
    "annual_salary",
    annual_salary
)

print(employee_table)


# Save IT Employees into new parquet file

print("Save IT Employees into new parquet file")

pq.write_table( it_employees, "it_employees.parquet")



print("Bonus Task 5: Read the Selected Columns from employees.parquet file")

selected_employee_columns = pq.read_table( "employees.parquet", columns=["name", "salary"])

print(selected_employee_columns)


# Sort Employee table by Salary 

print("Sort Employee table by Salary ")

sorted_table = employee_table.sort_by(
    [("salary", "descending")]
)

print(sorted_table)
