import pandas as pd

# Create sample data
students = {
    "RollNo": [1, 2, 3, 4],
    "Name": ["Prasad", "Rahul", "Sita", "Anjali"],
    "Department": ["CSE", "ECE", "EEE", "IT"],
    "Marks": [95, 88, 91, 85]
}

# Create DataFrame
df = pd.DataFrame(students)

# Save to Parquet
df.to_parquet("students.parquet", engine="pyarrow", index=False)
print("Parquet file created successfully!")

# Read the Parquet file
data = pd.read_parquet("students.parquet", engine="pyarrow")

print("\nContents of Parquet File:")
print(data)