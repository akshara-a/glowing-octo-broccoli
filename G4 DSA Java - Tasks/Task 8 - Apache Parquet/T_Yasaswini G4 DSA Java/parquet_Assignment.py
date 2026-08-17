import pandas as pd

# -------------------------------
# Task 1: Create the DataFrame
# -------------------------------

data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}

employees_df = pd.DataFrame(data)

print("=" * 50)
print("Original Employee Data")
print("=" * 50)
print(employees_df)

# -------------------------------
# Task 2: Save as Parquet
# -------------------------------

employees_df.to_parquet(
    "employees.parquet",
    engine="pyarrow",
    index=False
)

print("\nemployees.parquet created successfully.")

# -------------------------------
# Task 3: Read the Parquet File
# -------------------------------

loaded_df = pd.read_parquet(
    "employees.parquet",
    engine="pyarrow"
)

print("\n" + "=" * 50)
print("Data Read from employees.parquet")
print("=" * 50)
print(loaded_df)

# -------------------------------
# Task 4: Basic Analysis
# -------------------------------

print("\nEmployees with Salary > 50000")
high_salary = loaded_df[loaded_df["salary"] > 50000]
print(high_salary)

average_salary = loaded_df["salary"].mean()

print("\nAverage Salary:")
print(average_salary)

print("\nEmployee Count by Department:")
department_count = loaded_df["department"].value_counts()
print(department_count)

# -------------------------------
# Task 5: Save Filtered Data
# -------------------------------

high_salary.to_parquet(
    "high_salary_employees.parquet",
    engine="pyarrow",
    index=False
)

print("\nhigh_salary_employees.parquet created successfully.")

# -------------------------------
# Bonus Task
# -------------------------------

print("\nBonus Task")
print("Reading only Name and Salary columns")

selected_columns = pd.read_parquet(
    "employees.parquet",
    columns=["name", "salary"],
    engine="pyarrow"
)

print(selected_columns)