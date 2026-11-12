import pandas as pd

# Task 1: Create the DataFrame
data = {
    "employee_id": [1, 2, 3, 4, 5],
    "name": ["Sangam", "Nikhil", "Anand", "Abhinay", "Anubhav"],
    "department": ["IT", "HR", "IT", "Finance", "HR"],
    "salary": [60000, 45000, 70000, 55000, 48000]
}

employees_df = pd.DataFrame(data)
print("All Employees:\n", employees_df)

# Task 2: Save the DataFrame as a Parquet file
employees_df.to_parquet("employees.parquet", index=False)

# Task 3: Read the Parquet file
loaded_df = pd.read_parquet("employees.parquet")
print("\nLoaded Employees:\n", loaded_df)

# Task 4: Perform the requested analysis
high_salary = loaded_df[loaded_df["salary"] > 50000]
print("\nEmployees with salary > 50000:\n", high_salary)

avg_salary = loaded_df["salary"].mean()
print("\nAverage Salary:", avg_salary)

dept_counts = loaded_df["department"].value_counts()
print("\nEmployee count by department:\n", dept_counts)

# Task 5: Save the filtered data
high_salary.to_parquet("high_salary_employees.parquet", index=False)

# Bonus Task: Read only name and salary columns
filtered_columns = pd.read_parquet("employees.parquet", columns=["name", "salary"])
print("\nOnly Name and Salary:\n", filtered_columns)
