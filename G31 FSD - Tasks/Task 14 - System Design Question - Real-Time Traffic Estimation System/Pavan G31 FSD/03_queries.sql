-- ============================================================
-- Query 1
-- Display all customers
-- ============================================================

SELECT *
FROM customers;


-- ============================================================
-- Query 2
-- Display first_name, last_name, email and city
-- for all active customers
-- ============================================================

SELECT
    first_name,
    last_name,
    email,
    city
FROM customers
WHERE status = 'Active';


-- ============================================================
-- Query 3
-- Find all products that cost more than 1000
-- ============================================================

SELECT *
FROM products
WHERE price > 1000;


-- ============================================================
-- Query 4
-- Display products whose price is between 500 and 2000
-- ============================================================

SELECT *
FROM products
WHERE price BETWEEN 500 AND 2000;


-- ============================================================
-- Query 5
-- Find customers living in any three cities using IN
-- ============================================================

SELECT *
FROM customers
WHERE city IN ('Chennai', 'Bangalore', 'Hyderabad');


-- ============================================================
-- Query 6
-- Find customers whose first name starts with A
-- ============================================================

SELECT *
FROM customers
WHERE first_name LIKE 'A%';


-- ============================================================
-- Query 7
-- Find products whose name contains the word Phone
-- ============================================================

SELECT *
FROM products
WHERE product_name ILIKE '%Phone%';


-- ============================================================
-- Query 8
-- Display all orders from newest to oldest
-- ============================================================

SELECT *
FROM orders
ORDER BY order_date DESC;


-- ============================================================
-- Query 9
-- Display the five most expensive products
-- ============================================================

SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;


-- ============================================================
-- Query 10
-- Display products with stock quantity below 10
-- ============================================================

SELECT *
FROM products
WHERE stock_quantity < 10;


-- ============================================================
-- PART 4: AGGREGATE FUNCTIONS
-- ============================================================


-- ============================================================
-- Query 11
-- Find the total number of customers
-- ============================================================

SELECT COUNT(*) AS total_customers
FROM customers;


-- ============================================================
-- Query 12
-- Find the total number of products
-- ============================================================

SELECT COUNT(*) AS total_products
FROM products;


-- ============================================================
-- Query 13
-- Find the average product price
-- ============================================================

SELECT ROUND(AVG(price), 2) AS average_product_price
FROM products;


-- ============================================================
-- Query 14
-- Find the cheapest product
-- ============================================================

SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price = (
    SELECT MIN(price)
    FROM products
);


-- ============================================================
-- Query 15
-- Find the most expensive product
-- ============================================================

SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);


-- ============================================================
-- Query 16
-- Calculate the total value of all orders
-- ============================================================

SELECT
    SUM(total_amount) AS total_order_value
FROM orders;


-- ============================================================
-- Query 17
-- Calculate the average order amount
-- ============================================================

SELECT
    ROUND(AVG(total_amount), 2) AS average_order_amount
FROM orders;


-- ============================================================
-- Query 18
-- Find the number of orders for each order status
-- ============================================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- ============================================================
-- PART 5: GROUP BY AND HAVING
-- ============================================================


-- ============================================================
-- Query 19
-- Display the number of products in each category
-- ============================================================

SELECT
    c.category_id,
    c.category_name,
    COUNT(p.product_id) AS product_count
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY product_count DESC;


-- ============================================================
-- Query 20
-- Find the average product price for each category
-- ============================================================

SELECT
    c.category_id,
    c.category_name,
    ROUND(AVG(p.price), 2) AS average_price
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY average_price DESC;


-- ============================================================
-- Query 21
-- Display categories whose average product price is greater
-- than 1000
-- ============================================================

SELECT
    c.category_id,
    c.category_name,
    ROUND(AVG(p.price), 2) AS average_price
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
GROUP BY
    c.category_id,
    c.category_name
HAVING AVG(p.price) > 1000
ORDER BY average_price DESC;


-- ============================================================
-- Query 22
-- Calculate how much each customer has spent
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC;


-- ============================================================
-- Query 23
-- Display customers whose total spending is greater than 5000
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING SUM(o.total_amount) > 5000
ORDER BY total_spent DESC;


-- ============================================================
-- Query 24
-- Find products that have been ordered more than five times
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    COUNT(oi.order_id) AS times_ordered
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING COUNT(oi.order_id) > 5
ORDER BY times_ordered DESC;

-- ============================================================
-- PART 6: SQL JOINS
-- ============================================================


-- ============================================================
-- Query 25
-- Display order_id, customer_name, order_date,
-- order_status and total_amount for every order
-- ============================================================

SELECT
    o.order_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    o.order_date,
    o.order_status,
    o.total_amount
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
ORDER BY o.order_id;


-- ============================================================
-- Query 26
-- Display order details along with customer and product
-- information
-- ============================================================

SELECT
    o.order_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
ORDER BY o.order_id, oi.order_item_id;


-- ============================================================
-- Query 27
-- Display products with their category names
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
ORDER BY p.product_id;


-- ============================================================
-- Query 28
-- Display all customers and their orders,
-- including customers who have never placed an order
-- ============================================================

SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    o.order_id,
    o.order_date,
    o.order_status,
    o.total_amount
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date DESC;


-- ============================================================
-- Query 29
-- Find customers who have never placed an order
-- using LEFT JOIN and NULL
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id;


-- ============================================================
-- Query 30
-- Find products that have never been ordered
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    p.price,
    p.stock_quantity
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL
ORDER BY p.product_id;


-- ============================================================
-- Query 31
-- Demonstrate RIGHT JOIN
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    oi.order_id,
    oi.quantity
FROM order_items oi
RIGHT JOIN products p
    ON oi.product_id = p.product_id
ORDER BY p.product_id, oi.order_id;


-- RIGHT JOIN explanation:
--
-- RIGHT JOIN keeps every row from the right-side table.
-- Here, products is the right-side table.
-- Therefore, even products that have never been ordered
-- will appear in the result.
--
-- INNER JOIN would return only products that have a
-- matching record in order_items.


-- ============================================================
-- Query 32
-- Demonstrate FULL OUTER JOIN between customers and orders
-- ============================================================

SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    o.order_id,
    o.order_date
FROM customers c
FULL OUTER JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY
    c.customer_id NULLS LAST,
    o.order_id NULLS LAST;


-- FULL OUTER JOIN explanation:
--
-- FULL OUTER JOIN returns:
-- 1. Matching rows from both tables
-- 2. Customers without orders
-- 3. Orders without matching customers
--
-- Because orders.customer_id has a foreign key referencing
-- customers, unmatched orders should normally not exist
-- in our database.


-- ============================================================
-- Query 33
-- SELF JOIN on categories
-- Display child category and parent category
-- ============================================================

SELECT
    child.category_name AS child_category,
    parent.category_name AS parent_category
FROM categories child
INNER JOIN categories parent
    ON child.parent_category_id = parent.category_id
ORDER BY
    parent.category_name,
    child.category_name;
  
-- ============================================================
-- Query 34
-- Find products whose price is greater than
-- the average price of all products
-- ============================================================

SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
)
ORDER BY price DESC;


-- ============================================================
-- Query 35
-- Find customers whose total order amount is greater than
-- the average order amount
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_amount)
    FROM orders
)
ORDER BY total_spent DESC;


-- ============================================================
-- Query 36
-- Find the most expensive product in each category
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    p.price
FROM products p
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
)
ORDER BY p.category_id;


-- ============================================================
-- Query 37
-- Find customers who have placed at least one order
-- using EXISTS
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
ORDER BY c.customer_id;


-- ============================================================
-- Query 38
-- Find customers who have never placed an order
-- using NOT EXISTS
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
ORDER BY c.customer_id;


-- ============================================================
-- Query 39
-- Find products whose price is greater than every product
-- in the selected category
--
-- Change the category name if required.
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    p.price,
    c.category_name
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
WHERE p.price > ALL (
    SELECT p2.price
    FROM products p2
    INNER JOIN categories c2
        ON p2.category_id = c2.category_id
    WHERE c2.category_name = 'Electronics'
)
ORDER BY p.price DESC;


-- ============================================================
-- Query 40
-- Find products whose price is greater than at least one
-- product from another category using ANY
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    p.price,
    c.category_name
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
WHERE p.price > ANY (
    SELECT p2.price
    FROM products p2
    WHERE p2.category_id <> p.category_id
)
ORDER BY p.price DESC;


-- ============================================================
-- Query 41
-- Find products whose price is greater than the average
-- price of products in the same category
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    p.price
FROM products p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
)
ORDER BY p.category_id, p.price DESC;


-- ============================================================
-- Query 42
-- Find customers whose total spending is greater than
-- the average spending of customers
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    (
        SELECT COALESCE(SUM(o.total_amount), 0)
        FROM orders o
        WHERE o.customer_id = c.customer_id
    ) AS total_spent
FROM customers c
WHERE (
    SELECT COALESCE(SUM(o.total_amount), 0)
    FROM orders o
    WHERE o.customer_id = c.customer_id
) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            c2.customer_id,
            COALESCE(SUM(o2.total_amount), 0) AS customer_total
        FROM customers c2
        LEFT JOIN orders o2
            ON c2.customer_id = o2.customer_id
        GROUP BY c2.customer_id
    ) AS customer_spending
)
ORDER BY total_spent DESC;


-- ============================================================
-- Query 43
-- Find products that have a higher price than every other
-- product in their own category
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    p.price
FROM products p
WHERE p.price >= ALL (
    SELECT p2.price
    FROM products p2
    WHERE p2.category_id = p.category_id
      AND p2.product_id <> p.product_id
)
ORDER BY p.category_id, p.price DESC;

-- ============================================================
-- Query 44
-- Categorize products based on their price
-- ============================================================

SELECT
    product_id,
    product_name,
    price,
    CASE
        WHEN price >= 2000 THEN 'High Price'
        WHEN price >= 1000 THEN 'Medium Price'
        ELSE 'Low Price'
    END AS price_category
FROM products
ORDER BY price DESC;


-- ============================================================
-- Query 45
-- Categorize customers based on their total spending
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    CASE
        WHEN COALESCE(SUM(o.total_amount), 0) >= 10000
            THEN 'VIP Customer'
        WHEN COALESCE(SUM(o.total_amount), 0) >= 5000
            THEN 'Regular Customer'
        ELSE 'Low Spending Customer'
    END AS customer_category
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC;


-- ============================================================
-- Query 46
-- Categorize orders based on their order status
-- ============================================================

SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    total_amount,
    CASE
        WHEN order_status = 'Delivered'
            THEN 'Completed Order'
        WHEN order_status = 'Cancelled'
            THEN 'Cancelled Order'
        WHEN order_status IN ('Pending', 'Processing', 'Shipped')
            THEN 'Order In Progress'
        ELSE 'Other'
    END AS order_category
FROM orders
ORDER BY order_id;

-- ============================================================
-- PART 10: COMMON TABLE EXPRESSIONS (CTEs)
-- ============================================================


-- ============================================================
-- Query 47
-- Create a CTE that calculates total spending for every customer
-- Display only customers who have spent more than 5000
-- ============================================================

WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        COALESCE(SUM(o.total_amount), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)
SELECT
    customer_id,
    first_name,
    last_name,
    total_spent
FROM customer_spending
WHERE total_spent > 5000
ORDER BY total_spent DESC;


-- ============================================================
-- Query 48
-- Create a CTE to calculate total sales for each product
-- Display the ten highest-selling products
-- ============================================================

WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold
    FROM products p
    LEFT JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.product_id,
        p.product_name
)
SELECT
    product_id,
    product_name,
    total_quantity_sold
FROM product_sales
ORDER BY total_quantity_sold DESC
LIMIT 10;


-- ============================================================
-- Query 49
-- Create multiple CTEs in one query
-- and use them in the final query
-- ============================================================

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
customer_orders AS (
    SELECT
        customer_id,
        COUNT(order_id) AS total_orders
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(cs.total_spent, 0) AS total_spent,
    COALESCE(co.total_orders, 0) AS total_orders
FROM customers c
LEFT JOIN customer_spending cs
    ON c.customer_id = cs.customer_id
LEFT JOIN customer_orders co
    ON c.customer_id = co.customer_id
ORDER BY total_spent DESC;


-- ============================================================
-- Query 50
-- Use a CTE to find customers whose spending is above
-- the overall average customer spending
-- ============================================================

WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        COALESCE(SUM(o.total_amount), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
),
average_spending AS (
    SELECT
        AVG(total_spent) AS average_customer_spending
    FROM customer_spending
)
SELECT
    cs.customer_id,
    cs.first_name,
    cs.last_name,
    cs.total_spent
FROM customer_spending cs
CROSS JOIN average_spending av
WHERE cs.total_spent > av.average_customer_spending
ORDER BY cs.total_spent DESC;

-- ============================================================
-- Query 51
-- Display the complete category hierarchy
-- using a recursive CTE
-- ============================================================

WITH RECURSIVE category_hierarchy AS (
    -- Root categories
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS level
    FROM categories
    WHERE parent_category_id IS NULL

    UNION ALL

    -- Child categories
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ch.level + 1
    FROM categories c
    INNER JOIN category_hierarchy ch
        ON c.parent_category_id = ch.category_id
)
SELECT
    category_id,
    category_name,
    parent_category_id,
    level
FROM category_hierarchy
ORDER BY level, category_id;


-- ============================================================
-- Query 52
-- Display the category hierarchy using indentation
-- ============================================================

WITH RECURSIVE category_hierarchy AS (
    -- Root categories
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS level
    FROM categories
    WHERE parent_category_id IS NULL

    UNION ALL

    -- Child categories
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ch.level + 1
    FROM categories c
    INNER JOIN category_hierarchy ch
        ON c.parent_category_id = ch.category_id
)
SELECT
    category_id,
    REPEAT('    ', level) || category_name AS category_hierarchy,
    level
FROM category_hierarchy
ORDER BY category_id;

-- ============================================================
-- Query 53
-- Create a view that displays customer order information
-- ============================================================

CREATE OR REPLACE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name;


-- ============================================================
-- Query 54
-- Create a view that displays product sales information
-- ============================================================

CREATE OR REPLACE VIEW product_sales_summary AS
SELECT
    p.product_id,
    p.product_name,
    COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_revenue
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name;


-- ============================================================
-- Query 55
-- Create a view that displays category revenue
-- ============================================================

CREATE OR REPLACE VIEW category_revenue_summary AS
SELECT
    c.category_id,
    c.category_name,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_revenue
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    c.category_id,
    c.category_name;


-- ============================================================
-- Query 56
-- Query the customer order summary view
-- ============================================================

SELECT *
FROM customer_order_summary
ORDER BY total_spent DESC;


-- ============================================================
-- Query 57
-- Query the product sales and category revenue views
-- ============================================================

SELECT *
FROM product_sales_summary
ORDER BY total_revenue DESC;


SELECT *
FROM category_revenue_summary
ORDER BY total_revenue DESC;

-- ============================================================
-- PART 13: MATERIALIZED VIEWS
-- ============================================================

-- Query 58
-- Create a materialized view for monthly sales summary

CREATE MATERIALIZED VIEW monthly_sales_summary AS
SELECT
    EXTRACT(YEAR FROM order_date)::INT AS sales_year,
    EXTRACT(MONTH FROM order_date)::INT AS sales_month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS monthly_revenue
FROM orders
WHERE order_status <> 'Cancelled'
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY
    sales_year,
    sales_month;


-- Query 59
-- Display monthly revenue from the materialized view

SELECT
    sales_year,
    sales_month,
    total_orders,
    monthly_revenue
FROM monthly_sales_summary
ORDER BY
    sales_year,
    sales_month;

    -- ============================================================
-- Query 60
-- Add a new order and check the materialized view
-- ============================================================

INSERT INTO orders (
    customer_id,
    order_date,
    order_status,
    shipping_city,
    shipping_country,
    total_amount
)
VALUES (
    1,
    CURRENT_TIMESTAMP,
    'Delivered',
    'Chennai',
    'India',
    3500.00
);

-- Query the materialized view again
SELECT
    sales_year,
    sales_month,
    total_orders,
    monthly_revenue
FROM monthly_sales_summary
ORDER BY
    sales_year,
    sales_month;


-- Explanation:
-- The newly inserted order may not immediately appear
-- in the materialized view because a materialized view
-- stores a physical copy of the query result.
--
-- Changes made to the underlying tables are not automatically
-- reflected in the stored result.


-- ============================================================
-- Query 61
-- Refresh the materialized view
-- ============================================================

REFRESH MATERIALIZED VIEW monthly_sales_summary;

-- Verify that the new order is now included
SELECT
    sales_year,
    sales_month,
    total_orders,
    monthly_revenue
FROM monthly_sales_summary
ORDER BY
    sales_year,
    sales_month;


-- ============================================================
-- Query 62
-- VIEW vs MATERIALIZED VIEW
-- ============================================================

-- VIEW:
-- A VIEW stores the SQL query definition, not the actual
-- result data.
--
-- When a VIEW is queried, PostgreSQL executes the underlying
-- query using the current table data.
--
-- Therefore, changes in the underlying tables are normally
-- visible immediately.


-- MATERIALIZED VIEW:
-- A MATERIALIZED VIEW stores the result of the query
-- physically.
--
-- It can provide faster access for complex reporting queries
-- because the result is already stored.
--
-- However, changes in the underlying tables are not reflected
-- automatically.
--
-- The materialized view must be refreshed to obtain updated data.


-- Main differences:
--
-- VIEW:
--   * Does not physically store query results
--   * Always uses current underlying data
--   * Usually slower for complex repeated queries
--   * No manual refresh required
--
-- MATERIALIZED VIEW:
--   * Physically stores query results
--   * Can be faster for reporting
--   * Data can become stale
--   * Requires REFRESH MATERIALIZED VIEW

-- ============================================================
-- PART 14: INDEXES
-- ============================================================

-- Query 63
-- Create an index on customers.email

CREATE INDEX idx_customers_email
ON customers(email);


-- Query 64
-- Create an index on orders.customer_id

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);


-- Query 65
-- Create an index on orders.order_date

CREATE INDEX idx_orders_order_date
ON orders(order_date);

-- ============================================================
-- PART 14: INDEXES & QUERY OPTIMIZATION
-- ============================================================


-- ============================================================
-- Query 66
-- Composite index on order_status and order_date
-- ============================================================

CREATE INDEX idx_orders_status_date
ON orders(order_status, order_date);


-- ============================================================
-- Query 67
-- Index products by category and price
-- ============================================================

CREATE INDEX idx_products_category_price
ON products(category_id, price);


-- ============================================================
-- Query 68
-- Analyze query performance using EXPLAIN ANALYZE
-- ============================================================

EXPLAIN ANALYZE
SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    total_amount
FROM orders
WHERE order_status = 'Delivered'
ORDER BY order_date DESC;

-- ============================================================
-- Query 69
-- Remove an index and explain when it is appropriate
-- ============================================================

DROP INDEX IF EXISTS idx_orders_order_date;

-- An index may be removed when:
-- 1. It is no longer used by queries.
-- 2. It provides little performance benefit.
-- 3. It consumes unnecessary storage.
-- 4. It increases INSERT, UPDATE, or DELETE overhead.
-- 5. Another index already provides the required access path.


-- ============================================================
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
        RAISE EXCEPTION 'Product with ID % does not exist', p_product_id;
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
-- Increase stock by 10
-- CALL update_product_stock(1, 10);

-- Decrease stock by 5
-- CALL update_product_stock(1, -5);


-- ============================================================
-- Query 71
-- Procedure to cancel an order and restore stock
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
        RAISE EXCEPTION 'Order with ID % does not exist', p_order_id;
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

    -- Restore products to stock
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
-- Procedure to mark old Processing orders as Delayed
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
      AND order_date < CURRENT_TIMESTAMP - (p_days * INTERVAL '1 day');
END;
$$;


-- Example:
-- Mark Processing orders older than 7 days as delayed
-- CALL mark_delayed_orders(7);
-- ============================================================
-- PART 16: USER-DEFINED FUNCTIONS
-- ============================================================


-- ============================================================
-- Query 74
-- Calculate total value of an order
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
-- Count orders placed by a customer
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
-- Calculate average rating of a product
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
    SELECT COALESCE(ROUND(AVG(rating), 2), 0)
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
-- Use functions inside normal SQL queries
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    customer_total_spending(c.customer_id) AS total_spent,
    get_customer_order_count(c.customer_id) AS total_orders
FROM customers c
ORDER BY total_spent DESC;
-- ============================================================
-- PART 18: WINDOW FUNCTIONS
-- ============================================================


-- ============================================================
-- Query 79
-- Rank products according to price
-- ============================================================

SELECT
    product_id,
    product_name,
    price,
    RANK() OVER (
        ORDER BY price DESC
    ) AS price_rank
FROM products
ORDER BY price_rank, product_id;


-- ============================================================
-- Query 80
-- Rank products within each category according to price
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    RANK() OVER (
        PARTITION BY p.category_id
        ORDER BY p.price DESC
    ) AS category_price_rank
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
ORDER BY
    c.category_name,
    category_price_rank;


-- ============================================================
-- Query 81
-- Top three most expensive products in every category
-- ============================================================

WITH ranked_products AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category_id,
        c.category_name,
        p.price,
        RANK() OVER (
            PARTITION BY p.category_id
            ORDER BY p.price DESC
        ) AS price_rank
    FROM products p
    INNER JOIN categories c
        ON p.category_id = c.category_id
)
SELECT
    product_id,
    product_name,
    category_name,
    price,
    price_rank
FROM ranked_products
WHERE price_rank <= 3
ORDER BY
    category_name,
    price_rank;


-- ============================================================
-- Query 82
-- Running total of sales ordered by date
-- ============================================================

SELECT
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_sales
FROM orders
WHERE order_status <> 'Cancelled'
ORDER BY
    order_date,
    order_id;


-- ============================================================
-- Query 83
-- Assign a unique number to every customer order
-- ============================================================

SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS customer_order_number
FROM orders
ORDER BY
    customer_id,
    customer_order_number;


-- ============================================================
-- Query 84
-- Compare each order with the customer's previous order
-- ============================================================

SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS previous_order_amount,

    total_amount
    - LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS difference_from_previous_order

FROM orders
ORDER BY
    customer_id,
    order_date,
    order_id;

    -- ============================================================
-- PART 19: DATE AND TIME QUERIES
-- ============================================================


-- ============================================================
-- Query 85
-- Find all orders placed today
-- ============================================================

SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    total_amount
FROM orders
WHERE order_date::DATE = CURRENT_DATE
ORDER BY order_date DESC;


-- ============================================================
-- Query 86
-- Find all orders placed during the current month
-- ============================================================

SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    total_amount
FROM orders
WHERE order_date >= DATE_TRUNC('month', CURRENT_DATE)
  AND order_date < DATE_TRUNC('month', CURRENT_DATE)
                         + INTERVAL '1 month'
ORDER BY order_date DESC;


-- ============================================================
-- Query 87
-- Calculate monthly revenue
-- ============================================================

SELECT
    DATE_TRUNC('month', order_date)::DATE AS sales_month,
    SUM(total_amount) AS monthly_revenue
FROM orders
WHERE order_status <> 'Cancelled'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;


-- ============================================================
-- Query 88
-- Customers who have not placed an order
-- in the last six months
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.order_date >= CURRENT_TIMESTAMP - INTERVAL '6 months'
)
ORDER BY c.customer_id;


-- ============================================================
-- Query 89
-- Number of days between registration date
-- and customer's first order date
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.registration_date,
    MIN(o.order_date)::DATE AS first_order_date,
    MIN(o.order_date)::DATE - c.registration_date
        AS days_to_first_order
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.registration_date
ORDER BY c.customer_id;

-- ============================================================
-- PART 20: STRING FUNCTIONS
-- ============================================================


-- ============================================================
-- Query 90
-- Display each customer's complete name
-- ============================================================

SELECT
    customer_id,
    first_name || ' ' || last_name AS complete_name
FROM customers
ORDER BY customer_id;


-- ============================================================
-- Query 91
-- Display all customer emails in lowercase
-- ============================================================

SELECT
    customer_id,
    LOWER(email) AS lowercase_email
FROM customers
ORDER BY customer_id;


-- ============================================================
-- Query 92
-- Display product names in uppercase
-- ============================================================

SELECT
    product_id,
    UPPER(product_name) AS uppercase_product_name
FROM products
ORDER BY product_id;


-- ============================================================
-- Query 93
-- Find the length of every product name
-- ============================================================

SELECT
    product_id,
    product_name,
    LENGTH(product_name) AS product_name_length
FROM products
ORDER BY product_name_length DESC;


-- ============================================================
-- Query 94
-- Extract the domain name from customer email addresses
-- ============================================================

SELECT
    customer_id,
    email,
    SPLIT_PART(email, '@', 2) AS email_domain
FROM customers
ORDER BY customer_id;
-- ============================================================
-- PART 21: NULL HANDLING
-- ============================================================


-- ============================================================
-- Query 95
-- Find customers with no phone number
-- ============================================================

SELECT
    customer_id,
    first_name,
    last_name,
    email,
    phone
FROM customers
WHERE phone IS NULL
ORDER BY customer_id;


-- ============================================================
-- Query 96
-- Display "Not Available" when phone number is NULL
-- ============================================================

SELECT
    customer_id,
    first_name,
    last_name,
    email,
    COALESCE(phone, 'Not Available') AS phone
FROM customers
ORDER BY customer_id;


-- ============================================================
-- Query 97
-- Find products that have never received a review
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    p.price
FROM products p
LEFT JOIN reviews r
    ON p.product_id = r.product_id
WHERE r.review_id IS NULL
ORDER BY p.product_id;
-- ============================================================
-- PART 22: SET OPERATIONS
-- ============================================================


-- ============================================================
-- Query 98
-- UNION: Combine customer cities and shipping cities
-- into one unique list
-- ============================================================

SELECT city AS location
FROM customers

UNION

SELECT shipping_city AS location
FROM orders

ORDER BY location;


-- ============================================================
-- Query 99
-- UNION ALL: Combine customer cities and shipping cities
-- including duplicates
-- ============================================================

SELECT city AS location
FROM customers

UNION ALL

SELECT shipping_city AS location
FROM orders

ORDER BY location;


-- Difference:
-- UNION removes duplicate values.
-- UNION ALL keeps duplicate values.
--
-- UNION:
-- Chennai
-- Bangalore
-- Mumbai
--
-- UNION ALL:
-- Chennai
-- Chennai
-- Bangalore
-- Mumbai
-- Mumbai


-- ============================================================
-- Query 100
-- INTERSECT: Find cities appearing in both
-- customer and shipping addresses
-- ============================================================

SELECT city AS location
FROM customers

INTERSECT

SELECT shipping_city AS location
FROM orders

ORDER BY location;


-- ============================================================
-- Query 101
-- EXCEPT: Find customer cities that never appeared
-- as shipping cities
-- ============================================================

SELECT city AS location
FROM customers

EXCEPT

SELECT shipping_city AS location
FROM orders

ORDER BY location;
-- ============================================================
-- PART 23: TRANSACTIONS
-- ============================================================


-- ============================================================
-- Task 102
-- Demonstrate a successful transaction
-- ============================================================

BEGIN;

-- Step 1: Create a new order
INSERT INTO orders (
    customer_id,
    order_date,
    order_status,
    shipping_city,
    shipping_country,
    total_amount
)
VALUES (
    1,
    CURRENT_TIMESTAMP,
    'Processing',
    'Chennai',
    'India',
    2500.00
);

-- Step 2: Insert order item
-- currval() gets the order_id generated above
INSERT INTO order_items (
    order_id,
    product_id,
    quantity,
    unit_price,
    discount
)
VALUES (
    currval('orders_order_id_seq'),
    1,
    1,
    2500.00,
    0
);

-- Step 3: Reduce product stock
UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 1
  AND stock_quantity >= 1;

-- Step 4: Insert payment information
INSERT INTO payments (
    order_id,
    payment_date,
    payment_method,
    payment_status,
    amount,
    transaction_reference
)
VALUES (
    currval('orders_order_id_seq'),
    CURRENT_TIMESTAMP,
    'UPI',
    'Completed',
    2500.00,
    'TXN_SUCCESS_102'
);

-- Step 5: Commit everything
COMMIT;


-- Verify the successful transaction

SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.total_amount,
    p.payment_status,
    p.amount
FROM orders o
LEFT JOIN payments p
    ON o.order_id = p.order_id
WHERE o.order_id = currval('orders_order_id_seq');


-- ============================================================
-- Task 103
-- Demonstrate a failed transaction and ROLLBACK
-- ============================================================

BEGIN;

-- Try to reduce stock below zero.
-- The CHECK constraint on stock_quantity should
-- cause this statement to fail.

UPDATE products
SET stock_quantity = stock_quantity - 100000
WHERE product_id = 1;

-- Because the previous statement fails, the transaction
-- is rolled back.

ROLLBACK;


-- Verify that the transaction was rolled back

SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE product_id = 1;


-- ============================================================
-- Why transactions are important
-- ============================================================

-- Transactions ensure that related e-commerce operations
-- are treated as one logical unit.
--
-- For example, placing an order involves:
--
-- 1. Creating the order
-- 2. Adding order items
-- 3. Reducing product stock
-- 4. Recording payment
--
-- If one operation fails, ROLLBACK prevents partial changes.
--
-- If everything succeeds, COMMIT permanently saves
-- all the changes.
--
-- This helps maintain data consistency and prevents
-- problems such as an order being created without
-- a corresponding payment or stock update.

-- ============================================================
-- PART 24: ADVANCED BUSINESS QUERIES
-- ============================================================


-- ============================================================
-- Query 104
-- Top five customers by total spending
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(SUM(o.total_amount), 0) AS total_spending
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
   AND o.order_status <> 'Cancelled'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spending DESC
LIMIT 5;


-- ============================================================
-- Query 105
-- Top five best-selling products based on quantity sold
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    COALESCE(SUM(oi.quantity), 0) AS quantity_sold
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY quantity_sold DESC
LIMIT 5;


-- ============================================================
-- Query 106
-- Top five products based on total revenue
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    COALESCE(
        SUM(
            oi.quantity
            * oi.unit_price
            * (1 - oi.discount / 100)
        ),
        0
    ) AS total_revenue
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC
LIMIT 5;


-- ============================================================
-- Query 107
-- Category generating the most revenue
-- ============================================================

SELECT
    c.category_id,
    c.category_name,
    COALESCE(
        SUM(
            oi.quantity
            * oi.unit_price
            * (1 - oi.discount / 100)
        ),
        0
    ) AS total_revenue
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY total_revenue DESC
LIMIT 1;


-- ============================================================
-- Query 108
-- Customers who have ordered more than five
-- different products
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT oi.product_id) AS different_products_ordered
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(DISTINCT oi.product_id) > 5
ORDER BY different_products_ordered DESC;

-- ============================================================
-- Query 109
-- Products ordered by more than ten different customers
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    COUNT(DISTINCT o.customer_id) AS different_customers
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
INNER JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    p.product_id,
    p.product_name
HAVING COUNT(DISTINCT o.customer_id) > 10
ORDER BY different_customers DESC;


-- ============================================================
-- Query 110
-- Customers who bought products from at least
-- three different categories
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT p.category_id) AS different_categories
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(DISTINCT p.category_id) >= 3
ORDER BY different_categories DESC;


-- ============================================================
-- Query 111
-- Most popular product in every category
-- ============================================================

WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category_id,
        c.category_name,
        COALESCE(SUM(oi.quantity), 0) AS quantity_sold
    FROM products p
    INNER JOIN categories c
        ON p.category_id = c.category_id
    LEFT JOIN order_items oi
        ON p.product_id = oi.product_id
    LEFT JOIN orders o
        ON oi.order_id = o.order_id
       AND o.order_status <> 'Cancelled'
    GROUP BY
        p.product_id,
        p.product_name,
        p.category_id,
        c.category_name
),
ranked_products AS (
    SELECT
        product_id,
        product_name,
        category_id,
        category_name,
        quantity_sold,
        RANK() OVER (
            PARTITION BY category_id
            ORDER BY quantity_sold DESC
        ) AS product_rank
    FROM product_sales
)
SELECT
    product_id,
    product_name,
    category_name,
    quantity_sold,
    product_rank
FROM ranked_products
WHERE product_rank = 1
ORDER BY
    category_name,
    product_id;


-- ============================================================
-- Query 112
-- Customers who purchased the same product
-- more than once
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    p.product_id,
    p.product_name,
    COUNT(*) AS purchase_count
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    p.product_id,
    p.product_name
HAVING COUNT(*) > 1
ORDER BY
    c.customer_id,
    purchase_count DESC;


-- ============================================================
-- Query 113
-- Customers whose total spending is above
-- the average customer spending
-- ============================================================

WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        COALESCE(
            SUM(
                CASE
                    WHEN o.order_status <> 'Cancelled'
                    THEN o.total_amount
                    ELSE 0
                END
            ),
            0
        ) AS total_spending
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
),
average_spending AS (
    SELECT
        AVG(total_spending) AS average_customer_spending
    FROM customer_spending
)
SELECT
    cs.customer_id,
    cs.first_name,
    cs.last_name,
    cs.total_spending
FROM customer_spending cs
CROSS JOIN average_spending av
WHERE cs.total_spending > av.average_customer_spending
ORDER BY cs.total_spending DESC;

-- ============================================================
-- Query 114
-- Find the second-highest priced product
-- Using:
-- 1. Subquery
-- 2. Window function
-- ============================================================


-- Method 1: Using a subquery

SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE price < (
        SELECT MAX(price)
        FROM products
    )
)
ORDER BY product_id;


-- Method 2: Using a window function

WITH ranked_products AS (
    SELECT
        product_id,
        product_name,
        price,
        DENSE_RANK() OVER (
            ORDER BY price DESC
        ) AS price_rank
    FROM products
)
SELECT
    product_id,
    product_name,
    price
FROM ranked_products
WHERE price_rank = 2
ORDER BY product_id;


-- ============================================================
-- Query 115
-- Find the third-highest spending customer
-- ============================================================

WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        COALESCE(
            SUM(
                CASE
                    WHEN o.order_status <> 'Cancelled'
                    THEN o.total_amount
                    ELSE 0
                END
            ),
            0
        ) AS total_spending
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
),
ranked_customers AS (
    SELECT
        customer_id,
        first_name,
        last_name,
        total_spending,
        DENSE_RANK() OVER (
            ORDER BY total_spending DESC
        ) AS spending_rank
    FROM customer_spending
)
SELECT
    customer_id,
    first_name,
    last_name,
    total_spending
FROM ranked_customers
WHERE spending_rank = 3
ORDER BY customer_id;


-- ============================================================
-- Query 116
-- Find the month with the highest revenue
-- ============================================================

SELECT
    DATE_TRUNC('month', order_date)::DATE AS sales_month,
    SUM(total_amount) AS total_revenue
FROM orders
WHERE order_status <> 'Cancelled'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY total_revenue DESC
LIMIT 1;


-- ============================================================
-- Query 117
-- Product with the highest average review rating
-- Only products having at least three reviews
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.review_id) AS review_count
FROM products p
INNER JOIN reviews r
    ON p.product_id = r.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING COUNT(r.review_id) >= 3
ORDER BY
    average_rating DESC,
    review_count DESC
LIMIT 1;


-- ============================================================
-- Query 118
-- Customers who placed orders but never submitted
-- a review
-- ============================================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
)
AND NOT EXISTS (
    SELECT 1
    FROM reviews r
    WHERE r.customer_id = c.customer_id
)
ORDER BY c.customer_id;


-- ============================================================
-- Query 119
-- Products that are low in stock but have high sales
--
-- Low stock  = fewer than 10 units
-- High sales = more than 20 units sold
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    p.stock_quantity,
    COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.stock_quantity
HAVING
    p.stock_quantity < 10
    AND COALESCE(SUM(oi.quantity), 0) > 20
ORDER BY total_quantity_sold DESC;


-- ============================================================
-- Query 120
-- Customers whose latest order was cancelled
-- ============================================================

WITH latest_orders AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        o.order_status,
        ROW_NUMBER() OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date DESC, o.order_id DESC
        ) AS order_rank
    FROM orders o
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    lo.order_id AS latest_order_id,
    lo.order_date AS latest_order_date,
    lo.order_status
FROM customers c
INNER JOIN latest_orders lo
    ON c.customer_id = lo.customer_id
WHERE lo.order_rank = 1
  AND lo.order_status = 'Cancelled'
ORDER BY c.customer_id;

-- ============================================================
-- PART 25: PERFORMANCE OPTIMIZATION CASE STUDY
-- ============================================================

-- The frequently executed query filters by:
-- customer_id
-- order_status
-- order_date
--
-- A composite index is appropriate for this query.

CREATE INDEX idx_orders_customer_status_date
ON orders(customer_id, order_status, order_date);


-- ============================================================
-- Inspect the query using EXPLAIN ANALYZE
-- ============================================================

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 500
  AND order_status = 'Delivered'
  AND order_date >= '2026-01-01';

  -- ============================================================
-- PART 26: VIEW VS MATERIALIZED VIEW CASE STUDY
-- ============================================================

-- Query 121
-- Create a materialized view for the executive dashboard.
-- A materialized view is suitable because the dashboard
-- is accessed frequently but only needs hourly updates.

CREATE MATERIALIZED VIEW executive_sales_dashboard AS
SELECT
    DATE_TRUNC('month', o.order_date)::DATE AS sales_month,
    SUM(o.total_amount) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    COALESCE(SUM(oi.quantity), 0) AS total_products_sold,
    AVG(o.total_amount) AS average_order_value
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY sales_month;


-- Query 122
-- Display the dashboard data

SELECT
    sales_month,
    total_revenue,
    total_orders,
    total_customers,
    total_products_sold,
    average_order_value
FROM executive_sales_dashboard
ORDER BY sales_month;


-- Query 123
-- Refresh the materialized view.
-- In the real system, this can be scheduled once every hour.

REFRESH MATERIALIZED VIEW executive_sales_dashboard;


-- Query 124
-- Display the refreshed dashboard

SELECT *
FROM executive_sales_dashboard
ORDER BY sales_month;

-- ============================================================
-- PART 27: FINAL INTEGRATED CHALLENGE
-- CUSTOMER PERFORMANCE REPORT
-- ============================================================

-- Query 125
-- Create Customer Performance Report as a query

WITH customer_metrics AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        c.city,
        c.registration_date,

        COUNT(o.order_id) AS total_orders,

        COUNT(
            CASE
                WHEN o.order_status = 'Delivered'
                THEN 1
            END
        ) AS completed_orders,

        COUNT(
            CASE
                WHEN o.order_status = 'Cancelled'
                THEN 1
            END
        ) AS cancelled_orders,

        COALESCE(
            SUM(
                CASE
                    WHEN o.order_status <> 'Cancelled'
                    THEN oi.quantity
                    ELSE 0
                END
            ),
            0
        ) AS total_products_purchased,

        COALESCE(
            SUM(
                CASE
                    WHEN o.order_status <> 'Cancelled'
                    THEN o.total_amount
                    ELSE 0
                END
            ),
            0
        ) AS total_spent,

        COALESCE(
            AVG(
                CASE
                    WHEN o.order_status <> 'Cancelled'
                    THEN o.total_amount
                END
            ),
            0
        ) AS average_order_value,

        MAX(o.order_date) AS last_order_date

    FROM customers c

    LEFT JOIN orders o
        ON c.customer_id = o.customer_id

    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id

    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name,
        c.city,
        c.registration_date
),

ranked_customers AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY total_spent DESC
        ) AS customer_rank
    FROM customer_metrics
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
    average_order_value,
    last_order_date,
    customer_rank,

    CASE
        WHEN total_spent >= 20000 THEN 'Platinum'
        WHEN total_spent >= 10000 THEN 'Gold'
        WHEN total_spent >= 5000 THEN 'Silver'
        ELSE 'Regular'
    END AS customer_category

FROM ranked_customers

ORDER BY customer_rank, customer_id;

-- ============================================================
-- PART 28: FINAL MATERIALIZED VIEW CHALLENGE
-- ============================================================

-- Query 128
-- Create the Executive Sales Dashboard

CREATE MATERIALIZED VIEW executive_sales_dashboard AS
SELECT
    DATE_TRUNC('month', o.order_date)::DATE AS sales_month,

    SUM(o.total_amount) AS total_revenue,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COUNT(DISTINCT o.customer_id) AS total_customers,

    COALESCE(SUM(oi.quantity), 0) AS total_products_sold,

    AVG(o.total_amount) AS average_order_value

FROM orders o

LEFT JOIN order_items oi
    ON o.order_id = oi.order_id

WHERE o.order_status <> 'Cancelled'

GROUP BY DATE_TRUNC('month', o.order_date)

ORDER BY sales_month;


-- ============================================================
-- Query 129
-- Create index for filtering by month
-- ============================================================

CREATE INDEX idx_executive_sales_dashboard_month
ON executive_sales_dashboard(sales_month);


-- ============================================================
-- Query 130
-- Display Executive Sales Dashboard
-- ============================================================

SELECT
    sales_month,
    total_revenue,
    total_orders,
    total_customers,
    total_products_sold,
    average_order_value
FROM executive_sales_dashboard
ORDER BY sales_month;


-- ============================================================
-- Query 131
-- Refresh the materialized view
-- ============================================================

REFRESH MATERIALIZED VIEW executive_sales_dashboard;


-- ============================================================
-- Query 132
-- Display the refreshed dashboard
-- ============================================================

SELECT *
FROM executive_sales_dashboard
ORDER BY sales_month;