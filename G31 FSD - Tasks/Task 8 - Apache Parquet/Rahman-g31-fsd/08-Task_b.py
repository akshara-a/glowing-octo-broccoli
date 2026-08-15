
import pandas as pd

data = {
    "Employee_id": [1,2,3,4,5,6],
    "Name": ["Sharif", "sam", "saim", "waq", "Rashid", "Abhi"],
    "department": ["IT","AI","HR","ML","DS","IT"],
    "salary": [50000,45000,70000,60000,55000,70000]
   
}

employee_df = pd.DataFrame(data)
employee_df.to_parquet(
        r"c:\users\DELL G15\Desktop\glowing-octo-broccoli\G31 FSD - Tasks\Task 8 - Apache Parquet\Rahman-g31-fsd\_employees.parquet", 
        index=False
)

print("Parquet file created successfully!")