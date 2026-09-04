-- ============================================================
-- SHOPSPHERE E-COMMERCE DATABASE
-- FILE: 09_ctes.sql
-- PART 10: COMMON TABLE EXPRESSIONS
-- PART 11: RECURSIVE CTEs
-- ============================================================


-- ============================================================
-- Query 47
-- Customers whose total spending is greater than 5000
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
-- Top 10 products by quantity sold
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
-- Customer spending and order count
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
-- Customers spending above average
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
-- PART 11: RECURSIVE CTEs
-- ============================================================


-- ============================================================
-- Query 51
-- Display category hierarchy with levels
-- ============================================================

WITH RECURSIVE category_hierarchy AS (

    -- Anchor query
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS level
    FROM categories
    WHERE parent_category_id IS NULL

    UNION ALL

    -- Recursive query
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
ORDER BY
    level,
    category_id;


-- ============================================================
-- Query 52
-- Display category hierarchy in tree format
-- ============================================================

WITH RECURSIVE category_hierarchy AS (

    -- Anchor query
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS level
    FROM categories
    WHERE parent_category_id IS NULL

    UNION ALL

    -- Recursive query
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
ORDER BY
    category_id;