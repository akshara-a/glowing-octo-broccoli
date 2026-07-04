
# SQL Learning Guide (Beginner to Intermediate)

## 1. What is SQL?
SQL (Structured Query Language) is used to communicate with relational databases.
It allows you to **store, retrieve, manipulate, and analyze data**.

Common databases:
- MySQL
- PostgreSQL
- SQL Server
- Oracle
- SQLite

---

## 2. Basic Database Concepts
- **Database** → Collection of tables
- **Table** → Rows and columns
- **Row (Record)** → Single entry
- **Column (Field)** → Attribute

---

## 3. Data Types
Common SQL data types:
- `INT` – Integer numbers
- `FLOAT`, `DOUBLE` – Decimal numbers
- `VARCHAR(n)` – Variable-length string
- `CHAR(n)` – Fixed-length string
- `DATE`, `TIME`, `DATETIME`
- `BOOLEAN`

---

## 4. Creating a Database and Table

```sql
CREATE DATABASE school;

USE school;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    marks FLOAT
);
```

---

## 5. Inserting Data

```sql
INSERT INTO students (id, name, age, marks)
VALUES (1, 'Aksh', 21, 89.5);
```

Insert multiple rows:
```sql
INSERT INTO students VALUES
(2, 'Ravi', 22, 78.0),
(3, 'Meena', 20, 91.2);
```

---

## 6. Reading Data (SELECT)

```sql
SELECT * FROM students;
SELECT name, marks FROM students;
```

Using conditions:
```sql
SELECT * FROM students WHERE marks > 80;
```

---

## 7. Operators

### Relational Operators
- `=` Equal
- `!=` Not equal
- `>` Greater than
- `<` Less than
- `>=`, `<=`

```sql
SELECT * FROM students WHERE age >= 21;
```

### Logical Operators
- `AND`
- `OR`
- `NOT`

```sql
SELECT * FROM students WHERE age > 20 AND marks > 80;
```

---

## 8. Sorting & Limiting

```sql
SELECT * FROM students ORDER BY marks DESC;
SELECT * FROM students LIMIT 2;
```

---

## 9. Aggregate Functions
- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`

```sql
SELECT AVG(marks) FROM students;
SELECT COUNT(*) FROM students;
```

---

## 10. GROUP BY & HAVING

```sql
SELECT age, AVG(marks)
FROM students
GROUP BY age;
```

Using HAVING:
```sql
SELECT age, AVG(marks)
FROM students
GROUP BY age
HAVING AVG(marks) > 80;
```

---

## 11. Updating Data

```sql
UPDATE students
SET marks = 95
WHERE id = 1;
```

---

## 12. Deleting Data

```sql
DELETE FROM students WHERE id = 3;
```

Delete all rows:
```sql
DELETE FROM students;
```

---

## 13. Constraints
- `PRIMARY KEY`
- `FOREIGN KEY`
- `UNIQUE`
- `NOT NULL`
- `CHECK`
- `DEFAULT`

Example:
```sql
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL
);
```

---

## 14. Joins

### INNER JOIN
```sql
SELECT students.name, courses.course_name
FROM students
INNER JOIN courses
ON students.id = courses.course_id;
```

### LEFT JOIN
```sql
SELECT *
FROM students
LEFT JOIN courses
ON students.id = courses.course_id;
```

---

## 15. Subqueries

```sql
SELECT * FROM students
WHERE marks > (SELECT AVG(marks) FROM students);
```

---

## 16. Indexes
Indexes improve search performance.

```sql
CREATE INDEX idx_name ON students(name);
```

---

## 17. Views

```sql
CREATE VIEW high_scorers AS
SELECT name, marks FROM students WHERE marks > 85;
```

---

## 18. Transactions

```sql
BEGIN;
UPDATE students SET marks = 90 WHERE id = 2;
COMMIT;
```

Rollback:
```sql
ROLLBACK;
```

---

## 19. Best Practices
- Avoid `SELECT *` in production
- Use proper indexing
- Normalize data
- Backup databases regularly

---

## 20. Practice Ideas
- Create a library database
- Write queries using joins
- Practice subqueries
- Optimize queries using indexes

---

## Next Steps
- Practice on real databases
- Learn advanced joins & window functions
- Explore SQL performance tuning

Happy Querying! 
