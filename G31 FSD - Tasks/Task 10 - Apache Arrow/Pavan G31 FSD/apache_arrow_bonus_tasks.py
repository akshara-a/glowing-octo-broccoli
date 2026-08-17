import pyarrow as pa
import pyarrow.compute as pc
import pyarrow.parquet as pq

# Create Employee Data

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Asha", "Rahul", "Swomya", "Pavan", "Priya", "Arjun"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)

# =====================================================
# Bonus Task 1: Display employees who work in Delhi
# =====================================================

print("========== Bonus Task 1 ==========")

city_filter = pc.equal(employee_table["city"], "Delhi")

delhi_employees = employee_table.filter(city_filter)

print(delhi_employees)


# =====================================================
# Bonus Task 2: Employees with salary between
#               50000 and 65000
# =====================================================

print("\n========== Bonus Task 2 ==========")

salary_filter = pc.and_(
    pc.greater_equal(employee_table["salary"], 50000),
    pc.less_equal(employee_table["salary"], 65000)
)

salary_table = employee_table.filter(salary_filter)

print(salary_table)


# =====================================================
# Bonus Task 3: Add Annual Salary Column
# =====================================================

print("\n========== Bonus Task 3 ==========")

annual_salary = pc.multiply(
    employee_table["salary"],
    12
)

annual_salary_table = employee_table.append_column(
    "annual_salary",
    annual_salary
)

print(annual_salary_table)


# =====================================================
# Bonus Task 4: Save only IT Employees
# =====================================================

print("\n========== Bonus Task 4 ==========")

it_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_employees = employee_table.filter(it_filter)

pq.write_table(
    it_employees,
    "it_employees.parquet"
)

print("IT employees saved successfully!")


# =====================================================
# Bonus Task 5: Read only Name and Salary Columns
# =====================================================

print("\n========== Bonus Task 5 ==========")

selected_columns = pq.read_table(
    "employees.parquet",
    columns=["name", "salary"]
)

print(selected_columns)


# =====================================================
# Bonus Task 6: Sort Salary Highest to Lowest
# =====================================================

print("\n========== Bonus Task 6 ==========")

sorted_indices = pc.sort_indices(
    employee_table,
    sort_keys=[("salary", "descending")]
)

sorted_table = pc.take(
    employee_table,
    sorted_indices
)

print(sorted_table)
