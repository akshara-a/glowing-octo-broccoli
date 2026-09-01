import pyarrow as pa

# Sample data
data = {
    "ID": [1, 2, 3, 4],
    "Name": ["Prasad", "Rahul", "Sita", "Anjali"],
    "Department": ["CSE", "ECE", "EEE", "IT"],
    "Marks": [95, 88, 91, 85]
}

# Create an Arrow Table
table = pa.table(data)

print("Apache Arrow Table:")
print(table)

print("\nSchema:")
print(table.schema)

print("\nData as Python Dictionary:")
print(table.to_pydict())