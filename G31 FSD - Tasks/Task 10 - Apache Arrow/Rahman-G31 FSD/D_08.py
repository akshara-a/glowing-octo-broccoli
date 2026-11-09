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

bonus = pc.multiply(
    employee_table["salary"],
    0.10
)

bonus = employee_table.append_column(
    "employee_bonus",
    bonus
)

print("\n=== TASK 8: BONUS COLUMN ===")
print(bonus)