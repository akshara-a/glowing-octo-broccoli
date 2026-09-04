-- ============================================================
-- SHOPSPHERE E-COMMERCE DATABASE
-- FILE: 04_views.sql
-- PART 12: VIEWS
-- ============================================================


-- ============================================================
-- Query 53
-- Customer Order Summary
-- ============================================================

CREATE OR REPLACE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name;


-- ============================================================
-- Query 54
-- Product Sales Summary
-- ============================================================

CREATE OR REPLACE VIEW product_sales_summary AS
SELECT
    p.product_id,
    p.product_name,
    COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold,
    COALESCE(
        SUM(
            oi.quantity
            * oi.unit_price
            * (1 - oi.discount / 100)
        ),
        0
    ) AS total_revenue
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name;


-- ============================================================
-- Query 55
-- Category Revenue Summary
-- ============================================================

CREATE OR REPLACE VIEW category_revenue_summary AS
SELECT
    c.category_id,
    c.category_name,
    COALESCE(
        SUM(
            oi.quantity
            * oi.unit_price
            * (1 - oi.discount / 100)
        ),
        0
    ) AS total_revenue
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    c.category_id,
    c.category_name;


-- ============================================================
-- Query 56
-- Display Customer Order Summary
-- ============================================================

SELECT *
FROM customer_order_summary
ORDER BY total_spent DESC;


-- ============================================================
-- Query 57
-- Display Product Sales Summary
-- ============================================================

SELECT *
FROM product_sales_summary
ORDER BY total_revenue DESC;


-- ============================================================
-- Additional display
-- Category Revenue Summary
-- ============================================================

SELECT *
FROM category_revenue_summary
ORDER BY total_revenue DESC;
