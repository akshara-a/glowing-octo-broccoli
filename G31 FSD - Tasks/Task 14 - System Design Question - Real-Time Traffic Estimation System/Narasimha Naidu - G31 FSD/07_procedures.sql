-- 07_procedures.sql
-- PostgreSQL procedures.

-- 70. Update product stock.
CREATE OR REPLACE PROCEDURE update_product_stock(
    p_product_id INT,
    p_quantity_change INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    current_stock INT;
BEGIN
    SELECT stock_quantity
    INTO current_stock
    FROM products
    WHERE product_id = p_product_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Product % does not exist', p_product_id;
    END IF;

    IF current_stock + p_quantity_change < 0 THEN
        RAISE EXCEPTION
            'Insufficient stock. Current stock: %, requested change: %',
            current_stock, p_quantity_change;
    END IF;

    UPDATE products
    SET stock_quantity = stock_quantity + p_quantity_change
    WHERE product_id = p_product_id;
END;
$$;

-- Example:
-- CALL update_product_stock(1, -2);
-- CALL update_product_stock(1, 5);


-- 71. Cancel an order and restore stock.
CREATE OR REPLACE PROCEDURE cancel_order(
    p_order_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status VARCHAR(20);
BEGIN
    SELECT order_status
    INTO v_status
    FROM orders
    WHERE order_id = p_order_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % does not exist', p_order_id;
    END IF;

    IF v_status = 'Delivered' THEN
        RAISE EXCEPTION 'Delivered order % cannot be cancelled', p_order_id;
    END IF;

    IF v_status = 'Cancelled' THEN
        RAISE EXCEPTION 'Order % is already cancelled', p_order_id;
    END IF;

    UPDATE orders
    SET order_status = 'Cancelled'
    WHERE order_id = p_order_id;

    UPDATE products p
    SET stock_quantity = p.stock_quantity + x.quantity
    FROM (
        SELECT product_id, SUM(quantity) AS quantity
        FROM order_items
        WHERE order_id = p_order_id
        GROUP BY product_id
    ) x
    WHERE p.product_id = x.product_id;
END;
$$;


-- 72. Process payment.
CREATE OR REPLACE PROCEDURE process_payment(
    p_order_id INT,
    p_payment_method VARCHAR(30),
    p_payment_amount NUMERIC(12,2),
    p_transaction_reference VARCHAR(150)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM orders WHERE order_id = p_order_id
    ) THEN
        RAISE EXCEPTION 'Order % does not exist', p_order_id;
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


-- 73. Mark old Processing orders as delayed.
-- The schema has no "Delayed" order status, so the assignment's
-- wording is represented by a notice rather than an invalid status.
CREATE OR REPLACE PROCEDURE mark_old_processing_orders(
    p_days INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_count INT;
BEGIN
    UPDATE orders
    SET order_status = 'Shipped'
    WHERE order_status = 'Processing'
      AND order_date < CURRENT_TIMESTAMP - make_interval(days => p_days);

    GET DIAGNOSTICS v_count = ROW_COUNT;

    RAISE NOTICE '% old Processing order(s) were advanced to Shipped status.', v_count;
END;
$$;

-- Examples:
-- CALL cancel_order(7);
-- CALL process_payment(31, 'UPI', 1500, 'TXN-MANUAL-31');
-- CALL mark_old_processing_orders(10);
