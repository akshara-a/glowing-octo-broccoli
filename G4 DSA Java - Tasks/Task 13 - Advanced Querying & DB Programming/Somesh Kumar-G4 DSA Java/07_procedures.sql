-- =========================================================
-- TASK 13 - ADVANCED QUERYING & DB PROGRAMMING
-- 07_procedures.sql
-- ShopSphere Database
-- PostgreSQL
-- =========================================================


-- =========================================================
-- PROCEDURE 1 - UPDATE PRODUCT STOCK
-- =========================================================

CREATE OR REPLACE PROCEDURE update_product_stock(
    p_product_id INT,
    p_quantity_change INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_current_stock INT;
BEGIN

    SELECT stock_quantity
    INTO v_current_stock
    FROM products
    WHERE product_id = p_product_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Product ID % does not exist',
            p_product_id;
    END IF;


    IF v_current_stock + p_quantity_change < 0 THEN
        RAISE EXCEPTION
            'Insufficient stock. Current stock = %, requested change = %',
            v_current_stock,
            p_quantity_change;
    END IF;


    UPDATE products
    SET stock_quantity =
        stock_quantity + p_quantity_change
    WHERE product_id = p_product_id;


    RAISE NOTICE
        'Stock updated successfully for product ID %',
        p_product_id;

END;
$$;


-- =========================================================
-- TEST PROCEDURE 1
-- =========================================================

-- Add 5 units
CALL update_product_stock(1, 5);

SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE product_id = 1;


-- Remove 5 units again
-- This restores original sample stock.
CALL update_product_stock(1, -5);

SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE product_id = 1;


-- =========================================================
-- PROCEDURE 2 - CANCEL ORDER
-- =========================================================

CREATE OR REPLACE PROCEDURE cancel_order(
    p_order_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_order_status VARCHAR(20);
BEGIN

    SELECT order_status
    INTO v_order_status
    FROM orders
    WHERE order_id = p_order_id
    FOR UPDATE;


    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Order ID % does not exist',
            p_order_id;
    END IF;


    IF v_order_status = 'Delivered' THEN
        RAISE EXCEPTION
            'Delivered order % cannot be cancelled',
            p_order_id;
    END IF;


    IF v_order_status = 'Cancelled' THEN
        RAISE NOTICE
            'Order % is already cancelled',
            p_order_id;

        RETURN;
    END IF;


    -- Restore stock for all items in the order
    UPDATE products p
    SET stock_quantity =
        p.stock_quantity + x.total_quantity
    FROM (

        SELECT
            product_id,
            SUM(quantity)::INT AS total_quantity

        FROM order_items

        WHERE order_id = p_order_id

        GROUP BY product_id

    ) x

    WHERE p.product_id = x.product_id;


    -- Change order status
    UPDATE orders
    SET order_status = 'Cancelled'
    WHERE order_id = p_order_id;


    RAISE NOTICE
        'Order % cancelled successfully',
        p_order_id;

END;
$$;


-- =========================================================
-- PROCEDURE 3 - PROCESS PAYMENT
-- =========================================================

CREATE OR REPLACE PROCEDURE process_payment(
    p_order_id INT,
    p_payment_method VARCHAR(30),
    p_payment_amount NUMERIC(10,2),
    p_transaction_reference VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM orders
        WHERE order_id = p_order_id
    ) THEN

        RAISE EXCEPTION
            'Order ID % does not exist',
            p_order_id;

    END IF;


    IF p_payment_amount < 0 THEN

        RAISE EXCEPTION
            'Payment amount cannot be negative';

    END IF;


    INSERT INTO payments (
        order_id,
        payment_date,
        payment_method,
        payment_status,
        amount,
        transaction_reference
    )
    VALUES (
        p_order_id,
        CURRENT_TIMESTAMP,
        p_payment_method,
        'Completed',
        p_payment_amount,
        p_transaction_reference
    )
    ON CONFLICT (order_id)
    DO UPDATE SET

        payment_date =
            EXCLUDED.payment_date,

        payment_method =
            EXCLUDED.payment_method,

        payment_status =
            EXCLUDED.payment_status,

        amount =
            EXCLUDED.amount,

        transaction_reference =
            EXCLUDED.transaction_reference;


    RAISE NOTICE
        'Payment processed successfully for order %',
        p_order_id;

END;
$$;


-- =========================================================
-- TEST PROCEDURE 3
-- =========================================================

-- Order 5 already exists in sample data.
-- This will update its existing payment safely.

CALL process_payment(
    5,
    'UPI',
    6598.00,
    'TXN-PROC-DEMO-005'
);


SELECT
    payment_id,
    order_id,
    payment_method,
    payment_status,
    amount,
    transaction_reference
FROM payments
WHERE order_id = 5;


-- =========================================================
-- PROCEDURE 4 - MARK OLD PROCESSING ORDERS
-- =========================================================

-- NOTE:
-- The assignment may mention a "Delayed" status.
-- Current orders table CHECK constraint does NOT allow
-- 'Delayed'.
--
-- Therefore this schema-compatible procedure identifies
-- old Processing orders and keeps them as Processing,
-- while displaying a NOTICE.
--
-- If 'Delayed' is later added to the schema constraint,
-- this procedure can be changed to set order_status
-- = 'Delayed'.


CREATE OR REPLACE PROCEDURE check_old_processing_orders(
    p_days INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_count INT;
BEGIN

    SELECT COUNT(*)
    INTO v_count

    FROM orders

    WHERE order_status = 'Processing'

      AND order_date <
          CURRENT_TIMESTAMP
          - make_interval(days => p_days);


    RAISE NOTICE
        '% processing order(s) are older than % day(s)',
        v_count,
        p_days;

END;
$$;


-- =========================================================
-- TEST PROCEDURE 4
-- =========================================================

CALL check_old_processing_orders(7);


-- Display old processing orders
SELECT
    order_id,
    customer_id,
    order_date,
    order_status
FROM orders
WHERE order_status = 'Processing'
  AND order_date <
      CURRENT_TIMESTAMP - INTERVAL '7 days'
ORDER BY order_date;


-- =========================================================
-- PROCEDURE EXPLANATION
-- =========================================================

-- A stored procedure is a reusable block of SQL and
-- PL/pgSQL statements stored inside the database.
--
-- PostgreSQL procedures are executed using CALL.
--
-- Benefits:
--
-- 1. Reusable database logic
-- 2. Better code organization
-- 3. Centralized business rules
-- 4. Reduced repeated SQL
-- 5. Can perform multiple database operations
--
-- Example:
--
-- CALL update_product_stock(1, 10);


-- =========================================================
-- 07_procedures.sql COMPLETE
-- =========================================================