import pyarrow as pa
import pyarrow.compute as pc

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Asha", "Rahul", "Swomya", "Pavan", "Priya", "Arjun"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)

department_filter = pc.equal(
    employee_table["department"],
    "IT"
)

it_employees = employee_table.filter(department_filter)

print(it_employees)