-- =========================================================
-- TASK 13 - ADVANCED QUERYING & DB PROGRAMMING
-- 08_functions.sql
-- ShopSphere Database
-- PostgreSQL
-- =========================================================


-- =========================================================
-- FUNCTION 1 - CALCULATE ORDER TOTAL
-- =========================================================

CREATE OR REPLACE FUNCTION calculate_order_total(
    p_order_id INT
)
RETURNS NUMERIC
LANGUAGE sql
AS $$
    SELECT
        COALESCE(
            SUM(
                quantity
                * unit_price
                * (1 - discount / 100.0)
            ),
            0
        )
    FROM order_items
    WHERE order_id = p_order_id;
$$;


-- Test Function 1
SELECT
    order_id,
    calculate_order_total(order_id) AS calculated_order_total
FROM orders
ORDER BY order_id
LIMIT 10;


-- =========================================================
-- FUNCTION 2 - CUSTOMER TOTAL SPENDING
-- =========================================================

CREATE OR REPLACE FUNCTION customer_total_spending(
    p_customer_id INT
)
RETURNS NUMERIC
LANGUAGE sql
AS $$
    SELECT
        COALESCE(
            SUM(total_amount),
            0
        )
    FROM orders
    WHERE customer_id = p_customer_id;
$$;


-- Test Function 2
SELECT
    customer_id,
    first_name,
    last_name,
    customer_total_spending(customer_id)
        AS total_spending
FROM customers
ORDER BY customer_id;


-- =========================================================
-- FUNCTION 3 - CUSTOMER ORDER COUNT
-- =========================================================

CREATE OR REPLACE FUNCTION get_customer_order_count(
    p_customer_id INT
)
RETURNS BIGINT
LANGUAGE sql
AS $$
    SELECT
        COUNT(*)
    FROM orders
    WHERE customer_id = p_customer_id;
$$;


-- Test Function 3
SELECT
    customer_id,
    first_name,
    last_name,
    get_customer_order_count(customer_id)
        AS total_orders
FROM customers
ORDER BY customer_id;


-- =========================================================
-- FUNCTION 4 - PRODUCT AVERAGE RATING
-- =========================================================

CREATE OR REPLACE FUNCTION product_average_rating(
    p_product_id INT
)
RETURNS NUMERIC
LANGUAGE sql
AS $$
    SELECT
        COALESCE(
            AVG(rating),
            0
        )
    FROM reviews
    WHERE product_id = p_product_id;
$$;


-- Test Function 4
SELECT
    product_id,
    product_name,
    ROUND(
        product_average_rating(product_id),
        2
    ) AS average_rating
FROM products
ORDER BY product_id;


-- =========================================================
-- USING MULTIPLE FUNCTIONS IN A QUERY
-- =========================================================

SELECT
    c.customer_id,

    c.first_name || ' ' || c.last_name
        AS customer_name,

    customer_total_spending(c.customer_id)
        AS total_spending,

    get_customer_order_count(c.customer_id)
        AS total_orders

FROM customers c

ORDER BY total_spending DESC;


-- =========================================================
-- ORDER TOTAL COMPARISON
-- =========================================================

SELECT
    o.order_id,

    o.total_amount
        AS stored_total,

    ROUND(
        calculate_order_total(o.order_id),
        2
    ) AS calculated_total

FROM orders o

ORDER BY o.order_id;


-- =========================================================
-- PRODUCTS WITH GOOD RATINGS
-- =========================================================

SELECT
    p.product_id,

    p.product_name,

    ROUND(
        product_average_rating(p.product_id),
        2
    ) AS average_rating

FROM products p

WHERE product_average_rating(p.product_id) >= 4

ORDER BY average_rating DESC;


-- =========================================================
-- FUNCTION VS PROCEDURE
-- =========================================================

-- FUNCTION:
--
-- 1. Returns a value or table.
-- 2. Can be used inside SELECT statements.
-- 3. Can be used in WHERE, ORDER BY and expressions.
-- 4. Called using SELECT.
--
-- Example:
--
-- SELECT customer_total_spending(1);


-- PROCEDURE:
--
-- 1. Mainly performs database operations.
-- 2. Does not have to return a value.
-- 3. Called using CALL.
-- 4. Useful for multi-step business logic.
--
-- Example:
--
-- CALL update_product_stock(1, 5);


-- =========================================================
-- 08_functions.sql COMPLETE
-- =========================================================