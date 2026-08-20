-- 05_materialized_views.sql

DROP MATERIALIZED VIEW IF EXISTS monthly_sales_summary;
DROP MATERIALIZED VIEW IF EXISTS executive_sales_dashboard;

CREATE MATERIALIZED VIEW monthly_sales_summary AS
SELECT
    DATE_TRUNC('month', o.order_date)::DATE AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_products_sold,
    SUM(oi.quantity * oi.unit_price * (1-oi.discount/100.0)) AS total_revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY DATE_TRUNC('month', o.order_date);

CREATE MATERIALIZED VIEW executive_sales_dashboard AS
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', o.order_date)::DATE AS sales_month,
        SUM(oi.quantity * oi.unit_price * (1-oi.discount/100.0)) AS total_revenue,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.quantity) AS total_products_sold,
        COUNT(DISTINCT o.customer_id) AS total_customers,
        AVG(o.total_amount) AS average_order_value
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY DATE_TRUNC('month', o.order_date)
)
SELECT
    sales_month,
    ROUND(total_revenue,2) AS total_revenue,
    total_orders,
    total_customers,
    total_products_sold,
    ROUND(average_order_value,2) AS average_order_value
FROM monthly;

CREATE INDEX idx_executive_sales_dashboard_month
ON executive_sales_dashboard(sales_month);

SELECT * FROM monthly_sales_summary ORDER BY sales_month;
SELECT * FROM executive_sales_dashboard ORDER BY sales_month;

-- After new data is inserted:
-- REFRESH MATERIALIZED VIEW monthly_sales_summary;
-- REFRESH MATERIALIZED VIEW executive_sales_dashboard;

-- Normal VIEW:
--   Stores query definition.
--   Always reads current base-table data.
--
-- Materialized VIEW:
--   Stores the result physically.
--   Usually faster for repeated reporting.
--   Can become stale.
--   Requires REFRESH.
