import pandas as pd

data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Akshara-mam", "Rahul", "Himanshu-Me", "Vikram", "Priya"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}

# Task 1: Create the DataFrame
employees_df = pd.DataFrame(data)

# Display all employee records
print("All Employee Records:")
print(employees_df)

# Task 2: Save the DataFrame as a Parquet file
employees_df.to_parquet("employees.parquet", index=False)

# Task 3: Read the Parquet file
loaded_df = pd.read_parquet("employees.parquet")

print("\nLoaded DataFrame:")
print(loaded_df)

# Task 4: Perform the requested analysis

# Employees with salary greater than 50000
high_salary = loaded_df[loaded_df["salary"] > 50000]

print("\nEmployees with Salary > 50000:")
print(high_salary)

# Average salary
average_salary = loaded_df["salary"].mean()
print("\nAverage Salary:", average_salary)

# Number of employees in each department
department_counts = loaded_df["department"].value_counts()

print("\nEmployee Count by Department:")
print(department_counts)

# Task 5: Save the filtered data
high_salary.to_parquet("high_salary_employees.parquet", index=False)

print("\nFiltered data saved as 'high_salary_employees.parquet'")
