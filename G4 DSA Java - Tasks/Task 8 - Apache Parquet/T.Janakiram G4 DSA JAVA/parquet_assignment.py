import pandas as pd

print("--- Task 1: Creating DataFrame ---")
data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000],
}
employees_df = pd.DataFrame(data)
print(employees_df, "\n")

print("--- Task 2: Saving DataFrame to employees.parquet ---")
employees_df.to_parquet("employees.parquet", index=False)
print("employees.parquet saved successfully.\n")

print("--- Task 3: Reading employees.parquet ---")
read_df = pd.read_parquet("employees.parquet")
print(read_df, "\n")

print("--- Task 4.1: Employees earning > 50000 ---")
high_salary_df = read_df[read_df["salary"] > 50000]
print(high_salary_df, "\n")

print("--- Task 4.2: Average Salary ---")
average_salary = read_df["salary"].mean()
print(f"Average Salary: {average_salary:.2f}\n")

print("--- Task 4.3: Employee Count by Department ---")
dept_counts = read_df["department"].value_counts()
print(dept_counts, "\n")

print("--- Task 5: Saving Filtered Data to high_salary_employees.parquet ---")
high_salary_df.to_parquet("high_salary_employees.parquet", index=False)
print("high_salary_employees.parquet saved successfully.\n")

print("--- Bonus Task: Reading only 'name' and 'salary' columns ---")
subset_df = pd.read_parquet("employees.parquet", columns=["name", "salary"])
print(subset_df, "\n")
