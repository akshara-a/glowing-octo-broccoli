import pandas as pd

data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}

employees_df = pd.DataFrame(data)

employees_df.to_parquet("employees.parquet", index=False)

loaded_df = pd.read_parquet("employees.parquet")

print("All Employee Records")
print(loaded_df)

print("\nEmployees with Salary Greater than 50000")
high_salary = loaded_df[loaded_df["salary"] > 50000]
print(high_salary)

print("\nAverage Salary")
print(loaded_df["salary"].mean())

print("\nEmployee Count by Department")
print(loaded_df["department"].value_counts())

high_salary.to_parquet("high_salary_employees.parquet", index=False)

print("\nName and Salary Columns")
selected_data = pd.read_parquet(
    "employees.parquet",
    columns=["name", "salary"]
)
print(selected_data)