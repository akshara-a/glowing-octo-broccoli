import duckdb

# Connect to DuckDB database (creates it if it doesn't exist)
con = duckdb.connect("students.db")

# Create table
con.execute("""
CREATE TABLE IF NOT EXISTS students (
    id INTEGER,
    name VARCHAR,
    department VARCHAR,
    marks INTEGER
)
""")

# Insert sample data
con.execute("""
INSERT INTO students VALUES
(1, 'Prasad', 'CSE', 95),
(2, 'Rahul', 'ECE', 88),
(3, 'Sita', 'EEE', 91),
(4, 'Anjali', 'IT', 85)
""")

# Display all records
print("Student Records:")
result = con.execute("SELECT * FROM students").fetchall()

for row in result:
    print(row)

# Display students with marks >= 90
print("\nStudents with Marks >= 90:")
top_students = con.execute(
    "SELECT name, marks FROM students WHERE marks >= 90"
).fetchall()

for row in top_students:
    print(row)

con.close()