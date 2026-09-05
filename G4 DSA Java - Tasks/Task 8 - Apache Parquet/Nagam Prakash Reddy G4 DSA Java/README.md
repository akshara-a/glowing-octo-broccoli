# Python Parquet Assignment

## Overview

This project demonstrates how to create, save, read, and analyze a
Parquet file using Python, Pandas, and PyArrow.

The program works with employee data and performs basic salary and
department analysis.

---

## Technologies Used

- Python
- Pandas
- PyArrow
- Parquet

---

## Project Structure

```text
Nagam Prakash Reddy G4 DSA Java
│
├── parquet_assignment.py
├── employees.parquet
├── high_salary_employees.parquet
└── README.md
Installation

Install the required Python libraries using:

pip install pandas pyarrow
How to Run

Open the terminal inside the project folder.

Run the following command:

python parquet_assignment.py

The program will automatically execute all the required tasks.

Program Flow

The program follows this flow:

Start
  │
  ▼
Create Employee DataFrame
  │
  ▼
Save DataFrame as employees.parquet
  │
  ▼
Read employees.parquet
  │
  ▼
Perform Basic Analysis
  │
  ├── Find employees with salary > 50000
  │
  ├── Calculate average salary
  │
  └── Count employees by department
  │
  ▼
Save filtered employees
as high_salary_employees.parquet
  │
  ▼
Bonus:
Read only name and salary columns
  │
  ▼
End