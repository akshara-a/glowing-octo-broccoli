-- =========================================================
-- TASK 13 - ADVANCED QUERYING & DB PROGRAMMING
-- 04_views.sql
-- ShopSphere Database
-- PostgreSQL
-- =========================================================


-- =========================================================
-- TASK 53 - CUSTOMER ORDER SUMMARY VIEW
-- =========================================================

DROP VIEW IF EXISTS customer_performance_report;
DROP VIEW IF EXISTS product_sales_summary;
DROP VIEW IF EXISTS customer_order_summary;


CREATE OR REPLACE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    MAX(o.order_date) AS last_order_date
FROM customers c
LEFT JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name;


-- Display customer order summary
SELECT *
FROM customer_order_summary
ORDER BY customer_id;


-- =========================================================
-- TASK 54 - TOP 5 CUSTOMERS BY SPENDING
-- =========================================================

SELECT *
FROM customer_order_summary
ORDER BY total_spent DESC
LIMIT 5;


-- =========================================================
-- TASK 55 - PRODUCT SALES SUMMARY VIEW
-- =========================================================

CREATE OR REPLACE VIEW product_sales_summary AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,

    COALESCE(
        SUM(oi.quantity),
        0
    ) AS total_quantity_sold,

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
    ) AS total_sales

FROM products p

JOIN categories c
    ON c.category_id = p.category_id

LEFT JOIN order_items oi
    ON oi.product_id = p.product_id

GROUP BY
    p.product_id,
    p.product_name,
    c.category_name;


-- Display product sales summary
SELECT *
FROM product_sales_summary
ORDER BY product_id;


-- =========================================================
-- TASK 56 - PRODUCTS WITH SALES ABOVE 10000
-- =========================================================

SELECT *
FROM product_sales_summary
WHERE total_sales > 10000
ORDER BY total_sales DESC;


-- =========================================================
-- TASK 57 - VIEW UPDATABILITY
-- =========================================================

-- customer_order_summary and product_sales_summary
-- contain aggregate functions and GROUP BY.
--
-- Therefore, these views are not automatically updatable
-- in PostgreSQL.
--
-- INSERT, UPDATE or DELETE should be performed on the
-- original base tables instead.


-- =========================================================
-- FINAL CUSTOMER PERFORMANCE REPORT VIEW
-- =========================================================

CREATE OR REPLACE VIEW customer_performance_report AS

WITH order_level AS (

    SELECT
        c.customer_id,

        c.first_name || ' ' || c.last_name
            AS customer_name,

        c.city,

        c.registration_date,

        o.order_id,

        o.order_date,

        o.order_status,

        o.total_amount,

        COALESCE(
            SUM(oi.quantity),
            0
        ) AS products_in_order

    FROM customers c

    LEFT JOIN orders o
        ON o.customer_id = c.customer_id

    LEFT JOIN order_items oi
        ON oi.order_id = o.order_id

    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name,
        c.city,
        c.registration_date,
        o.order_id,
        o.order_date,
        o.order_status,
        o.total_amount

),

customer_stats AS (

    SELECT
        customer_id,

        customer_name,

        city,

        registration_date,

        COUNT(order_id)
            AS total_orders,

        COUNT(order_id)
            FILTER (
                WHERE order_status = 'Delivered'
            )
            AS completed_orders,

        COUNT(order_id)
            FILTER (
                WHERE order_status = 'Cancelled'
            )
            AS cancelled_orders,

        COALESCE(
            SUM(products_in_order),
            0
        )
            AS total_products_purchased,

        COALESCE(
            SUM(total_amount),
            0
        )
            AS total_spent,

        COALESCE(
            AVG(total_amount),
            0
        )
            AS average_order_value,

        MAX(order_date)
            AS last_order_date

    FROM order_level

    GROUP BY
        customer_id,
        customer_name,
        city,
        registration_date
)

SELECT
    customer_id,

    customer_name,

    city,

    registration_date,

    total_orders,

    completed_orders,

    cancelled_orders,

    total_products_purchased,

    total_spent,

    ROUND(
        average_order_value,
        2
    ) AS average_order_value,

    last_order_date,

    RANK() OVER (
        ORDER BY total_spent DESC
    ) AS customer_rank,

    CASE

        WHEN total_spent >= 20000
            THEN 'Platinum'

        WHEN total_spent >= 10000
            THEN 'Gold'

        WHEN total_spent >= 5000
            THEN 'Silver'

        ELSE 'Regular'

    END AS customer_category

FROM customer_stats;


-- =========================================================
-- DISPLAY FINAL CUSTOMER PERFORMANCE REPORT
-- =========================================================

SELECT *
FROM customer_performance_report
ORDER BY customer_rank;


-- =========================================================
-- 04_views.sql COMPLETE
-- =========================================================