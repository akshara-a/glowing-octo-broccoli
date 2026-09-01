import pandas as pd

# Task 1: Create the DataFrame

data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}

employees_df = pd.DataFrame(data)

print("Original Employee Data:")
print(employees_df)


# Task 2: Save the DataFrame as a Parquet file

employees_df.to_parquet(
    "employees.parquet",
    index=False
)

print("\nEmployees data saved to employees.parquet")


# Task 3: Read the Parquet file

loaded_df = pd.read_parquet("employees.parquet")

print("\nData read from Parquet file:")
print(loaded_df)


# Task 4.1: Display employees with salary greater than 50000

high_salary_df = loaded_df[loaded_df["salary"] > 50000]

print("\nEmployees with salary greater than 50000:")
print(high_salary_df)


# Task 4.2: Calculate average salary

average_salary = loaded_df["salary"].mean()

print("\nAverage Salary:")
print(average_salary)


# Task 4.3: Display number of employees in each department

department_count = loaded_df["department"].value_counts()

print("\nNumber of employees in each department:")
print(department_count)


# Task 5: Save filtered data

high_salary_df.to_parquet(
    "high_salary_employees.parquet",
    index=False
)

print("\nHigh salary employees saved to high_salary_employees.parquet")


# Bonus Task: Read only name and salary columns

bonus_df = pd.read_parquet(
    "employees.parquet",
    columns=["name", "salary"]
)

print("\nBonus - Name and Salary only:")
print(bonus_df)