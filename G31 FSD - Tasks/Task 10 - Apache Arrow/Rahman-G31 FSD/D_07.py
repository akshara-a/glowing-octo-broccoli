import pyarrow as pa
import pyarrow.compute as pc

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Sharif", "Sam", "Saim", "Waq", "Rashid", "Abhi"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)

salary_column = employee_table["salary"]

print("\n=== TASK 7: SALARY CALCULATIONS ===")

print(
    "Average salary:",
    pc.mean(salary_column).as_py()
)

print(
    "Maximum salary:",
    pc.max(salary_column).as_py()
)

print(
    "Minimum salary:",
    pc.min(salary_column).as_py()
)

print(
    "Total salary:",
    pc.sum(salary_column).as_py()
)