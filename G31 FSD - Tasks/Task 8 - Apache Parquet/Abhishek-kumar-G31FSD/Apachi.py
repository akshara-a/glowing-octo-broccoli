import pandas as pd

data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}


# Task 1: Create the DataFrame

employees_df = pd.DataFrame(data)
print("=== Task 1: Original DataFrame ===")
print(employees_df)
print()


# Task 2: Save the DataFrame as a Parquet file (no index)

employees_df.to_parquet("employees.parquet", index=False)
print("=== Task 2: Saved employees.parquet ===")
print()


# Task 3: Read the Parquet file back into a new DataFrame

loaded_df = pd.read_parquet("employees.parquet")
print("=== Task 3: Data loaded from employees.parquet ===")
print(loaded_df)
print()


# Task 4: Perform basic analysis


# 1. Employees with salary > 50000
high_salary_df = loaded_df[loaded_df["salary"] > 50000]
print("=== Task 4.1: Employees with salary > 50000 ===")
print(high_salary_df)
print()

# 2. Average salary
average_salary = loaded_df["salary"].mean()
print("=== Task 4.2: Average salary ===")
print(average_salary)
print()

# 3. Number of employees per department
department_counts = loaded_df["department"].value_counts()
print("=== Task 4.3: Employee count by department ===")
print(department_counts)
print()


# Task 5: Save the filtered (high salary) data as Parquet

high_salary_df.to_parquet("high_salary_employees.parquet", index=False)
print("=== Task 5: Saved high_salary_employees.parquet ===")
print()


# Bonus Task: Read only 'name' and 'salary' columns

name_salary_df = pd.read_parquet("employees.parquet", columns=["name", "salary"])
print("=== Bonus: name & salary columns only ===")
print(name_salary_df)