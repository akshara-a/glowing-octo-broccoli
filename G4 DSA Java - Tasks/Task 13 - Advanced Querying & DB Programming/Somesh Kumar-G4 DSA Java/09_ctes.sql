-- =========================================================
-- TASK 13 - ADVANCED QUERYING & DB PROGRAMMING
-- 09_ctes.sql
-- ShopSphere Database
-- PostgreSQL
-- =========================================================


-- =========================================================
-- QUERY 47 - CUSTOMER SPENDING USING CTE
-- =========================================================

WITH customer_spending AS (

    SELECT
        c.customer_id,

        c.first_name || ' ' || c.last_name
            AS customer_name,

        COALESCE(
            SUM(o.total_amount),
            0
        ) AS total_spent

    FROM customers c

    LEFT JOIN orders o
        ON o.customer_id = c.customer_id

    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)

SELECT *
FROM customer_spending

WHERE total_spent > 5000

ORDER BY total_spent DESC;


-- =========================================================
-- QUERY 48 - TOP 10 PRODUCTS USING CTE
-- =========================================================

WITH product_sales AS (

    SELECT
        p.product_id,

        p.product_name,

        COALESCE(
            SUM(oi.quantity),
            0
        ) AS total_quantity_sold,

        COALESCE(
            ROUND(
                SUM(
                    oi.quantity
                    * oi.unit_price
                    * (1 - oi.discount / 100.0)
                ),
                2
            ),
            0
        ) AS total_sales

    FROM products p

    LEFT JOIN order_items oi
        ON oi.product_id = p.product_id

    GROUP BY
        p.product_id,
        p.product_name
)

SELECT *
FROM product_sales

ORDER BY
    total_quantity_sold DESC,
    total_sales DESC

LIMIT 10;


-- =========================================================
-- QUERY 49 - MULTIPLE CTEs
-- =========================================================

WITH customer_order_summary_cte AS (

    SELECT
        customer_id,

        COUNT(*) AS total_orders,

        SUM(total_amount) AS total_spent

    FROM orders

    GROUP BY customer_id

),

product_sales_summary_cte AS (

    SELECT
        product_id,

        SUM(quantity) AS total_quantity_sold

    FROM order_items

    GROUP BY product_id

)

SELECT

    (
        SELECT COUNT(*)
        FROM customer_order_summary_cte
    ) AS customers_with_orders,

    (
        SELECT COALESCE(SUM(total_spent), 0)
        FROM customer_order_summary_cte
    ) AS total_customer_spending,

    (
        SELECT COUNT(*)
        FROM product_sales_summary_cte
    ) AS products_sold,

    (
        SELECT COALESCE(SUM(total_quantity_sold), 0)
        FROM product_sales_summary_cte
    ) AS total_units_sold;


-- =========================================================
-- QUERY 50 - ABOVE AVERAGE CUSTOMER SPENDING
-- =========================================================

WITH customer_spending AS (

    SELECT
        c.customer_id,

        c.first_name || ' ' || c.last_name
            AS customer_name,

        COALESCE(
            SUM(o.total_amount),
            0
        ) AS total_spent

    FROM customers c

    LEFT JOIN orders o
        ON o.customer_id = c.customer_id

    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)

SELECT
    customer_id,
    customer_name,
    total_spent

FROM customer_spending

WHERE total_spent > (

    SELECT AVG(total_spent)
    FROM customer_spending

)

ORDER BY total_spent DESC;


-- =========================================================
-- QUERY 51 - RECURSIVE CTE FOR CATEGORY HIERARCHY
-- =========================================================

WITH RECURSIVE category_tree AS (

    -- Anchor query:
    -- Find root categories

    SELECT
        c.category_id,

        c.category_name,

        c.parent_category_id,

        NULL::VARCHAR(100)
            AS parent_category,

        0 AS level,

        ARRAY[c.category_id]
            AS path_ids

    FROM categories c

    WHERE c.parent_category_id IS NULL


    UNION ALL


    -- Recursive query:
    -- Find child categories

    SELECT
        child.category_id,

        child.category_name,

        child.parent_category_id,

        parent.category_name
            AS parent_category,

        parent.level + 1
            AS level,

        parent.path_ids || child.category_id
            AS path_ids

    FROM categories child

    JOIN category_tree parent

        ON child.parent_category_id
           = parent.category_id

    -- Prevent accidental cycles
    WHERE NOT child.category_id
          = ANY(parent.path_ids)

)

SELECT
    category_id,
    category_name,
    parent_category_id,
    parent_category,
    level

FROM category_tree

ORDER BY path_ids;


-- =========================================================
-- QUERY 52 - INDENTED CATEGORY HIERARCHY
-- =========================================================

WITH RECURSIVE category_tree AS (

    SELECT
        c.category_id,

        c.category_name,

        c.parent_category_id,

        0 AS level,

        ARRAY[c.category_id]
            AS path_ids

    FROM categories c

    WHERE c.parent_category_id IS NULL


    UNION ALL


    SELECT
        child.category_id,

        child.category_name,

        child.parent_category_id,

        parent.level + 1
            AS level,

        parent.path_ids || child.category_id
            AS path_ids

    FROM categories child

    JOIN category_tree parent

        ON child.parent_category_id
           = parent.category_id

    WHERE NOT child.category_id
          = ANY(parent.path_ids)

)

SELECT

    REPEAT('    ', level)
    || category_name
        AS category_hierarchy,

    level

FROM category_tree

ORDER BY path_ids;


-- =========================================================
-- ADDITIONAL CTE - CUSTOMER ORDER STATISTICS
-- =========================================================

WITH customer_statistics AS (

    SELECT
        c.customer_id,

        c.first_name || ' ' || c.last_name
            AS customer_name,

        COUNT(o.order_id)
            AS total_orders,

        COALESCE(
            SUM(o.total_amount),
            0
        ) AS total_spent,

        COALESCE(
            AVG(o.total_amount),
            0
        ) AS average_order_value

    FROM customers c

    LEFT JOIN orders o
        ON o.customer_id = c.customer_id

    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)

SELECT
    customer_id,
    customer_name,
    total_orders,
    total_spent,
    ROUND(average_order_value, 2)
        AS average_order_value

FROM customer_statistics

ORDER BY total_spent DESC;


-- =========================================================
-- ADDITIONAL CTE - CATEGORY SALES SUMMARY
-- =========================================================

WITH category_sales AS (

    SELECT
        c.category_id,

        c.category_name,

        COALESCE(
            SUM(oi.quantity),
            0
        ) AS total_units_sold,

        COALESCE(
            ROUND(
                SUM(
                    oi.quantity
                    * oi.unit_price
                    * (1 - oi.discount / 100.0)
                ),
                2
            ),
            0
        ) AS total_revenue

    FROM categories c

    LEFT JOIN products p
        ON p.category_id = c.category_id

    LEFT JOIN order_items oi
        ON oi.product_id = p.product_id

    GROUP BY
        c.category_id,
        c.category_name
)

SELECT *
FROM category_sales

ORDER BY total_revenue DESC;


-- =========================================================
-- ADDITIONAL CTE WITH WINDOW FUNCTION
-- =========================================================

WITH customer_spending AS (

    SELECT
        c.customer_id,

        c.first_name || ' ' || c.last_name
            AS customer_name,

        COALESCE(
            SUM(o.total_amount),
            0
        ) AS total_spent

    FROM customers c

    LEFT JOIN orders o
        ON o.customer_id = c.customer_id

    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
),

ranked_customers AS (

    SELECT
        customer_id,
        customer_name,
        total_spent,

        RANK() OVER (
            ORDER BY total_spent DESC
        ) AS spending_rank

    FROM customer_spending
)

SELECT *
FROM ranked_customers

ORDER BY spending_rank;


-- =========================================================
-- CTE EXPLANATION
-- =========================================================

-- CTE stands for Common Table Expression.
--
-- It is created using the WITH keyword.
--
-- Advantages:
--
-- 1. Makes complex SQL queries easier to read.
-- 2. Breaks large queries into smaller logical sections.
-- 3. Can be referenced inside the main query.
-- 4. Multiple CTEs can be used in one SQL statement.
-- 5. Recursive CTEs can process hierarchical data.
--
-- Recursive CTE:
--
-- WITH RECURSIVE is useful for hierarchical relationships
-- such as parent and child categories.
--
-- In ShopSphere, categories.parent_category_id references
-- categories.category_id, so a recursive CTE can be used
-- to display the complete category hierarchy.


-- =========================================================
-- 09_ctes.sql COMPLETE
-- =========================================================