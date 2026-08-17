import pandas as pd

data = {

    "employee_id": [1,2,3,4,5,6],

     "name":["sharif","sam","saim","waq","rashid","Abhi"],

     "Department":["IT","AI","ML","DS","HR","PR"],

     "Salary": [12340,23450,34560,45670,56780,67890]   
}

employees_df = pd.DataFrame(data)
print(employees_df)

print("______________________")
print(" ")

high_salary = employees_df[employees_df["Salary"] > 50000]

high_salary.to_parquet(
     r"c:\users\DELL G15\Desktop\glowing-octo-broccoli\G31 FSD - Tasks\Task 8 - Apache Parquet\Rahman-g31-fsd\_high_salary_employees.parquet",
    index=False
)
print("Save employees with a salary greater than 50000 ")
print(" ")
print("______________________")

print(high_salary)

