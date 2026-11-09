import pandas as pd

data = {
    "employee_id": [1,2,3,4,5,6,7,8],
    "name": ["Sharif","Sam","Saim","Waq","Rashid","Eayuni","Abhi","Bind"],
    "Department": ["AI","ML","DS","IT","HR","DS","IT","ML"],
    "Salary": [12340,23450,34560,75670,56780,67890,78900,12300],
    "City": ["Goa","Delhi","Mumbai","Goa","Agra","Pune","Delhi","Sana"]
}

df = pd.DataFrame(data)

df.to_parquet("employees.parquet", index=False)

print("Parquet created successfully!")