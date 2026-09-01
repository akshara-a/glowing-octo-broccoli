-- 06_indexes.sql

-- Required assignment indexes.
CREATE INDEX IF NOT EXISTS idx_customers_email
ON customers(email);

CREATE INDEX IF NOT EXISTS idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX IF NOT EXISTS idx_orders_order_date
ON orders(order_date);

CREATE INDEX IF NOT EXISTS idx_orders_status_date
ON orders(order_status, order_date);

CREATE INDEX IF NOT EXISTS idx_products_category_price
ON products(category_id, price);

-- Useful indexes for joins/searches.
CREATE INDEX IF NOT EXISTS idx_order_items_order_product
ON order_items(order_id, product_id);

CREATE INDEX IF NOT EXISTS idx_reviews_product_rating
ON reviews(product_id, rating);

-- Performance case study.
EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 10
  AND order_status = 'Delivered'
  AND order_date >= DATE '2026-01-01';

-- Index specifically useful for the case-study predicate.
CREATE INDEX IF NOT EXISTS idx_orders_customer_status_date
ON orders(customer_id, order_status, order_date);

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 10
  AND order_status = 'Delivered'
  AND order_date >= DATE '2026-01-01';

-- Bonus: partial index for active products.
CREATE INDEX IF NOT EXISTS idx_active_products_category
ON products(category_id)
WHERE is_active = TRUE;

-- Bonus: prevent the same customer reviewing the same product twice.
CREATE UNIQUE INDEX IF NOT EXISTS uq_customer_product_review
ON reviews(customer_id, product_id);

-- To remove an index:
-- DROP INDEX IF EXISTS idx_orders_customer_status_date;
