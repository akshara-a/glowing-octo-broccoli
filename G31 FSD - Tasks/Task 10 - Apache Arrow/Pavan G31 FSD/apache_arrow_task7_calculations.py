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

salary_column = employee_table["salary"]

print("Average Salary :", pc.mean(salary_column).as_py())
print("Maximum Salary :", pc.max(salary_column).as_py())
print("Minimum Salary :", pc.min(salary_column).as_py())
print("Total Salary   :", pc.sum(salary_column).as_py())