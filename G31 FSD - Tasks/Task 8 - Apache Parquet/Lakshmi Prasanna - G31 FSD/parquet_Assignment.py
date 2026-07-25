import pandas as pd

data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}

employees_df = pd.DataFrame(data)
print("All Employee Records:")
print(employees_df)

employees_df.to_parquet("employees.parquet", index=False)
print("\nSaved employees.parquet")

loaded_df = pd.read_parquet("employees.parquet")
print("\nData read from employees.parquet:")
print(loaded_df)

print("\nEmployees with salary greater than 50000:")
print(loaded_df[loaded_df["salary"] > 50000])

print("\nAverage Salary:", loaded_df["salary"].mean())

print("\nNumber of employees in each department:")
print(loaded_df["department"].value_counts())

high_salary_df = loaded_df[loaded_df["salary"] > 50000]
high_salary_df.to_parquet("high_salary_employees.parquet", index=False)
print("\nSaved high_salary_employees.parquet")

print("\nBonus - Name and Salary columns only:")
bonus_df = pd.read_parquet("employees.parquet", columns=["name", "salary"])
print(bonus_df)
