import pandas as pd

data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}

employees_df = pd.DataFrame(data)

# Saving full dataset without index
employees_df.to_parquet("employees.parquet", index=False)

loaded_df = pd.read_parquet("employees.parquet")

print("--- Task 3: All Employee Records ---")
print(loaded_df)
print("\n" + "="*40 + "\n")

print("--- Task 4: Basic Analysis ---")

# 1. Employees with salary > 50000
high_salary_df = loaded_df[loaded_df["salary"] > 50000]
print("1. Employees with Salary > 50,000:")
print(high_salary_df)
print()

# 2. Average salary
avg_salary = loaded_df["salary"].mean()
print(f"2. Average Salary: ${avg_salary:,.2f}\n")

# 3. Employee counts by department
dept_counts = loaded_df["department"].value_counts().reset_index()
dept_counts.columns = ["department", "employee_count"]
print("3. Employee Count by Department:")
print(dept_counts)
print("\n" + "="*40 + "\n")

# Saving high salary filtered DataFrame as a second Parquet file
high_salary_df.to_parquet("high_salary_employees.parquet", index=False)

print("--- Bonus Task: Selected Columns Read ---")

# Reading only 'name' and 'salary' columns directly from Parquet
selected_cols_df = pd.read_parquet("employees.parquet", columns=["name", "salary"])
print(selected_cols_df)

# Optional: Save selected columns as a third parquet table for completeness
selected_cols_df.to_parquet("name_and_salary.parquet", index=False)
