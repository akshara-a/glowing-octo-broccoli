ShopSphere E-Commerce Database

A PostgreSQL-based e-commerce database project designed to demonstrate advanced SQL concepts through a realistic online shopping scenario.

Project Overview

ShopSphere is an e-commerce database that manages customers, product categories, products, orders, order items, payments, and product reviews.

The project demonstrates how SQL can be used to:

Design a relational database

Insert and manage sample data

Retrieve and analyze business data

Perform aggregations and joins

Use subqueries and correlated subqueries

Work with CTEs and recursive CTEs

Create views and materialized views

Create and analyze indexes

Develop stored procedures and user-defined functions

Use window functions

Handle transactions

Perform date, string, NULL, and set operations

Build advanced business reports

Optimize query performance

Technology Used

Database: PostgreSQL

Language: SQL / PL/pgSQL

Database Client: PostgreSQL psql / VS Code

Operating System: Windows

Database Name

shopsphere_db

Database Tables

The database contains the following core tables:

Table

Purpose

customers

Stores customer information

categories

Stores product categories and category hierarchy

products

Stores product details, prices, and stock

orders

Stores customer orders

order_items

Stores products included in each order

payments

Stores payment information

reviews

Stores customer product reviews

Main Relationships

customers
    │
    └──< orders
            │
            └──< order_items >── products >── categories
                                      │
                                      └──< reviews
            │
            └──< payments

customers ───────────────< reviews

Relationship Summary

One customer can place many orders.

One order can contain many order items.

One product can appear in many order items.

One category can contain many products.

Categories can have parent-child relationships.

One order can have payment records.

Customers can review products.

Project Structure

ShopSphere/
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
└── ShopSphere_SQL_Final_Report.pdf

SQL Files

01_schema.sql

Creates the ShopSphere database tables, primary keys, foreign keys, constraints, and relationships.

02_sample_data.sql

Populates the database with sample customers, categories, products, orders, order items, payments, and reviews.

The sample data is designed to demonstrate different real-world cases such as:

Active and inactive customers

Customers with and without orders

Products with high and low stock

Products that have never been ordered

Products with and without reviews

Different order statuses

Successful and failed payments

Different customer locations

Different product ratings

03_queries.sql

Contains the main SQL query exercises covering Queries 1–120.

Topics include:

Basic SELECT queries

Filtering

Sorting

DISTINCT

Aggregations

GROUP BY

HAVING

JOINs

Subqueries

Correlated subqueries

CASE expressions

CTEs

Recursive CTEs

Views

Materialized views

Indexes

Stored procedures

Functions

Window functions

Date and time operations

String functions

NULL handling

Set operations

Transactions

Advanced business queries

04_views.sql

Creates reporting views for:

Customer order summaries

Product sales summaries

Category revenue summaries

Views provide reusable query definitions for reporting and analysis.

05_materialized_views.sql

Creates materialized views for reporting scenarios where query results can be stored and refreshed periodically.

It includes:

Monthly sales summary

Executive sales dashboard

Refresh operations

Dashboard indexing

06_indexes.sql

Demonstrates database indexing and query performance optimization.

It includes indexes for:

Customer email

Order customer ID

Order date

Order status and date

Product category and price

It also demonstrates:

EXPLAIN ANALYZE

for examining query execution plans.

A composite index is also demonstrated for a high-volume order-search scenario involving:

customer_id
order_status
order_date

07_procedures.sql

Contains stored procedures for business operations such as:

Updating product stock

Cancelling orders

Processing payments

Handling delayed processing orders

08_functions.sql

Contains user-defined functions for:

Calculating order totals

Calculating customer spending

Counting customer orders

Calculating product average ratings

09_ctes.sql

Contains:

Common Table Expressions

Multiple CTEs

Recursive CTEs

Category hierarchy analysis

Setup Instructions

1. Install PostgreSQL

Install PostgreSQL and make sure the PostgreSQL server is running.

Verify the installation:

psql --version

Example:

psql (PostgreSQL) 18.6

2. Create the Database

Open PostgreSQL psql and connect as the PostgreSQL administrator:

psql -U postgres

Create the database:

CREATE DATABASE shopsphere_db;

Connect to it:

\c shopsphere_db

You should see a message similar to:

You are now connected to database "shopsphere_db"

Running the SQL Files

Run the files in the following order.

Step 1 — Create the Schema

psql -U postgres -d shopsphere_db -f 01_schema.sql

Step 2 — Insert Sample Data

psql -U postgres -d shopsphere_db -f 02_sample_data.sql

Step 3 — Run Main Queries

psql -U postgres -d shopsphere_db -f 03_queries.sql

Step 4 — Create Views

psql -U postgres -d shopsphere_db -f 04_views.sql

Step 5 — Create Materialized Views

psql -U postgres -d shopsphere_db -f 05_materialized_views.sql

Step 6 — Create Indexes

psql -U postgres -d shopsphere_db -f 06_indexes.sql

Step 7 — Create Stored Procedures

psql -U postgres -d shopsphere_db -f 07_procedures.sql

Step 8 — Create Functions

psql -U postgres -d shopsphere_db -f 08_functions.sql

Step 9 — Run CTE Queries

psql -U postgres -d shopsphere_db -f 09_ctes.sql

Running from the PostgreSQL Prompt

The same files can also be executed from inside psql:

\c shopsphere_db

\i '01_schema.sql'
\i '02_sample_data.sql'
\i '03_queries.sql'
\i '04_views.sql'
\i '05_materialized_views.sql'
\i '06_indexes.sql'
\i '07_procedures.sql'
\i '08_functions.sql'
\i '09_ctes.sql'

Use the correct file path if the SQL files are stored in another directory.

Verifying the Database

To list all tables:

\dt

To inspect a table:

\d customers

To inspect products:

\d products

To check the number of customers:

SELECT COUNT(*) FROM customers;

To check the number of products:

SELECT COUNT(*) FROM products;

To check the number of orders:

SELECT COUNT(*) FROM orders;

Advanced SQL Concepts Demonstrated

Joins

The project demonstrates:

INNER JOIN

LEFT JOIN

RIGHT JOIN

FULL OUTER JOIN

SELF JOIN

Subqueries

The project demonstrates:

Scalar subqueries

Subqueries with aggregates

EXISTS

NOT EXISTS

ANY

ALL

CTEs

CTEs are used to make complex queries easier to understand and maintain.

Example:

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_spending;

Recursive CTEs

Recursive CTEs are used to display category hierarchies and parent-child relationships.

Window Functions

The project demonstrates functions such as:

RANK()
ROW_NUMBER()
LAG()
SUM() OVER()

These are used for ranking, running totals, sequential numbering, and comparison with previous rows.

Transactions

Transactions demonstrate:

BEGIN;
COMMIT;
ROLLBACK;

They help maintain database consistency when multiple related operations must succeed or fail together.

Performance Optimization

The project includes an optimization case study based on a large orders table.

The query filters by:

customer_id
order_status
order_date

A composite index is used:

CREATE INDEX idx_orders_customer_status_date
ON orders(customer_id, order_status, order_date);

Performance can be inspected using:

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 500
  AND order_status = 'Delivered'
  AND order_date >= '2026-01-01';

EXPLAIN ANALYZE helps inspect the actual execution plan and execution time.

Customer Performance Report

The project includes a final customer performance analysis containing information such as:

Customer ID

Customer name

City

Registration date

Total orders

Completed orders

Cancelled orders

Total products purchased

Total spending

Average order value

Last order date

Customer rank

Customer category

Customer categories are based on total spending:

Total Spending

Category

>= 20,000

Platinum

>= 10,000

Gold

>= 5,000

Silver

< 5,000

Regular

The final report also creates a reusable view:

customer_performance_report

Executive Sales Dashboard

The project includes a materialized view:

executive_sales_dashboard

It provides monthly business metrics including:

Sales month

Total revenue

Total orders

Total customers

Total products sold

Average order value

The materialized view can be refreshed using:

REFRESH MATERIALIZED VIEW executive_sales_dashboard;

Views vs Materialized Views

View

A normal view stores the SQL query definition and retrieves current data when queried.

Materialized View

A materialized view stores the query result physically and can provide faster reporting for expensive queries.

The materialized view must be refreshed when updated data needs to be reflected.

Project Learning Outcomes

This project provides practical experience with:

Relational database design

PostgreSQL

SQL querying

Data relationships

Business analytics

Query optimization

Database reporting

PL/pgSQL procedures

User-defined functions

CTEs

Recursive queries

Window functions

Transactions

Views and materialized views

Indexing

Important Notes

Execute the schema before inserting sample data.

Execute sample data before running analytical queries.

Views, functions, procedures, indexes, and materialized views depend on the database schema.

Run SQL files in the recommended order.

EXPLAIN ANALYZE results can vary depending on database size, PostgreSQL version, indexes, and system resources.

Materialized views may need to be refreshed after underlying tables are modified.

Optional Bonus Features

The assignment also provides optional bonus challenges, including:

Trigger-based stock reduction

Audit logging

Automatic timestamp updates

Partial indexes

Composite uniqueness for reviews

Concurrent materialized-view refresh

These features are optional and are separate from the core required implementation.

Conclusion

ShopSphere demonstrates the design and implementation of a complete PostgreSQL e-commerce database using advanced SQL techniques.

The project combines database design, realistic sample data, analytical queries, reporting objects, stored procedures, functions, indexing, transactions, CTEs, and performance optimization into one integrated database solution.