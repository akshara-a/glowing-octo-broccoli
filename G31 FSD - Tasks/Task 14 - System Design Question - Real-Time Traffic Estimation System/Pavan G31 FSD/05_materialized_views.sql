-- ============================================================
-- SHOPSPHERE E-COMMERCE DATABASE
-- FILE: 05_materialized_views.sql
-- PART 13: MATERIALIZED VIEWS
-- ============================================================


-- ============================================================
-- Query 58
-- Create Monthly Sales Summary
-- ============================================================

CREATE MATERIALIZED VIEW monthly_sales_summary AS
SELECT
    EXTRACT(YEAR FROM order_date)::INT AS sales_year,
    EXTRACT(MONTH FROM order_date)::INT AS sales_month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS monthly_revenue
FROM orders
WHERE order_status <> 'Cancelled'
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY
    sales_year,
    sales_month;


-- ============================================================
-- Query 59
-- Display Monthly Sales Summary
-- ============================================================

SELECT
    sales_year,
    sales_month,
    total_orders,
    monthly_revenue
FROM monthly_sales_summary
ORDER BY
    sales_year,
    sales_month;


-- ============================================================
-- Query 60
-- Add a new order and demonstrate that the
-- materialized view does not automatically update
-- ============================================================

INSERT INTO orders (
    customer_id,
    order_date,
    order_status,
    shipping_city,
    shipping_country,
    total_amount
)
VALUES (
    1,
    CURRENT_TIMESTAMP,
    'Delivered',
    'Chennai',
    'India',
    3500.00
);


SELECT
    sales_year,
    sales_month,
    total_orders,
    monthly_revenue
FROM monthly_sales_summary
ORDER BY
    sales_year,
    sales_month;


-- ============================================================
-- Query 61
-- Refresh the materialized view
-- ============================================================

REFRESH MATERIALIZED VIEW monthly_sales_summary;


SELECT
    sales_year,
    sales_month,
    total_orders,
    monthly_revenue
FROM monthly_sales_summary
ORDER BY
    sales_year,
    sales_month;


-- ============================================================
-- Query 62
-- VIEW vs MATERIALIZED VIEW
-- ============================================================

-- VIEW:
-- Stores the SQL query definition.
-- Does not physically store the result.
-- Normally displays current underlying data.
--
-- MATERIALIZED VIEW:
-- Physically stores the query result.
-- Can provide faster access for repeated reporting.
-- Data can become outdated.
-- Requires REFRESH MATERIALIZED VIEW to update it.


-- ============================================================
-- FINAL MATERIALIZED VIEW
-- EXECUTIVE SALES DASHBOARD
-- ============================================================

-- Query 128
-- Create the final executive sales dashboard.
--
-- If this materialized view already exists because it was
-- created while testing Part 26, do not execute this CREATE
-- statement again.

CREATE MATERIALIZED VIEW IF NOT EXISTS executive_sales_dashboard AS
SELECT
    DATE_TRUNC('month', o.order_date)::DATE AS sales_month,
    SUM(o.total_amount) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    COALESCE(SUM(oi.quantity), 0) AS total_products_sold,
    AVG(o.total_amount) AS average_order_value
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    DATE_TRUNC('month', o.order_date)
ORDER BY
    sales_month;


-- ============================================================
-- Query 129
-- Create an index for month-based filtering
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_executive_sales_dashboard_month
ON executive_sales_dashboard(sales_month);


-- ============================================================
-- Query 130
-- Display Executive Sales Dashboard
-- ============================================================

SELECT
    sales_month,
    total_revenue,
    total_orders,
    total_customers,
    total_products_sold,
    average_order_value
FROM executive_sales_dashboard
ORDER BY
    sales_month;


-- ============================================================
-- Query 131
-- Refresh Executive Sales Dashboard
-- ============================================================

REFRESH MATERIALIZED VIEW executive_sales_dashboard;


-- ============================================================
-- Query 132
-- Display Refreshed Dashboard
-- ============================================================

SELECT *
FROM executive_sales_dashboard
ORDER BY
    sales_month;