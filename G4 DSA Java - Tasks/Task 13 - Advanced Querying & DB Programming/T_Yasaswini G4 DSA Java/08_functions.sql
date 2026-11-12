-- Task 74
CREATE OR REPLACE FUNCTION calculate_order_total(p_order_id INT)
RETURNS NUMERIC LANGUAGE SQL STABLE AS $$
    SELECT COALESCE(SUM(quantity*unit_price*(1-discount/100)),0)
    FROM order_items WHERE order_id=p_order_id;
$$;

-- Task 75
CREATE OR REPLACE FUNCTION customer_total_spending(p_customer_id INT)
RETURNS NUMERIC LANGUAGE SQL STABLE AS $$
    SELECT COALESCE(SUM(total_amount),0)
    FROM orders
    WHERE customer_id=p_customer_id AND order_status<>'Cancelled';
$$;

-- Task 76
CREATE OR REPLACE FUNCTION get_customer_order_count(p_customer_id INT)
RETURNS BIGINT LANGUAGE SQL STABLE AS $$
    SELECT COUNT(*) FROM orders WHERE customer_id=p_customer_id;
$$;

-- Task 77
CREATE OR REPLACE FUNCTION product_average_rating(p_product_id INT)
RETURNS NUMERIC LANGUAGE SQL STABLE AS $$
    SELECT COALESCE(AVG(rating),0) FROM reviews WHERE product_id=p_product_id;
$$;

-- Task 78
SELECT customer_id,first_name,customer_total_spending(customer_id) AS total_spending,
       get_customer_order_count(customer_id) AS order_count
FROM customers;
SELECT product_id,product_name,product_average_rating(product_id) AS average_rating
FROM products;
SELECT order_id,calculate_order_total(order_id) AS calculated_total
FROM orders;

-- Procedure vs Function:
-- Function returns a value (or table) and is called in SELECT or expressions.
-- Procedure is invoked with CALL and is used for actions/workflows.
-- PostgreSQL functions cannot perform transaction control in the same way procedures can;
-- procedures may use transaction control in permitted CALL contexts.
