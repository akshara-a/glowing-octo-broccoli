-- =========================================================
-- TASK 13 - ADVANCED QUERYING & DB PROGRAMMING
-- 05_materialized_views.sql
-- ShopSphere Database
-- PostgreSQL
-- =========================================================


-- =========================================================
-- CLEAN EXISTING MATERIALIZED VIEWS
-- =========================================================

DROP MATERIALIZED VIEW IF EXISTS executive_sales_dashboard;
DROP MATERIALIZED VIEW IF EXISTS monthly_sales_summary;


-- =========================================================
-- TASK 58 - MONTHLY SALES SUMMARY MATERIALIZED VIEW
-- =========================================================

CREATE MATERIALIZED VIEW monthly_sales_summary AS

SELECT
    EXTRACT(YEAR FROM o.order_date)::INT AS sales_year,

    EXTRACT(MONTH FROM o.order_date)::INT AS sales_month,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COALESCE(
        SUM(oi.quantity),
        0
    ) AS total_products_sold,

    COALESCE(
        ROUND(
            SUM(
                oi.quantity
                * oi.unit_price
                * (1 - oi.discount / 100.0)
            ),
            2
        ),
        0
    ) AS total_revenue

FROM orders o

LEFT JOIN order_items oi
    ON oi.order_id = o.order_id

GROUP BY
    EXTRACT(YEAR FROM o.order_date),
    EXTRACT(MONTH FROM o.order_date)

ORDER BY
    sales_year,
    sales_month;


-- Display complete materialized view
SELECT *
FROM monthly_sales_summary;


-- =========================================================
-- TASK 59 - DISPLAY MONTHLY REVENUE
-- =========================================================

SELECT
    sales_year,
    sales_month,
    total_revenue
FROM monthly_sales_summary
ORDER BY
    sales_year,
    sales_month;


-- =========================================================
-- TASK 60 - MATERIALIZED VIEW EXPLANATION
-- =========================================================

-- A materialized view stores the query result physically.
--
-- Unlike a normal VIEW, it does not automatically show
-- changes made to the underlying tables.
--
-- If new orders or order items are inserted,
-- monthly_sales_summary may contain old/stale data
-- until REFRESH MATERIALIZED VIEW is executed.


-- =========================================================
-- TASK 61 - REFRESH MATERIALIZED VIEW
-- =========================================================

REFRESH MATERIALIZED VIEW monthly_sales_summary;


-- Display after refresh
SELECT *
FROM monthly_sales_summary
ORDER BY
    sales_year,
    sales_month;


-- =========================================================
-- EXECUTIVE SALES DASHBOARD
-- =========================================================

CREATE MATERIALIZED VIEW executive_sales_dashboard AS

WITH order_level AS (

    SELECT
        o.order_id,

        DATE_TRUNC(
            'month',
            o.order_date
        )::DATE AS sales_month,

        o.customer_id,

        o.total_amount,

        COALESCE(
            SUM(oi.quantity),
            0
        ) AS products_sold

    FROM orders o

    LEFT JOIN order_items oi
        ON oi.order_id = o.order_id

    GROUP BY
        o.order_id,
        DATE_TRUNC('month', o.order_date),
        o.customer_id,
        o.total_amount
)

SELECT
    sales_month,

    SUM(total_amount) AS total_revenue,

    COUNT(order_id) AS total_orders,

    COUNT(DISTINCT customer_id)
        AS total_customers,

    SUM(products_sold)
        AS total_products_sold,

    ROUND(
        AVG(total_amount),
        2
    ) AS average_order_value

FROM order_level

GROUP BY sales_month

ORDER BY sales_month;


-- =========================================================
-- CREATE INDEX ON MATERIALIZED VIEW
-- =========================================================

CREATE UNIQUE INDEX IF NOT EXISTS
    idx_executive_dashboard_month
ON executive_sales_dashboard (sales_month);


-- =========================================================
-- REFRESH EXECUTIVE DASHBOARD
-- =========================================================

REFRESH MATERIALIZED VIEW executive_sales_dashboard;


-- =========================================================
-- DISPLAY EXECUTIVE DASHBOARD
-- =========================================================

SELECT *
FROM executive_sales_dashboard
ORDER BY sales_month;


-- =========================================================
-- VIEW VS MATERIALIZED VIEW
-- =========================================================

-- VIEW:
-- Stores only the SQL query definition.
-- Always reads current data from base tables.
-- Does not require REFRESH.
--
-- MATERIALIZED VIEW:
-- Stores query output physically in the database.
-- Faster for repeated reports and dashboard queries.
-- Data can become stale.
-- Requires REFRESH MATERIALIZED VIEW.


-- =========================================================
-- 05_materialized_views.sql COMPLETE
-- =========================================================