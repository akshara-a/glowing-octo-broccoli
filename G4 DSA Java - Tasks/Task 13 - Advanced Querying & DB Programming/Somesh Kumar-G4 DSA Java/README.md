# Task 13 - Advanced Querying & DB Programming

## ShopSphere Database

This task demonstrates advanced SQL querying and database programming concepts using PostgreSQL.

---

## Database

**Database Name:** `shopsphere_db`  
**Database:** PostgreSQL  
**Language:** SQL / PL/pgSQL

---

## Files

### 01_schema.sql

Creates the ShopSphere database schema.

Tables created:

- customers
- categories
- products
- orders
- order_items
- payments
- reviews

The schema includes:

- Primary Keys
- Foreign Keys
- UNIQUE constraints
- CHECK constraints
- DEFAULT values
- Referential integrity

---

### 02_sample_data.sql

Contains sample data used for testing the database.

Sample data includes:

- 10 Categories
- 20 Customers
- 30 Products
- 40 Orders
- 80 Order Items
- 30 Payments
- 25 Reviews

---

### 03_queries.sql

Contains SQL queries demonstrating:

- SELECT
- WHERE
- BETWEEN
- IN
- LIKE / ILIKE
- ORDER BY
- LIMIT
- Aggregate Functions
- GROUP BY
- HAVING
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN
- SELF JOIN
- Subqueries
- Correlated Subqueries
- EXISTS
- NOT EXISTS
- ANY
- ALL
- CASE Expressions
- Window Functions
- Date and Time Functions
- String Functions
- NULL Handling
- Set Operations
- Transactions
- Advanced Business Queries
- Customer Performance Analysis

---

### 04_views.sql

Creates reusable PostgreSQL views.

Views created:

- `customer_order_summary`
- `product_sales_summary`
- `customer_performance_report`

These views provide summarized customer, product and business performance information.

---

### 05_materialized_views.sql

Creates materialized views for reporting and dashboard queries.

Materialized views created:

- `monthly_sales_summary`
- `executive_sales_dashboard`

Also demonstrates:

- `REFRESH MATERIALIZED VIEW`
- Difference between View and Materialized View
- Indexing a Materialized View

---

### 06_indexes.sql

Creates indexes to improve query performance.

Indexes are created on commonly searched and joined columns such as:

- Customer email
- Customer city
- Product category
- Product price
- Order customer ID
- Order date
- Order status
- Order item foreign keys
- Payment order ID
- Review product ID

A composite index is also created on:

`(customer_id, order_date)`

The file also demonstrates:

- EXPLAIN
- EXPLAIN ANALYZE
- Sequential Scan
- Index usage concepts

---

### 07_procedures.sql

Implements stored procedures using PL/pgSQL.

Procedures created:

- `update_product_stock`
- `cancel_order`
- `process_payment`
- `check_old_processing_orders`

These procedures demonstrate reusable database business logic.

---

### 08_functions.sql

Implements PostgreSQL functions.

Functions created:

- `calculate_order_total`
- `customer_total_spending`
- `get_customer_order_count`
- `product_average_rating`

The file also demonstrates the difference between PostgreSQL functions and procedures.

---

### 09_ctes.sql

Demonstrates Common Table Expressions.

Concepts covered:

- Simple CTE
- Multiple CTEs
- Customer spending analysis
- Product sales analysis
- Category sales analysis
- CTE with Window Functions
- Recursive CTE
- Category hierarchy

The recursive CTE displays parent-child category relationships.

Example:

```text
Electronics
    Computers
        Laptops
    Mobile Devices

Books
    Fiction

Home & Kitchen
    Kitchen Accessories