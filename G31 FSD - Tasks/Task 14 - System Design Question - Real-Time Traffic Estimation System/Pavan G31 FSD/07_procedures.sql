-- ============================================================
-- SHOPSPHERE E-COMMERCE DATABASE
-- FILE: 07_procedures.sql
-- PART 15: STORED PROCEDURES
-- ============================================================


-- ============================================================
-- Query 70
-- Procedure to increase or decrease product stock
-- ============================================================

CREATE OR REPLACE PROCEDURE update_product_stock(
    p_product_id INTEGER,
    p_quantity_change INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    current_stock INTEGER;
BEGIN

    SELECT stock_quantity
    INTO current_stock
    FROM products
    WHERE product_id = p_product_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Product with ID % does not exist',
            p_product_id;
    END IF;

    IF current_stock + p_quantity_change < 0 THEN
        RAISE EXCEPTION
            'Insufficient stock. Current stock: %, requested change: %',
            current_stock,
            p_quantity_change;
    END IF;

    UPDATE products
    SET stock_quantity = stock_quantity + p_quantity_change
    WHERE product_id = p_product_id;

END;
$$;


-- Example:
-- CALL update_product_stock(1, 10);
-- CALL update_product_stock(1, -5);


-- ============================================================
-- Query 71
-- Procedure to cancel an order
-- ============================================================

CREATE OR REPLACE PROCEDURE cancel_order(
    p_order_id INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    current_status VARCHAR(20);
BEGIN

    SELECT order_status
    INTO current_status
    FROM orders
    WHERE order_id = p_order_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Order with ID % does not exist',
            p_order_id;
    END IF;

    IF current_status = 'Delivered' THEN
        RAISE EXCEPTION
            'Delivered order % cannot be cancelled',
            p_order_id;
    END IF;

    IF current_status = 'Cancelled' THEN
        RAISE EXCEPTION
            'Order % is already cancelled',
            p_order_id;
    END IF;

    -- Restore product stock

    UPDATE products p
    SET stock_quantity = p.stock_quantity + oi.quantity
    FROM order_items oi
    WHERE oi.product_id = p.product_id
      AND oi.order_id = p_order_id;

    -- Change order status

    UPDATE orders
    SET order_status = 'Cancelled'
    WHERE order_id = p_order_id;

END;
$$;


-- Example:
-- CALL cancel_order(10);


-- ============================================================
-- Query 72
-- Procedure to process a payment
-- ============================================================

CREATE OR REPLACE PROCEDURE process_payment(
    p_order_id INTEGER,
    p_payment_method VARCHAR(30),
    p_payment_amount NUMERIC(12,2),
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
            'Order with ID % does not exist',
            p_order_id;

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
    );

END;
$$;


-- Example:
-- CALL process_payment(
--     10,
--     'UPI',
--     2500.00,
--     'TXN10010'
-- );


-- ============================================================
-- Query 73
-- Procedure to identify delayed processing orders
-- ============================================================

CREATE OR REPLACE PROCEDURE mark_delayed_orders(
    p_days INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE orders
    SET order_status = 'Delayed'
    WHERE order_status = 'Processing'
      AND order_date <
          CURRENT_TIMESTAMP - (p_days * INTERVAL '1 day');

END;
$$;


-- Example:
-- CALL mark_delayed_orders(7);