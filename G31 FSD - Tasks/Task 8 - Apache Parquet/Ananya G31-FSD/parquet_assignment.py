import pandas as pd


# Task 1: Create the DataFrame

data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}

employees_df = pd.DataFrame(data)

print("===== All Employee Records =====")
print(employees_df)


# Task 2: Save DataFrame as Parquet

employees_df.to_parquet("employees.parquet", index=False)
print("\nemployees.parquet created successfully!")


# Task 3: Read the Parquet File

loaded_df = pd.read_parquet("employees.parquet")

print("\n===== Data Read From employees.parquet =====")
print(loaded_df)


# Task 4: Perform Basic Analysis


# Employees with salary greater than 50000
high_salary = loaded_df[loaded_df["salary"] > 50000]

print("\n===== Employees with Salary Greater Than 50000 =====")
print(high_salary)

# Average salary
average_salary = loaded_df["salary"].mean()

print("\n===== Average Salary =====")
print(average_salary)

# Number of employees in each department
department_count = loaded_df["department"].value_counts()

print("\n===== Employees in Each Department =====")
print(department_count)


# Task 5: Save Filtered Data

high_salary.to_parquet("high_salary_employees.parquet", index=False)
print("\nhigh_salary_employees.parquet created successfully!")


# Bonus Task

print("\n===== Name and Salary Only =====")

name_salary = pd.read_parquet(
    "employees.parquet",
    columns=["name", "salary"]
)

print(name_salary)