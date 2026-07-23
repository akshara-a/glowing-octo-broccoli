import pandas as pd
import duckdb

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

    "city": [
      "Chennai","Delhi","Mumbai","Delhi","Bangalore","Chennai","Delhi","Mumbai","Delhi","Bangalore",
      "Chennai","Delhi","Mumbai","Delhi","Chennai","Bangalore","Delhi","Mumbai","Delhi","Chennai"
    ],

  "salary": [
    60000, 45000, 70000, 55000, 48000, 52000, 47000, 68000, 59000, 51000,
    46000, 75000, 82000, 54000, 49000, 63000, 58000, 72000, 61000, 53000 ]
}



df = pd.DataFrame(data)

# Create parquet file
df.to_parquet(
    "employees.parquet",
    index=False
)



# read from parquet file using duckdb
result = duckdb.sql(""" SELECT * FROM read_parquet('employees.parquet')""")
result_df = result.df()

print(result_df)


# Employees with salary greater than 50000

print("\nEmployees with salary greater than 50000")

high_salary_employees = duckdb.sql(""" SELECT *FROM read_parquet('employees.parquet') WHERE salary > 50000""")
high_salary_employees_df = high_salary_employees.df()

print(high_salary_employees_df)


# Employees in IT Department
print("\nEmployees in IT Department")

it_department = duckdb.sql("""SELECT * FROM read_parquet('employees.parquet') WHERE department='IT' """)
if_dept_df = it_department.df()
print(if_dept_df)


# Employees in Delhi 

print("\nEmployees in Delhi ")
delhi_employees = duckdb.sql(""" SELECT * FROM read_parquet('employees.parquet') WHERE city='Delhi' """)
delhi_employees_df = delhi_employees.df()

print(delhi_employees_df)

print("\nIT Department employees with Salary greater than 65000")

high_salary_employees = duckdb.sql(""" SELECT * FROM read_parquet('employees.parquet') WHERE department='IT' AND salary > 65000 """)
high_salary_employees_df = high_salary_employees.df()

print(high_salary_employees_df)




print("\nSorting employees by salary")

sorted_data = duckdb.sql(""" SELECT name, department, salary FROM read_parquet('employees.parquet') ORDER BY salary DESC """)
sorted_data_df = sorted_data.df()

print(sorted_data_df)



print("\nCount of employees")

count_employees = duckdb.sql(""" SELECT COUNT(*) AS employee_count, FROM read_parquet('employees.parquet') """)
count_employees_df = count_employees.df()
print(count_employees_df)


print("\nAverage salary of employees")

avg_salary_employee = duckdb.sql(""" SELECT AVG(salary) AS average_salary FROM read_parquet('employees.parquet') """)
avg_salary_employee_df = avg_salary_employee.df()
print(avg_salary_employee_df)


print("\nDepartment Details")

department_details = duckdb.sql(""" SELECT department, COUNT(*) AS employee_count, AVG(salary) AS average_salary FROM read_parquet('employees.parquet') GROUP BY department """)
department_details_df = department_details.df()
print(department_details_df)


# Create DuckDB database to store parquet file

print("\nCreate company.duckdb")

connection = duckdb.connect("company.duckdb")

connection.execute(""" CREATE TABLE employees AS SELECT * FROM read_parquet('employees.parquet') """)

employees_table = connection.execute(""" SELECT * FROM employees """)
employees_table_df = employees_table.df()

print("Database in DuckDB employees")
print(employees_table_df)

connection.close()


# Task 8: Copy one parquet file to another


print("\nCopy High Salary Employees to another parquet file")

duckdb.sql("""  COPY( SELECT * FROM read_parquet('employees.parquet') WHERE salary > 50000)
                TO 'high_salary_employees.parquet'(FORMAT PARQUET) """)

# Verify Exported High Salary Employees File

print("\nVerify Exported High Salary Employees File")

high_salary_employees = duckdb.sql(""" SELECT * FROM read_parquet('high_salary_employees.parquet') """)
high_salary_employees_df = high_salary_employees.df()

print(high_salary_employees_df)



print("\nSecond Highest Salary")

second_highest_salary_employee = duckdb.sql(""" SELECT * FROM read_parquet('employees.parquet')ORDER BY salary DESC LIMIT 1 OFFSET 1""")
second_highest_salary_employee_df = second_highest_salary_employee.df()

print(second_highest_salary_employee_df)


print("\nTop Three Highest Paid Employees")

top_three_employees = duckdb.sql(""" SELECT * FROM read_parquet('employees.parquet') ORDER BY salary DESC LIMIT 3 """)

top_three_employees_df = top_three_employees.df()
print(top_three_employees_df)


print("\nAverage Salary Per City")

city_average_salary = duckdb.sql(""" SELECT city, AVG(salary) AS average_salary FROM read_parquet('employees.parquet') GROUP BY city ORDER BY average_salary DESC """)
city_average_salary_df = city_average_salary.df()
print(city_average_salary_df)



print("\nDepartments with Average Salary greater than 55000")

high_avg_department = duckdb.sql(""" SELECT department, AVG(salary) AS average_salary FROM read_parquet('employees.parquet') GROUP BY department HAVING AVG(salary) > 55000 """)
high_avg_department_df = high_avg_department.df()

print(high_avg_department_df)


