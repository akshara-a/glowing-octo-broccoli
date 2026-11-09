-- Task 70
CREATE OR REPLACE PROCEDURE update_product_stock(
    p_product_id INT, p_quantity_change INT
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE products
       SET stock_quantity = stock_quantity + p_quantity_change
     WHERE product_id = p_product_id
       AND stock_quantity + p_quantity_change >= 0;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Product not found or stock would become negative';
    END IF;
END;
$$;
-- CALL update_product_stock(1, 5);

-- Task 71
CREATE OR REPLACE PROCEDURE cancel_order(p_order_id INT)
LANGUAGE plpgsql AS $$
DECLARE v_status TEXT;
BEGIN
    SELECT order_status INTO v_status
      FROM orders WHERE order_id=p_order_id FOR UPDATE;
    IF NOT FOUND THEN RAISE EXCEPTION 'Order % does not exist',p_order_id; END IF;
    IF v_status='Delivered' THEN RAISE EXCEPTION 'Delivered orders cannot be cancelled'; END IF;
    IF v_status='Cancelled' THEN RAISE EXCEPTION 'Order is already cancelled'; END IF;

    UPDATE products p
       SET stock_quantity=p.stock_quantity+x.qty
      FROM (SELECT product_id,SUM(quantity) AS qty
              FROM order_items WHERE order_id=p_order_id GROUP BY product_id) x
     WHERE p.product_id=x.product_id;

    UPDATE orders SET order_status='Cancelled' WHERE order_id=p_order_id;
    UPDATE payments SET payment_status='Refunded'
     WHERE order_id=p_order_id AND payment_status='Completed';
END;
$$;
-- CALL cancel_order(4);

-- Task 72
CREATE OR REPLACE PROCEDURE process_payment(
    p_order_id INT,
    p_payment_method VARCHAR(30),
    p_payment_amount NUMERIC(12,2),
    p_transaction_reference VARCHAR(100)
)
LANGUAGE plpgsql AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM orders WHERE order_id=p_order_id) THEN
        RAISE EXCEPTION 'Order % does not exist',p_order_id;
    END IF;
    INSERT INTO payments(order_id,payment_date,payment_method,payment_status,amount,transaction_reference)
    VALUES(p_order_id,CURRENT_TIMESTAMP,p_payment_method,'Completed',p_payment_amount,p_transaction_reference);
END;
$$;
-- CALL process_payment(1,'UPI',500,'TXN-NEW-001');

-- Task 73: assignment order_status CHECK list has no Delayed value.
-- Extend it before using the procedure:
-- ALTER TABLE orders DROP CONSTRAINT orders_order_status_check;
-- ALTER TABLE orders ADD CONSTRAINT orders_order_status_check
-- CHECK (order_status IN ('Pending','Processing','Shipped','Delivered','Cancelled','Delayed'));
CREATE OR REPLACE PROCEDURE mark_delayed_orders(p_days INT)
LANGUAGE plpgsql AS $$
BEGIN
    IF p_days < 0 THEN RAISE EXCEPTION 'Days must be non-negative'; END IF;
    UPDATE orders SET order_status='Delayed'
     WHERE order_status='Processing'
       AND order_date < CURRENT_TIMESTAMP - make_interval(days => p_days);
END;
$$;
