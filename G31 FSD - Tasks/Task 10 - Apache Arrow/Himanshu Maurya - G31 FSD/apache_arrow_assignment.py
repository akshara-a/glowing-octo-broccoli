import pyarrow as pa
import pyarrow.compute as pc
import pyarrow.parquet as pq
import pyarrow.ipc as ipc
import pandas as pd

data = {
    "employee_id": [1, 2, 3, 4, 5, 6],
    "name": ["Asha", "Rahul", "Neha", "Vikram", "Priya", "Arjun"],
    "department": ["IT", "HR", "IT", "Finance", "HR", "Finance"],
    "salary": [60000, 45000, 70000, 55000, 48000, 65000],
    "city": ["Delhi", "Mumbai", "Bengaluru", "Delhi", "Mumbai", "Chennai"]
}

employee_table = pa.table(data)
print(employee_table)
print(employee_table.schema)
print(employee_table.num_rows)
print(employee_table.num_columns)
print(employee_table.column_names)
print(employee_table.column("name"))
print(employee_table.slice(0, 3))

selected_table = employee_table.select(["name", "department", "salary"])
print(selected_table)

high_salary_table = employee_table.filter(pc.greater(employee_table["salary"], 50000))
print(high_salary_table)

it_employees = employee_table.filter(pc.equal(employee_table["department"], "IT"))
print(it_employees)

salary = employee_table["salary"]
print(pc.mean(salary).as_py())
print(pc.max(salary).as_py())
print(pc.min(salary).as_py())
print(pc.sum(salary).as_py())

bonus = pc.multiply(employee_table["salary"], 0.10)
employee_table = employee_table.append_column("bonus", bonus)
print(employee_table)

employee_df = employee_table.to_pandas()
print(employee_df)

new_arrow_table = pa.Table.from_pandas(employee_df, preserve_index=False)
print(new_arrow_table)

pq.write_table(employee_table, "employees.parquet")
print(pq.read_table("employees.parquet"))

with ipc.new_file("employees.arrow", employee_table.schema) as writer:
    writer.write_table(employee_table)

with ipc.open_file("employees.arrow") as reader:
    print(reader.read_all())

print(employee_table.filter(pc.equal(employee_table["city"], "Delhi")))

between = pc.and_(pc.greater_equal(employee_table["salary"], 50000),
                  pc.less_equal(employee_table["salary"], 65000))
print(employee_table.filter(between))

annual = pc.multiply(employee_table["salary"], 12)
employee_table = employee_table.append_column("annual_salary", annual)
print(employee_table)

pq.write_table(employee_table.filter(pc.equal(employee_table["department"], "IT")),
               "it_employees.parquet")

print(pq.read_table("employees.parquet", columns=["name", "salary"]))
print(employee_table.sort_by([("salary", "descending")]))
