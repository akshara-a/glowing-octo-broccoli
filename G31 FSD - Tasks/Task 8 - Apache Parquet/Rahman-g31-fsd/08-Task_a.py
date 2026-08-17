import pandas as pd

data = {

    "employee_id": [1,2,3,4,5,6],

     "name":["sharif","sam","saim","waq","rashid","Abhi"],

     "Department":["IT","AI","ML","DS","HR","PR"],

     "Salary": [1234,2345,3456,4567,5678,6789]   
}

employees_df = pd.DataFrame(data)
print(employees_df)