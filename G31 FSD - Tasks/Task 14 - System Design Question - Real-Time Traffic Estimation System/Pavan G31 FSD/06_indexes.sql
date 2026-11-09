-- ============================================================
-- SHOPSPHERE E-COMMERCE DATABASE
-- FILE: 06_indexes.sql
-- PART 14: INDEXES & QUERY OPTIMIZATION
-- ============================================================


-- ============================================================
-- Query 63
-- Index on customer email
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_customers_email
ON customers(email);


-- ============================================================
-- Query 64
-- Index on customer_id in orders
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_orders_customer_id
ON orders(customer_id);


-- ============================================================
-- Query 65
-- Index on order_date
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_orders_order_date
ON orders(order_date);


-- ============================================================
-- Query 66
-- Composite index on order status and order date
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_orders_status_date
ON orders(order_status, order_date);


-- ============================================================
-- Query 67
-- Composite index on category and price
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_products_category_price
ON products(category_id, price);


-- ============================================================
-- Query 68
-- Inspect query execution using EXPLAIN ANALYZE
-- ============================================================

EXPLAIN ANALYZE
SELECT
    *
FROM orders
WHERE customer_id = 10;


-- ============================================================
-- Query 69
-- Remove an index
-- ============================================================

DROP INDEX IF EXISTS idx_orders_order_date;


-- ============================================================
-- PERFORMANCE OPTIMIZATION CASE STUDY
-- ============================================================

-- Frequently executed query:
--
-- SELECT *
-- FROM orders
-- WHERE customer_id = 500
-- AND order_status = 'Delivered'
-- AND order_date >= '2026-01-01';


-- Create composite index for the above query

CREATE INDEX IF NOT EXISTS idx_orders_customer_status_date
ON orders(customer_id, order_status, order_date);


-- Inspect the execution plan

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 500
  AND order_status = 'Delivered'
  AND order_date >= '2026-01-01';


-- ============================================================
-- Explanation
-- ============================================================

-- The composite index uses:
--
-- 1. customer_id
-- 2. order_status
-- 3. order_date
--
-- customer_id and order_status are equality filters,
-- while order_date is used as a range filter.
--
-- EXPLAIN ANALYZE can be used to check whether PostgreSQL
-- uses the index and to compare query execution performance.
--
-- Advantages:
-- 1. Faster filtering
-- 2. Faster data retrieval for matching queries
--
-- Disadvantages:
-- 1. Requires additional storage
-- 2. Requires index maintenance
-- 3. Can add overhead to INSERT operations
-- 4. Can add overhead to UPDATE operations
-- 5. Can add overhead to DELETE operations