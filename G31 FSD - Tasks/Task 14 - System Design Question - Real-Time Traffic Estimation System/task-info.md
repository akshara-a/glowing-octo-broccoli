# SQL Database Assignment: Advanced Querying and Database Programming

## Assignment Title

**Design and Query an E-Commerce Database Using Advanced SQL**

## Objective

The objective of this assignment is to develop practical knowledge of SQL by designing and working with a relational database that represents an **e-commerce management system**.

This assignment covers:

* Basic and advanced SQL queries
* Filtering, sorting, and aggregation
* Joins
* Subqueries
* Correlated subqueries
* Indexes
* Stored procedures
* User-defined functions
* Views
* Common Table Expressions (CTEs)
* Recursive CTEs
* Materialized views
* Transactions
* Database optimization

For consistency, **PostgreSQL** is recommended because it supports procedures, functions, CTEs, recursive CTEs, indexes, views, and materialized views.

---

# Scenario

You have been hired as a database developer for an online shopping company called **ShopSphere**.

ShopSphere sells products belonging to different categories. Customers can place orders containing multiple products. Each order can have a payment and may also receive customer reviews.

Your task is to create the database, populate it with sample data, and write SQL statements to answer different business questions.

---

# Part 1: Database Design

Create a database named:

```sql
shopsphere_db
```

Create the following tables.

---

## 1. Customers Table

Create a table named `customers`.

Suggested columns:

```text
customer_id
first_name
last_name
email
phone
city
country
registration_date
status
```

Requirements:

* `customer_id` should be the primary key.
* `email` should be unique.
* `status` should contain values such as:

  * Active
  * Inactive
  * Blocked

---

## 2. Categories Table

Create a table named `categories`.

Columns:

```text
category_id
category_name
description
parent_category_id
```

Requirements:

* `category_id` should be the primary key.
* `category_name` should be unique.
* `parent_category_id` should reference `category_id` from the same table.

The `parent_category_id` will later be used for recursive CTE exercises.

Example category hierarchy:

```text
Electronics
    Computers
        Laptops
        Desktops
    Mobile Devices
        Smartphones
        Tablets
```

---

## 3. Products Table

Create a table named `products`.

Columns:

```text
product_id
product_name
category_id
price
stock_quantity
supplier_name
created_at
is_active
```

Requirements:

* `product_id` should be the primary key.
* `category_id` should be a foreign key.
* `price` must be greater than zero.
* `stock_quantity` cannot be negative.

---

## 4. Orders Table

Create a table named `orders`.

Columns:

```text
order_id
customer_id
order_date
order_status
shipping_city
shipping_country
total_amount
```

Possible values for `order_status`:

```text
Pending
Processing
Shipped
Delivered
Cancelled
```

Requirements:

* `order_id` should be the primary key.
* `customer_id` should reference the `customers` table.

---

## 5. Order Items Table

Create a table named `order_items`.

Columns:

```text
order_item_id
order_id
product_id
quantity
unit_price
discount
```

Requirements:

* `order_item_id` should be the primary key.
* `order_id` should reference `orders`.
* `product_id` should reference `products`.
* `quantity` must be greater than zero.
* `discount` should default to `0`.

---

## 6. Payments Table

Create a table named `payments`.

Columns:

```text
payment_id
order_id
payment_date
payment_method
payment_status
amount
transaction_reference
```

Possible payment methods:

```text
Credit Card
Debit Card
UPI
PayPal
Cash on Delivery
```

Possible payment statuses:

```text
Pending
Completed
Failed
Refunded
```

---

## 7. Reviews Table

Create a table named `reviews`.

Columns:

```text
review_id
customer_id
product_id
rating
review_text
review_date
```

Requirements:

* Rating must be between `1` and `5`.
* A customer should be able to review multiple products.

---

# Part 2: Sample Data

Insert sufficient test data into every table.

Minimum recommended records:

| Table       | Minimum Records |
| ----------- | --------------: |
| Customers   |              20 |
| Categories  |              10 |
| Products    |              30 |
| Orders      |              40 |
| Order Items |              80 |
| Payments    |              30 |
| Reviews     |              25 |

Your sample data should include:

* Customers from different cities and countries
* Active and inactive customers
* Products belonging to different categories
* Products with both high and low stock
* Products that have never been ordered
* Customers who have never placed an order
* Orders with different statuses
* Some cancelled orders
* Successful and failed payments
* Products with no reviews
* Different product ratings

---

# Part 3: Basic SQL Queries

Write SQL queries for the following tasks.

## Query 1

Display all customers.

## Query 2

Display:

```text
first_name
last_name
email
city
```

for all active customers.

## Query 3

Find all products that cost more than `1000`.

## Query 4

Display products whose price is between `500` and `2000`.

## Query 5

Find all customers living in any three cities of your choice using `IN`.

## Query 6

Find customers whose first name starts with `A`.

## Query 7

Find products whose name contains the word `Phone`.

## Query 8

Display all orders sorted from newest to oldest.

## Query 9

Display the five most expensive products.

## Query 10

Display products with stock quantity below `10`.

---

# Part 4: Aggregate Functions

Use:

```sql
COUNT()
SUM()
AVG()
MIN()
MAX()
```

to solve the following.

## Query 11

Find the total number of customers.

## Query 12

Find the total number of products.

## Query 13

Find the average product price.

## Query 14

Find the cheapest product.

## Query 15

Find the most expensive product.

## Query 16

Calculate the total value of all orders.

## Query 17

Calculate the average order amount.

## Query 18

Find the number of orders for each order status.

Expected output example:

```text
order_status | total_orders
-------------+-------------
Delivered    | 15
Pending      | 7
Cancelled    | 5
```

---

# Part 5: GROUP BY and HAVING

## Query 19

Display the number of products in each category.

## Query 20

Find the average product price for each category.

## Query 21

Display categories whose average product price is greater than `1000`.

Use `HAVING`.

## Query 22

Calculate how much each customer has spent.

## Query 23

Display customers whose total spending is greater than `5000`.

## Query 24

Find products that have been ordered more than five times.

---

# Part 6: SQL Joins

Demonstrate the following types of joins:

* INNER JOIN
* LEFT JOIN
* RIGHT JOIN
* FULL OUTER JOIN
* SELF JOIN

---

## Query 25 — INNER JOIN

Display:

```text
order_id
customer_name
order_date
order_status
total_amount
```

for every order.

---

## Query 26 — Multiple Table Join

Display:

```text
order_id
customer_name
product_name
quantity
unit_price
```

by joining:

```text
customers
orders
order_items
products
```

---

## Query 27 — Product Category Join

Display every product with its category name.

Expected columns:

```text
product_id
product_name
category_name
price
```

---

## Query 28 — LEFT JOIN

Display all customers and their orders.

Customers who have never placed an order must also appear.

---

## Query 29

Find customers who have never placed an order.

Hint:

Use:

```sql
LEFT JOIN
```

and check for `NULL`.

---

## Query 30

Find products that have never been ordered.

---

## Query 31 — RIGHT JOIN

Create a query demonstrating a `RIGHT JOIN` between two suitable tables.

Explain why the result differs from an INNER JOIN.

---

## Query 32 — FULL OUTER JOIN

Demonstrate a `FULL OUTER JOIN`.

Explain which unmatched rows appear in the output.

---

## Query 33 — SELF JOIN

Use a self join on the `categories` table.

Display:

```text
child_category
parent_category
```

Example:

```text
Laptops | Computers
Tablets | Mobile Devices
```

---

# Part 7: Subqueries

## Query 34

Find products that are more expensive than the average product price.

---

## Query 35

Find customers whose total order amount is greater than the average order amount.

---

## Query 36

Find the most expensive product in each category.

---

## Query 37

Find customers who have placed at least one order.

Use:

```sql
EXISTS
```

---

## Query 38

Find customers who have never placed an order.

Use:

```sql
NOT EXISTS
```

---

## Query 39

Find products whose price is greater than every product belonging to a selected category.

Experiment with:

```sql
ALL
```

---

## Query 40

Find products whose price is greater than at least one product from another category.

Use:

```sql
ANY
```

or:

```sql
SOME
```

---

# Part 8: Correlated Subqueries

## Query 41

Find the most expensive product in every category using a correlated subquery.

---

## Query 42

Find customers whose total spending is higher than the average spending of customers from the same city.

---

## Query 43

Find products that have received a rating above the average rating of products belonging to the same category.

---

# Part 9: CASE Expressions

## Query 44

Categorize products based on price.

Use the following rules:

```text
Price < 500          → Budget
500–2000             → Mid Range
Above 2000           → Premium
```

Expected output:

```text
product_name
price
price_category
```

---

## Query 45

Categorize stock levels:

```text
0                   → Out of Stock
1–10                → Low Stock
11–50               → Medium Stock
Above 50            → High Stock
```

---

## Query 46

Display an order status description using `CASE`.

Example:

```text
Pending → Awaiting Processing
Shipped → On the Way
Delivered → Completed
Cancelled → Order Cancelled
```

---

# Part 10: Common Table Expressions — CTE

Use the `WITH` clause.

---

## Query 47

Create a CTE that calculates total spending for every customer.

Display only customers who have spent more than `5000`.

Example structure:

```sql
WITH customer_spending AS (
    ...
)
SELECT ...
FROM customer_spending
WHERE ...;
```

---

## Query 48

Create a CTE to calculate total sales for each product.

Display the ten highest-selling products.

---

## Query 49

Create multiple CTEs in one query.

Create:

```text
customer_order_summary
product_sales_summary
```

and use them in a final query.

---

## Query 50

Use a CTE to find customers whose spending is above the overall average customer spending.

---

# Part 11: Recursive CTE

Use the category hierarchy.

Example:

```text
Electronics
    Computers
        Laptops
        Desktops
    Mobile Devices
        Smartphones
        Tablets
```

---

## Query 51

Write a recursive CTE that displays the complete category hierarchy.

Expected output might include:

```text
category_id
category_name
parent_category
level
```

---

## Query 52

Display the category hierarchy using indentation.

Example:

```text
Electronics
    Computers
        Laptops
        Desktops
    Mobile Devices
        Smartphones
        Tablets
```

Hint:

Use a recursive CTE and functions such as:

```sql
REPEAT()
```

or string concatenation.

---

# Part 12: Views

Views represent stored SQL queries.

---

## Task 53

Create a view named:

```sql
customer_order_summary
```

The view should contain:

```text
customer_id
customer_name
total_orders
total_spent
last_order_date
```

---

## Task 54

Query the `customer_order_summary` view and display the five highest-spending customers.

---

## Task 55

Create another view named:

```sql
product_sales_summary
```

It should contain:

```text
product_id
product_name
category_name
total_quantity_sold
total_sales
```

---

## Task 56

Use the view to find products whose sales exceed `10000`.

---

## Task 57

Attempt to update data through one of your views.

Explain:

* Whether the view is updatable
* Why it is or is not updatable
* What restrictions apply to updating SQL views

---

# Part 13: Materialized Views

A normal view executes its underlying query when accessed.

A materialized view stores the result physically.

---

## Task 58

Create a materialized view named:

```sql
monthly_sales_summary
```

The materialized view should contain:

```text
sales_year
sales_month
total_orders
total_products_sold
total_revenue
```

Use information from:

```text
orders
order_items
```

---

## Task 59

Query the materialized view to display monthly revenue.

---

## Task 60

Add new orders to the database.

Query the materialized view again.

Explain why the new information may not immediately appear.

---

## Task 61

Refresh the materialized view.

PostgreSQL example:

```sql
REFRESH MATERIALIZED VIEW monthly_sales_summary;
```

Verify that the new data is now visible.

---

## Task 62

Research and explain the difference between:

```text
VIEW
```

and:

```text
MATERIALIZED VIEW
```

Discuss:

* Storage
* Query execution
* Performance
* Data freshness
* Refresh requirements

---

# Part 14: Indexes

Indexes can improve query performance but can also increase storage and write overhead.

---

## Task 63

Create an index on:

```text
customers.email
```

Example:

```sql
CREATE INDEX ...;
```

---

## Task 64

Create an index on:

```text
orders.customer_id
```

---

## Task 65

Create an index on:

```text
orders.order_date
```

---

## Task 66

Create a composite index on:

```text
order_status
order_date
```

---

## Task 67

Create an index that helps search products by:

```text
category_id
price
```

---

## Task 68

Use PostgreSQL:

```sql
EXPLAIN
```

or:

```sql
EXPLAIN ANALYZE
```

to inspect a query before and after creating an index.

Example query:

```sql
SELECT *
FROM orders
WHERE customer_id = 10;
```

Compare:

* Execution plan
* Execution time
* Sequential scan
* Index scan

---

## Task 69

Remove an index using:

```sql
DROP INDEX
```

Explain when removing an index might be appropriate.

---

## Index Discussion Questions

Answer the following:

1. Why can indexes improve `SELECT` performance?
2. Why can too many indexes decrease `INSERT` performance?
3. What is a composite index?
4. Does column order matter in a composite index?
5. What is the difference between a unique index and a normal index?
6. When should a column not be indexed?

---

# Part 15: Stored Procedures

Use PostgreSQL stored procedures.

---

## Task 70

Create a stored procedure named:

```sql
update_product_stock
```

Parameters:

```text
product_id
quantity_change
```

The procedure should increase or decrease the stock quantity.

It should not allow stock to become negative.

---

## Task 71

Create a procedure named:

```sql
cancel_order
```

The procedure should:

1. Receive an `order_id`.
2. Check whether the order exists.
3. Check whether the order has already been delivered.
4. Prevent cancellation of delivered orders.
5. Update the order status to `Cancelled`.
6. Restore product quantities to stock.

---

## Task 72

Create a procedure named:

```sql
process_payment
```

Parameters could include:

```text
order_id
payment_method
payment_amount
transaction_reference
```

The procedure should insert a new payment record.

---

## Task 73

Create a procedure that marks orders older than a specified number of days as delayed if they are still in `Processing` status.

---

# Part 16: User-Defined Functions

---

## Task 74

Create a function named:

```sql
calculate_order_total
```

Input:

```text
order_id
```

Return:

```text
total order value
```

Calculate:

```text
quantity × unit_price
```

while considering discounts.

---

## Task 75

Create a function named:

```sql
customer_total_spending
```

Input:

```text
customer_id
```

Return the total amount spent by the customer.

---

## Task 76

Create a function named:

```sql
get_customer_order_count
```

Input:

```text
customer_id
```

Return the total number of orders placed by the customer.

---

## Task 77

Create a function named:

```sql
product_average_rating
```

Input:

```text
product_id
```

Return the product's average rating.

If no reviews exist, return `0`.

---

## Task 78

Use your functions inside normal SQL queries.

Example concept:

```sql
SELECT
    customer_id,
    first_name,
    customer_total_spending(customer_id)
FROM customers;
```

---

# Part 17: Procedure vs Function

Write a short explanation comparing:

| Feature               | Procedure | Function |
| --------------------- | --------- | -------- |
| Returns value         |           |          |
| Called using          |           |          |
| Can be used in SELECT |           |          |
| Transaction control   |           |          |
| Typical use           |           |          |

Explain when you would use a procedure instead of a function.

---

# Part 18: Window Functions

Although not mandatory in the main topic list, window functions are highly useful in advanced SQL.

---

## Query 79

Rank products according to price using:

```sql
RANK()
```

---

## Query 80

Rank products within each category according to price.

Use:

```sql
PARTITION BY
```

---

## Query 81

Find the top three most expensive products in every category.

---

## Query 82

Calculate a running total of sales ordered by date.

---

## Query 83

Use:

```sql
ROW_NUMBER()
```

to assign a unique number to every customer order.

---

## Query 84

Compare each order's value with the customer's previous order using:

```sql
LAG()
```

---

# Part 19: Date and Time Queries

## Query 85

Find all orders placed today.

---

## Query 86

Find all orders placed during the current month.

---

## Query 87

Calculate monthly revenue.

---

## Query 88

Find customers who have not placed an order in the last six months.

---

## Query 89

Find the number of days between:

```text
registration_date
```

and the customer's first order date.

---

# Part 20: String Functions

## Query 90

Display each customer's complete name by combining:

```text
first_name
last_name
```

---

## Query 91

Display all customer emails in lowercase.

---

## Query 92

Display product names in uppercase.

---

## Query 93

Find the length of every product name.

---

## Query 94

Extract the domain name from customer email addresses.

Example:

```text
john@gmail.com
```

should produce:

```text
gmail.com
```

---

# Part 21: NULL Handling

Use:

```sql
IS NULL
IS NOT NULL
COALESCE()
NULLIF()
```

---

## Query 95

Find customers with no phone number.

---

## Query 96

Display:

```text
Not Available
```

when a customer's phone number is null.

Use:

```sql
COALESCE()
```

---

## Query 97

Find products that have never received a review.

---

# Part 22: Set Operations

Demonstrate:

```sql
UNION
UNION ALL
INTERSECT
EXCEPT
```

---

## Query 98

Use `UNION` to combine customer cities and shipping cities into one unique list.

---

## Query 99

Repeat using `UNION ALL` and explain the difference.

---

## Query 100

Use `INTERSECT` to find cities that appear both in customer addresses and shipping addresses.

---

## Query 101

Use `EXCEPT` to find customer cities that have never appeared as shipping cities.

---

# Part 23: Transactions

Create a transaction that simulates placing an order.

The transaction should:

1. Create a new order.
2. Insert records into `order_items`.
3. Reduce product stock.
4. Insert payment information.
5. Commit if everything succeeds.
6. Roll back if anything fails.

Demonstrate:

```sql
BEGIN;
COMMIT;
ROLLBACK;
```

---

## Task 102

Demonstrate a successful transaction.

---

## Task 103

Demonstrate a failed transaction and use `ROLLBACK`.

Explain why transactions are important in an e-commerce system.

---

# Part 24: Advanced Business Queries

Write SQL solutions for the following business problems.

## Query 104

Find the top five customers by total spending.

---

## Query 105

Find the top five best-selling products based on quantity sold.

---

## Query 106

Find the top five products based on total revenue.

---

## Query 107

Find the category generating the most revenue.

---

## Query 108

Find customers who have ordered more than five different products.

---

## Query 109

Find products that were ordered by more than ten different customers.

---

## Query 110

Find customers who bought products from at least three different categories.

---

## Query 111

Find the most popular product in every category.

---

## Query 112

Find customers who have purchased the same product more than once.

---

## Query 113

Find customers whose total spending is above the average customer spending.

---

## Query 114

Find the second-highest priced product.

Solve it using:

1. A subquery
2. A window function

---

## Query 115

Find the third-highest spending customer.

---

## Query 116

Find the month with the highest revenue.

---

## Query 117

Find the product with the highest average review rating.

Only include products having at least three reviews.

---

## Query 118

Find customers who have placed orders but have never submitted a review.

---

## Query 119

Find products that are low in stock but have high sales.

Define:

```text
Low stock = fewer than 10 units
High sales = more than 20 units sold
```

---

## Query 120

Find customers whose latest order was cancelled.

---

# Part 25: Performance Optimization Case Study

Assume the `orders` table now contains **1,000,000 rows**.

The following query is frequently executed:

```sql
SELECT *
FROM orders
WHERE customer_id = 500
AND order_status = 'Delivered'
AND order_date >= '2026-01-01';
```

Answer the following:

1. Which columns should be indexed?
2. Would you create separate indexes or a composite index?
3. In what order would you place the columns in the composite index?
4. Why?
5. How would you verify whether PostgreSQL is using your index?
6. What disadvantages could the index create?

Create an appropriate index and inspect the query using:

```sql
EXPLAIN ANALYZE
```

---

# Part 26: View vs Materialized View Case Study

Management needs a dashboard showing:

```text
Monthly revenue
Total orders
Total customers
Top-selling products
Average order value
```

The dashboard is opened hundreds of times per hour, but the information only needs to update once every hour.

Answer:

1. Would you use a normal view or a materialized view?
2. Why?
3. What data would you store in it?
4. How frequently would you refresh it?
5. What performance benefits would it provide?
6. What disadvantages would it have?

Implement your proposed solution.

---

# Part 27: Final Integrated Challenge

Create a database report called:

```text
Customer Performance Report
```

For every customer, display:

```text
customer_id
customer_name
city
registration_date
total_orders
completed_orders
cancelled_orders
total_products_purchased
total_spent
average_order_value
last_order_date
customer_rank
customer_category
```

Classify customers as:

```text
Total spending >= 20,000 → Platinum
Total spending >= 10,000 → Gold
Total spending >= 5,000  → Silver
Otherwise                → Regular
```

Use as many of the following as appropriate:

* JOIN
* GROUP BY
* CASE
* CTE
* Aggregate functions
* Window functions
* Subqueries

Create this final report first as a query and then as a view named:

```sql
customer_performance_report
```

---

# Part 28: Final Materialized View Challenge

Create a materialized view named:

```sql
executive_sales_dashboard
```

Include:

```text
sales_month
total_revenue
total_orders
total_customers
total_products_sold
average_order_value
```

Create an index on the materialized view that could improve filtering by month.

Demonstrate:

```sql
REFRESH MATERIALIZED VIEW executive_sales_dashboard;
```

---

# Part 29: Documentation Questions

Answer the following questions in your report.

1. What is a primary key?
2. What is a foreign key?
3. What is normalization?
4. What is the difference between `WHERE` and `HAVING`?
5. What is the difference between `DELETE`, `TRUNCATE`, and `DROP`?
6. What is the difference between INNER JOIN and LEFT JOIN?
7. What is a self join?
8. What is a subquery?
9. What is a correlated subquery?
10. What is a CTE?
11. What is a recursive CTE?
12. What is a view?
13. What is a materialized view?
14. What is an index?
15. What are the advantages and disadvantages of indexes?
16. What is a stored procedure?
17. What is a function?
18. What is the difference between a procedure and a function?
19. What is a transaction?
20. What are `COMMIT` and `ROLLBACK`?
21. What is a window function?
22. What is the difference between `RANK()`, `DENSE_RANK()`, and `ROW_NUMBER()`?
23. Why are materialized views useful for reporting systems?
24. When should materialized views be refreshed?
25. How can `EXPLAIN ANALYZE` help optimize SQL queries?

---

# Submission Requirements

Submit the following files.

### 1. Database Schema

```text
01_schema.sql
```

Must contain:

* Database tables
* Primary keys
* Foreign keys
* Constraints

### 2. Sample Data

```text
02_sample_data.sql
```

Must contain all `INSERT` statements.

### 3. Queries

```text
03_queries.sql
```

Must contain the solutions to all SQL query questions.

### 4. Views

```text
04_views.sql
```

Must contain all views.

### 5. Materialized Views

```text
05_materialized_views.sql
```

### 6. Indexes

```text
06_indexes.sql
```

### 7. Procedures

```text
07_procedures.sql
```

### 8. Functions

```text
08_functions.sql
```

### 9. CTE Queries

```text
09_ctes.sql
```

### 10. Final Report

Submit a PDF or document containing:

* Database design explanation
* Screenshots of query execution
* Important query results
* Index performance comparison
* View vs materialized view explanation
* Procedure and function explanations
* Answers to theoretical questions

---

# Suggested Project Folder Structure

```text
sql-assignment/
│
├── 01_schema.sql
├── 02_sample_data.sql
├── 03_queries.sql
├── 04_views.sql
├── 05_materialized_views.sql
├── 06_indexes.sql
├── 07_procedures.sql
├── 08_functions.sql
├── 09_ctes.sql
├── README.md
└── report.pdf
```

---

# Marking Scheme

| Section                              |   Marks |
| ------------------------------------ | ------: |
| Database schema and constraints      |      10 |
| Sample data quality                  |       5 |
| Basic and aggregate queries          |      10 |
| Joins                                |      10 |
| Subqueries and correlated subqueries |      10 |
| CTEs and recursive CTEs              |      10 |
| Views                                |       7 |
| Materialized views                   |       8 |
| Indexes and query optimization       |      10 |
| Stored procedures                    |       7 |
| User-defined functions               |       7 |
| Final integrated queries             |       4 |
| Documentation and code quality       |       2 |
| **Total**                            | **100** |

---

# Evaluation Criteria

Students will be evaluated on:

* Correct SQL syntax
* Proper relational database design
* Appropriate use of primary and foreign keys
* Correct use of JOIN operations
* Efficient use of subqueries
* Proper use of CTEs
* Correct implementation of recursive CTEs
* Proper implementation of views
* Proper implementation and refreshing of materialized views
* Appropriate index selection
* Understanding of query optimization
* Correct stored procedure logic
* Correct function implementation
* Handling of NULL values
* Proper transaction handling
* Readable and well-formatted SQL
* Meaningful table and column names

---

# Bonus Challenges

Complete any of the following for bonus marks.

## Bonus 1 — Trigger

Create a trigger that automatically reduces product stock after a new order item is inserted.

---

## Bonus 2 — Audit Table

Create:

```text
product_price_history
```

Store:

```text
product_id
old_price
new_price
changed_at
```

Create a trigger that automatically records every price change.

---

## Bonus 3 — Automatic Timestamp

Create a trigger that automatically records the latest modification timestamp whenever a product is updated.

---

## Bonus 4 — Partial Index

Create a PostgreSQL partial index containing only active products.

Example objective:

```text
Index products where is_active = TRUE
```

Explain why a partial index may require less storage than a full index.

---

## Bonus 5 — Unique Composite Index

Prevent the same customer from reviewing the same product multiple times using a unique composite index.

---

## Bonus 6 — Concurrent Materialized View Refresh

Research:

```sql
REFRESH MATERIALIZED VIEW CONCURRENTLY
```

Explain:

* How it differs from a normal refresh
* Its advantages
* Its requirements
* When it should be used

---

# Learning Outcome

After completing this assignment, you should be able to:

* Design relational database schemas
* Write complex SQL queries
* Combine data using different joins
* Solve problems using subqueries
* Create correlated subqueries
* Use CTEs to simplify complex queries
* Build recursive queries
* Create reusable database views
* Create and refresh materialized views
* Improve performance using indexes
* Analyze queries using `EXPLAIN ANALYZE`
* Create stored procedures
* Develop reusable SQL functions
* Use transactions safely
* Apply SQL to realistic business problems
* Understand the trade-offs between performance, maintainability, and data freshness

The final database should function as a small but realistic **e-commerce database system** demonstrating both SQL querying and advanced database programming concepts.
