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

salary_range_filter = pc.and_(
    pc.greater_equal(
        employee_table["salary"],
        50000
    ),
    pc.less_equal(
        employee_table["salary"],
        65000
    )
)

salary_range_table = employee_table.filter(
    salary_range_filter
)

print("\n=== BONUS 2: SALARY 50000 - 65000 ===")
print(salary_range_table)