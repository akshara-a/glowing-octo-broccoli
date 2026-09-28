
import pandas as pd

# Read the Parquet file
employees_df = pd.read_parquet(r"c:\users\DELL G15\Desktop\glowing-octo-broccoli\G31 FSD - Tasks\Task 8 - Apache Parquet\Rahman-g31-fsd\_employees.parquet",)

# Display all employee records
print("===== ALL EMPLOYEE RECORDS =====")
print(employees_df)

# Display employees with salary greater than 50000
high_salary = employees_df[employees_df["salary"] > 50000]

print("\n===== EMPLOYEES WITH SALARY > 50000 =====")
print(high_salary)

# Calculate average salary
average_salary = employees_df["salary"].mean()

print("\n===== AVERAGE SALARY =====")
print(average_salary)

# Count employees in each department
department_count = employees_df["department"].value_counts()

print("\n===== EMPLOYEES IN EACH DEPARTMENT =====")
print(department_count)