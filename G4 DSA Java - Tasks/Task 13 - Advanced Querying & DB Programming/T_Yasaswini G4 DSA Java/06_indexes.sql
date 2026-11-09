-- Tasks 63-67
CREATE UNIQUE INDEX IF NOT EXISTS idx_customers_email ON customers(email);
CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_orders_order_date ON orders(order_date);
CREATE INDEX IF NOT EXISTS idx_orders_status_date ON orders(order_status,order_date);
CREATE INDEX IF NOT EXISTS idx_products_category_price ON products(category_id,price);

-- Task 68: inspect before and after index creation.
EXPLAIN ANALYZE SELECT * FROM orders WHERE customer_id=10;
CREATE INDEX IF NOT EXISTS idx_orders_customer_id_explain ON orders(customer_id);
ANALYZE orders;
EXPLAIN ANALYZE SELECT * FROM orders WHERE customer_id=10;
-- On a small table PostgreSQL may prefer a sequential scan. Test on a large table
-- and compare the plan and actual execution time.

-- Task 69: example index removal
DROP INDEX IF EXISTS idx_orders_customer_id_explain;

-- Task 25 performance case study:
-- customer_id equality, order_status equality, and order_date range are all predicates.
-- A composite B-tree index is a reasonable starting point:
CREATE INDEX IF NOT EXISTS idx_orders_customer_status_date
    ON orders(customer_id,order_status,order_date);
EXPLAIN ANALYZE
SELECT * FROM orders
WHERE customer_id=500
  AND order_status='Delivered'
  AND order_date >= DATE '2026-01-01';

-- Discussion:
-- 1. Indexes speed selective lookups by avoiding scanning every row.
-- 2. INSERT/UPDATE/DELETE must maintain indexes, adding work and storage.
-- 3. Composite index contains more than one key column.
-- 4. Column order matters; leading columns should match common equality filters,
--    followed by range/filter columns. Workload and selectivity should guide order.
-- 5. Unique index enforces uniqueness; ordinary index does not.
-- 6. Avoid indexes on tiny tables, rarely filtered columns, low-selectivity columns
--    without a workload reason, and columns frequently modified.
