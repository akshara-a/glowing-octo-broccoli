import pandas as pd


data = {
  "employee_id": [
    1, 2, 3, 4, 5,6, 7, 8, 9, 10,
    11, 12, 13, 14, 15,16, 17, 18, 19, 20 ],

  "name": [
    "Asha", "Rahul", "Neha", "Vikram", "Priya","Arjun", "Sneha", "Karthik", "Meena", "Rohit",
    "Divya", "Suresh", "Anjali", "Manoj", "Pooja","Nikhil", "Kavya", "Deepak", "Shreya", "Harish" ],

  "department": [
    "IT", "HR", "IT", "Finance", "HR","Marketing", "Sales", "IT", "Finance", "HR",
    "Marketing", "Sales", "IT", "Finance", "HR","Marketing", "Sales", "IT", "Finance", "HR"],

  "salary": [
    60000, 45000, 70000, 55000, 48000, 52000, 47000, 68000, 59000, 51000,
    46000, 75000, 82000, 54000, 49000, 63000, 58000, 72000, 61000, 53000 ]
}

# Dictionary converted to data
df = pd.DataFrame(data)

print("Employee Data")
print(df)



# DataFrame converted to Parquet

df.to_parquet(
    "employees.parquet",
    index=False,
    engine="pyarrow"
)



# Read the stored Parquet File


stored_df = pd.read_parquet(
    "employees.parquet",
    
)

print("\nStored Parquet file")
print(stored_df)




high_salary_employees_df = stored_df[stored_df["salary"] > 50000]

print("\nEmployees with Salary greater than 50000")
print(high_salary_employees_df)



average_salary = stored_df["salary"].mean()

print("\nAverage Salary of employees")
print(f"Average Salary: {average_salary}")



department_count = stored_df["department"].value_counts()

print("\nEmployee Count in each department")
print(department_count)



high_salary_employees_df.to_parquet(
    "high_salary_employees.parquet",
    index=False,
    engine="pyarrow"
)


high_salary_employee_details = pd.read_parquet(
    "high_salary_employees.parquet",
    columns=["name", "salary"]
)

print("\nHigh salary employee details from the parquet file")
print(high_salary_employee_details)
