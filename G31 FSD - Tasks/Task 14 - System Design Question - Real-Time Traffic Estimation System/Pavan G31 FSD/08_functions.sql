-- ============================================================
-- SHOPSPHERE E-COMMERCE DATABASE
-- FILE: 08_functions.sql
-- PART 16: USER-DEFINED FUNCTIONS
-- ============================================================


-- ============================================================
-- Query 74
-- Calculate total amount of an order
-- ============================================================

CREATE OR REPLACE FUNCTION calculate_order_total(
    p_order_id INTEGER
)
RETURNS NUMERIC(12,2)
LANGUAGE plpgsql
AS $$
DECLARE
    order_total NUMERIC(12,2);
BEGIN

    SELECT COALESCE(
        SUM(
            oi.quantity
            * oi.unit_price
            * (1 - oi.discount / 100)
        ),
        0
    )
    INTO order_total
    FROM order_items oi
    WHERE oi.order_id = p_order_id;

    RETURN order_total;

END;
$$;


-- Test Query 74

SELECT
    order_id,
    calculate_order_total(order_id) AS calculated_total
FROM orders
ORDER BY order_id;


-- ============================================================
-- Query 75
-- Calculate total spending of a customer
-- ============================================================

CREATE OR REPLACE FUNCTION customer_total_spending(
    p_customer_id INTEGER
)
RETURNS NUMERIC(12,2)
LANGUAGE plpgsql
AS $$
DECLARE
    total_spending NUMERIC(12,2);
BEGIN

    SELECT COALESCE(SUM(total_amount), 0)
    INTO total_spending
    FROM orders
    WHERE customer_id = p_customer_id
      AND order_status <> 'Cancelled';

    RETURN total_spending;

END;
$$;


-- Test Query 75

SELECT
    customer_id,
    first_name,
    last_name,
    customer_total_spending(customer_id) AS total_spent
FROM customers
ORDER BY total_spent DESC;


-- ============================================================
-- Query 76
-- Get the total number of orders placed by a customer
-- ============================================================

CREATE OR REPLACE FUNCTION get_customer_order_count(
    p_customer_id INTEGER
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    order_count INTEGER;
BEGIN

    SELECT COUNT(*)
    INTO order_count
    FROM orders
    WHERE customer_id = p_customer_id;

    RETURN order_count;

END;
$$;


-- Test Query 76

SELECT
    customer_id,
    first_name,
    last_name,
    get_customer_order_count(customer_id) AS total_orders
FROM customers
ORDER BY total_orders DESC;


-- ============================================================
-- Query 77
-- Calculate average product review rating
-- ============================================================

CREATE OR REPLACE FUNCTION product_average_rating(
    p_product_id INTEGER
)
RETURNS NUMERIC(4,2)
LANGUAGE plpgsql
AS $$
DECLARE
    average_rating NUMERIC(4,2);
BEGIN

    SELECT COALESCE(
        ROUND(AVG(rating), 2),
        0
    )
    INTO average_rating
    FROM reviews
    WHERE product_id = p_product_id;

    RETURN average_rating;

END;
$$;


-- Test Query 77

SELECT
    product_id,
    product_name,
    product_average_rating(product_id) AS average_rating
FROM products
ORDER BY average_rating DESC;


-- ============================================================
-- Query 78
-- Use multiple user-defined functions together
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    customer_total_spending(c.customer_id) AS total_spent,
    get_customer_order_count(c.customer_id) AS total_orders
FROM customers c
ORDER BY total_spent DESC;