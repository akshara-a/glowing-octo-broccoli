import pandas as pd

data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Asha", "Rahul", "Sailu", "Chinni", "Sunny"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}

employees_df = pd.DataFrame(data)

print("Original Employee Data:")
print(employees_df)

employees_df.to_parquet("employees.parquet", index=False)
print("\nemployees.parquet has been created successfully.")

loaded_df = pd.read_parquet("employees.parquet")

print("\nData Read from employees.parquet:")
print(loaded_df)

high_salary = loaded_df[loaded_df["salary"] > 50000]

print("\nEmployees with Salary > 50000:")
print(high_salary)

average_salary = loaded_df["salary"].mean()
print("\nAverage Salary:", average_salary)

department_count = loaded_df["department"].value_counts()

print("\nEmployee Count by Department:")
print(department_count)

high_salary.to_parquet("high_salary_employees.parquet", index=False)

print("\nhigh_salary_employees.parquet has been created successfully.")

selected_columns = pd.read_parquet(
    "employees.parquet",
    columns=["name", "salary"]
)

print("\nName and Salary Columns:")
print(selected_columns)