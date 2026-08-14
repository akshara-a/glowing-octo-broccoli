import pandas as pd
#-----Task 1-------
 
data={ "employee_id": [1, 2, 3, 4, 5],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}
employee_df = pd.DataFrame(data)
print("========All Employees Records========")
print(employee_df)  

#-----Task 2-------
employee_df.to_parquet("employee.parquet",index=False)
print("\n ---------------loaded parquet file--------")
#-----Task 3-------loaded parquet file-----
loaded_df = pd.read_parquet("employee.parquet")
print(loaded_df)
#-----Task4------

high_salary = loaded_df[loaded_df["salary"] > 50000]

print(high_salary)

average_salary = loaded_df["salary"].mean()

print("\nAverage Salary:")
print(average_salary)

department_count = loaded_df["department"].value_counts()

print("\nEmployees in Each Department:")
print(department_count)

#-----Task 5-------

high_salary.to_parquet(
    "high_salary_employee.parquet",
    index=False
)

print("\nhigh_salary_employees.parquet created successfully.")

# Bonus Task------------------

print("\n========== Name and Salary Only ==========\n")

bonus_df = pd.read_parquet(
    "employee.parquet",
    columns=["name", "salary"]
)

print(bonus_df)