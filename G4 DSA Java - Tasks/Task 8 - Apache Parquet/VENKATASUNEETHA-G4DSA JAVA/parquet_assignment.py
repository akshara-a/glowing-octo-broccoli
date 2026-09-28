import pandas as pd

# ---------------------------------------
# Task 1: Create the DataFrame
# ---------------------------------------

data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}

employees_df = pd.DataFrame(data)

print("Original Employee Data:")
print(employees_df)


# ---------------------------------------
# Task 2: Save DataFrame as Parquet
# ---------------------------------------

employees_df.to_parquet(
    "employees.parquet",
    index=False
)

print("\nData saved successfully!")


# ---------------------------------------
# Task 3: Read the Parquet File
# ---------------------------------------

loaded_df = pd.read_parquet("employees.parquet")

print("\nEmployee Data Read From Parquet:")
print(loaded_df)


# ---------------------------------------
# Task 4.1: Employees earning more than 50000
# ---------------------------------------

high_salary_df = loaded_df[
    loaded_df["salary"] > 50000
]

print("\nEmployees with Salary Greater Than 50000:")
print(high_salary_df)


# ---------------------------------------
# Task 4.2: Calculate Average Salary
# ---------------------------------------

average_salary = loaded_df["salary"].mean()

print("\nAverage Employee Salary:")
print(average_salary)


# ---------------------------------------
# Task 4.3: Count Employees by Department
# ---------------------------------------

department_counts = loaded_df["department"].value_counts()

print("\nNumber of Employees in Each Department:")
print(department_counts)


# ---------------------------------------
# Task 5: Save Filtered Data
# ---------------------------------------

high_salary_df.to_parquet(
    "high_salary_employees.parquet",
    index=False
)

print("\nHigh salary employees saved successfully!")


# ---------------------------------------
# Bonus Task
# Read only name and salary columns
# ---------------------------------------

bonus_df = pd.read_parquet(
    "employees.parquet",
    columns=["name", "salary"]
)

print("\nBonus - Name and Salary Only:")
print(bonus_df)