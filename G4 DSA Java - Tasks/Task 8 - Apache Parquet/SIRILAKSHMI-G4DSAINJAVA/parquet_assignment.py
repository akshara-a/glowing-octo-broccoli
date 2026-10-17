
import pandas as pd
# ==========================================
# Task 1: Create the DataFrame
# ==========================================

data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}

employees_df = pd.DataFrame(data)

print("=========================================")
print("Task 1: DataFrame Created")
print("=========================================")
print(employees_df)

# ==========================================
# Task 2: Save as Parquet
# ==========================================

employees_df.to_parquet("employees.parquet", index=False)

print("\nemployees.parquet created successfully.")

# ==========================================
# Task 3: Read the Parquet File
# ==========================================

loaded_df = pd.read_parquet("employees.parquet")

print("\n=========================================")
print("Task 3: Employee Records")
print("=========================================")
print(loaded_df)

# ==========================================
# Task 4: Perform Basic Analysis
# ==========================================

print("\n=========================================")
print("Employees with Salary Greater Than 50000")
print("=========================================")

high_salary = loaded_df[loaded_df["salary"] > 50000]

print(high_salary)

print("\n=========================================")
print("Average Salary")
print("=========================================")

average_salary = loaded_df["salary"].mean()

print(average_salary)

print("\n=========================================")
print("Employee Count by Department")
print("=========================================")

department_count = loaded_df.groupby("department").size()

print(department_count)

# ==========================================
# Task 5: Save Filtered Data
# ==========================================

high_salary.to_parquet("high_salary_employees.parquet", index=False)

print("\nhigh_salary_employees.parquet created successfully.")

# ==========================================
# Bonus Task
# Read only Name and Salary columns
# ==========================================

print("\n=========================================")
print("Bonus Task")
print("Name and Salary Columns")
print("=========================================")

selected_columns = pd.read_parquet(
    "employees.parquet",
    columns=["name", "salary"]
)

print(selected_columns)

print("\n=========================================")
print("Assignment Completed Successfully")
print("=========================================")