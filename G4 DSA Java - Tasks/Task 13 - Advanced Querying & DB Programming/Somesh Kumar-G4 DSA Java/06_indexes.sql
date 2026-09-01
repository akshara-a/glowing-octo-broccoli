-- =========================================================
-- TASK 13 - ADVANCED QUERYING & DB PROGRAMMING
-- 06_indexes.sql
-- ShopSphere Database
-- PostgreSQL
-- =========================================================


-- =========================================================
-- CLEAN EXISTING INDEXES
-- =========================================================

DROP INDEX IF EXISTS idx_customers_email;
DROP INDEX IF EXISTS idx_customers_city;
DROP INDEX IF EXISTS idx_products_category_id;
DROP INDEX IF EXISTS idx_products_price;
DROP INDEX IF EXISTS idx_orders_customer_id;
DROP INDEX IF EXISTS idx_orders_order_date;
DROP INDEX IF EXISTS idx_orders_status;
DROP INDEX IF EXISTS idx_order_items_order_id;
DROP INDEX IF EXISTS idx_order_items_product_id;
DROP INDEX IF EXISTS idx_payments_order_id;
DROP INDEX IF EXISTS idx_reviews_product_id;
DROP INDEX IF EXISTS idx_orders_customer_date;


-- =========================================================
-- TASK 62 - INDEX ON CUSTOMER EMAIL
-- =========================================================

-- Note:
-- customers.email already has a UNIQUE constraint,
-- so PostgreSQL automatically creates a unique index.
-- This additional index is included for index demonstration.

CREATE INDEX IF NOT EXISTS idx_customers_email
ON customers(email);


-- =========================================================
-- TASK 63 - INDEX ON CUSTOMER CITY
-- =========================================================

CREATE INDEX IF NOT EXISTS idx_customers_city
ON customers(city);


-- =========================================================
-- TASK 64 - INDEX ON PRODUCT CATEGORY
-- =========================================================

CREATE INDEX IF NOT EXISTS idx_products_category_id
ON products(category_id);


-- =========================================================
-- TASK 65 - INDEX ON PRODUCT PRICE
-- =========================================================

CREATE INDEX IF NOT EXISTS idx_products_price
ON products(price);


-- =========================================================
-- TASK 66 - INDEX ON ORDER CUSTOMER ID
-- =========================================================

CREATE INDEX IF NOT EXISTS idx_orders_customer_id
ON orders(customer_id);


-- =========================================================
-- TASK 67 - INDEX ON ORDER DATE
-- =========================================================

CREATE INDEX IF NOT EXISTS idx_orders_order_date
ON orders(order_date);


-- =========================================================
-- INDEX ON ORDER STATUS
-- =========================================================

CREATE INDEX IF NOT EXISTS idx_orders_status
ON orders(order_status);


-- =========================================================
-- INDEXES FOR FOREIGN KEY / JOIN COLUMNS
-- =========================================================

CREATE INDEX IF NOT EXISTS idx_order_items_order_id
ON order_items(order_id);


CREATE INDEX IF NOT EXISTS idx_order_items_product_id
ON order_items(product_id);


-- payments.order_id already has a UNIQUE constraint.
-- PostgreSQL automatically creates an index for it.
-- Included here for demonstration.

CREATE INDEX IF NOT EXISTS idx_payments_order_id
ON payments(order_id);


CREATE INDEX IF NOT EXISTS idx_reviews_product_id
ON reviews(product_id);


-- =========================================================
-- TASK 68 - COMPOSITE INDEX
-- =========================================================

-- Useful when retrieving a customer's orders
-- ordered or filtered by date.

CREATE INDEX IF NOT EXISTS idx_orders_customer_date
ON orders(customer_id, order_date);


-- =========================================================
-- DISPLAY CREATED INDEXES
-- =========================================================

SELECT
    schemaname,
    tablename,
    indexname
FROM pg_indexes
WHERE schemaname = 'public'
  AND tablename IN (
      'customers',
      'products',
      'orders',
      'order_items',
      'payments',
      'reviews'
  )
ORDER BY
    tablename,
    indexname;


-- =========================================================
-- TASK 69 - EXPLAIN QUERY
-- =========================================================

EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 3;


-- =========================================================
-- EXPLAIN ANALYZE
-- =========================================================

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 3;


-- =========================================================
-- EXPLAIN PRODUCT CATEGORY QUERY
-- =========================================================

EXPLAIN ANALYZE
SELECT *
FROM products
WHERE category_id = 4;


-- =========================================================
-- EXPLAIN PRODUCT PRICE QUERY
-- =========================================================

EXPLAIN ANALYZE
SELECT *
FROM products
WHERE price > 5000;


-- =========================================================
-- EXPLAIN COMPOSITE INDEX QUERY
-- =========================================================

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 3
  AND order_date >= '2026-01-01'
ORDER BY order_date;


-- =========================================================
-- INDEX EXPLANATION
-- =========================================================

-- Indexes improve SELECT query performance by reducing
-- the amount of data PostgreSQL needs to scan.
--
-- Indexes are especially useful for:
--
-- 1. WHERE conditions
-- 2. JOIN conditions
-- 3. ORDER BY operations
-- 4. Frequently searched columns
-- 5. Foreign key columns
--
-- Advantages:
-- - Faster SELECT queries
-- - Faster searching
-- - Faster JOIN operations
-- - Can improve sorting performance
--
-- Disadvantages:
-- - Consume additional disk space
-- - INSERT operations may become slightly slower
-- - UPDATE operations may become slightly slower
-- - DELETE operations may become slightly slower
-- - Too many indexes can reduce write performance
--
-- NOTE:
-- Since ShopSphere currently contains only a small
-- sample dataset, PostgreSQL may choose a Sequential Scan
-- instead of an Index Scan in EXPLAIN ANALYZE.
-- This is normal and does NOT mean the index is incorrect.


-- =========================================================
-- 06_indexes.sql COMPLETE
-- =========================================================