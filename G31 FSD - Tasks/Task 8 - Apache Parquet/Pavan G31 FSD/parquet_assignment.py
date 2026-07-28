import pandas as pd

# Task 1: Create DataFrame
data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Pavan", "Sowmya", "Swetha", "Anjali", "Hemu"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}

employees_df = pd.DataFrame(data)

print("Employee Data:")
print(employees_df)

# Task 2: Save as Parquet
employees_df.to_parquet("employees.parquet", index=False)

print("\nemployees.parquet file created successfully.")

# Task 3: Read the Parquet file
loaded_df = pd.read_parquet("employees.parquet")

print("\nData Read From Parquet:")
print(loaded_df)

# Task 4.1: Employees with salary > 50000
high_salary = loaded_df[loaded_df["salary"] > 50000]

print("\nEmployees With Salary Greater Than 50000:")
print(high_salary)

# Task 4.2: Average salary
average_salary = loaded_df["salary"].mean()

print("\nAverage Salary:")
print(average_salary)

# Task 4.3: Number of employees in each department
department_count = loaded_df["department"].value_counts()

print("\nEmployee Count By Department:")
print(department_count)

# Task 5: Save filtered data
high_salary.to_parquet("high_salary_employees.parquet", index=False)

print("\nhigh_salary_employees.parquet file created successfully.")

# Bonus Task
selected_columns = pd.read_parquet(
    "employees.parquet",
    columns=["name", "salary"]
)

print("\nOnly Name and Salary:")
print(selected_columns)