-- Tasks 58-61
CREATE MATERIALIZED VIEW IF NOT EXISTS monthly_sales_summary AS
SELECT EXTRACT(YEAR FROM o.order_date)::int AS sales_year,
       EXTRACT(MONTH FROM o.order_date)::int AS sales_month,
       COUNT(DISTINCT o.order_id) AS total_orders,
       COALESCE(SUM(oi.quantity),0) AS total_products_sold,
       COALESCE(SUM(oi.quantity*oi.unit_price*(1-oi.discount/100)),0) AS total_revenue
FROM orders o LEFT JOIN order_items oi USING(order_id)
WHERE o.order_status <> 'Cancelled'
GROUP BY 1,2;

-- Task 59
SELECT * FROM monthly_sales_summary ORDER BY sales_year,sales_month;

-- Task 60: Changes to base tables are not visible until refresh.
-- Add test data separately, then run the refresh below.

-- Task 61
REFRESH MATERIALIZED VIEW monthly_sales_summary;
SELECT * FROM monthly_sales_summary ORDER BY sales_year,sales_month;

-- Task 62:
-- A VIEW stores only its SQL definition and computes from current base-table data on access.
-- A MATERIALIZED VIEW stores query results physically, so reads can be faster but data may be stale.
-- A materialized view must be refreshed to show later changes.
-- Dashboard: materialize monthly aggregates and refresh hourly (for example, from a scheduled job).
CREATE MATERIALIZED VIEW IF NOT EXISTS executive_sales_dashboard AS
SELECT date_trunc('month',o.order_date)::date AS sales_month,
       SUM(o.total_amount) FILTER(WHERE o.order_status<>'Cancelled') AS total_revenue,
       COUNT(DISTINCT o.order_id) FILTER(WHERE o.order_status<>'Cancelled') AS total_orders,
       COUNT(DISTINCT o.customer_id) FILTER(WHERE o.order_status<>'Cancelled') AS total_customers,
       COALESCE(SUM(oi.quantity) FILTER(WHERE o.order_status<>'Cancelled'),0) AS total_products_sold,
       AVG(o.total_amount) FILTER(WHERE o.order_status<>'Cancelled') AS average_order_value
FROM orders o LEFT JOIN order_items oi USING(order_id)
GROUP BY date_trunc('month',o.order_date)::date;
CREATE INDEX IF NOT EXISTS idx_executive_sales_dashboard_month
    ON executive_sales_dashboard(sales_month);
REFRESH MATERIALIZED VIEW executive_sales_dashboard;

-- For REFRESH MATERIALIZED VIEW CONCURRENTLY, create a unique index covering all rows
-- (for example, a unique index on sales_month if each month appears once).
-- Concurrent refresh avoids blocking readers, but requires a populated materialized view
-- and a qualifying unique index with only column names (no expression or partial predicate).
