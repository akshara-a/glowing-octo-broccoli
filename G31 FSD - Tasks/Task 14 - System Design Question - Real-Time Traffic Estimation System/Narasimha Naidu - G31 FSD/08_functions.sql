-- 08_functions.sql

-- 74. Calculate order total.
CREATE OR REPLACE FUNCTION calculate_order_total(
    p_order_id INT
)
RETURNS NUMERIC(12,2)
LANGUAGE sql
AS $$
    SELECT COALESCE(
        ROUND(SUM(
            quantity * unit_price * (1 - discount / 100.0)
        ), 2),
        0
    )
    FROM order_items
    WHERE order_id = p_order_id;
$$;


-- 75. Customer total spending.
CREATE OR REPLACE FUNCTION customer_total_spending(
    p_customer_id INT
)
RETURNS NUMERIC(12,2)
LANGUAGE sql
AS $$
    SELECT COALESCE(
        ROUND(SUM(total_amount),2),
        0
    )
    FROM orders
    WHERE customer_id = p_customer_id
      AND order_status <> 'Cancelled';
$$;


-- 76. Customer order count.
CREATE OR REPLACE FUNCTION get_customer_order_count(
    p_customer_id INT
)
RETURNS INT
LANGUAGE sql
AS $$
    SELECT COUNT(*)::INT
    FROM orders
    WHERE customer_id = p_customer_id;
$$;


-- 77. Product average rating.
CREATE OR REPLACE FUNCTION product_average_rating(
    p_product_id INT
)
RETURNS NUMERIC(4,2)
LANGUAGE sql
AS $$
    SELECT COALESCE(
        ROUND(AVG(rating),2),
        0
    )
    FROM reviews
    WHERE product_id = p_product_id;
$$;


-- 78. Use functions inside normal queries.
SELECT
    customer_id,
    first_name,
    customer_total_spending(customer_id) AS total_spending,
    get_customer_order_count(customer_id) AS order_count
FROM customers
ORDER BY total_spending DESC;

SELECT
    product_id,
    product_name,
    calculate_order_total(
        (SELECT MIN(order_id) FROM order_items oi WHERE oi.product_id = products.product_id)
    ) AS sample_order_total
FROM products
WHERE EXISTS (
    SELECT 1 FROM order_items oi WHERE oi.product_id = products.product_id
);

SELECT
    product_id,
    product_name,
    product_average_rating(product_id) AS average_rating
FROM products
ORDER BY average_rating DESC;
