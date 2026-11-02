-- 09_ctes.sql

-- 47. Customer spending CTE.
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        COALESCE(SUM(CASE WHEN o.order_status <> 'Cancelled'
                          THEN o.total_amount ELSE 0 END),0) AS total_spent
    FROM customers c
    LEFT JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *
FROM customer_spending
WHERE total_spent > 5000
ORDER BY total_spent DESC;


-- 48. Product sales CTE.
WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        COALESCE(SUM(CASE WHEN o.order_status <> 'Cancelled'
                          THEN oi.quantity ELSE 0 END),0) AS units_sold
    FROM products p
    LEFT JOIN order_items oi ON oi.product_id = p.product_id
    LEFT JOIN orders o ON o.order_id = oi.order_id
    GROUP BY p.product_id, p.product_name
)
SELECT *
FROM product_sales
ORDER BY units_sold DESC
LIMIT 10;


-- 49. Multiple CTEs.
WITH customer_order_summary AS (
    SELECT
        customer_id,
        COUNT(*) AS total_orders,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
product_sales_summary AS (
    SELECT
        product_id,
        SUM(quantity) AS quantity_sold,
        SUM(quantity * unit_price * (1-discount/100.0)) AS sales
    FROM order_items
    GROUP BY product_id
)
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    cos.total_orders,
    cos.total_spent
FROM customers c
JOIN customer_order_summary cos
  ON cos.customer_id = c.customer_id
ORDER BY cos.total_spent DESC;


-- 50. Spending above average.
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        COALESCE(SUM(CASE WHEN o.order_status <> 'Cancelled'
                          THEN o.total_amount ELSE 0 END),0) AS total_spent
    FROM customers c
    LEFT JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *
FROM customer_spending
WHERE total_spent > (SELECT AVG(total_spent) FROM customer_spending)
ORDER BY total_spent DESC;


-- 51. Recursive category hierarchy.
WITH RECURSIVE category_tree AS (
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS level,
        category_name::TEXT AS path
    FROM categories
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ct.level + 1,
        (ct.path || ' > ' || c.category_name)::TEXT
    FROM categories c
    JOIN category_tree ct
      ON c.parent_category_id = ct.category_id
)
SELECT *
FROM category_tree
ORDER BY path;


-- 52. Recursive hierarchy with indentation.
WITH RECURSIVE category_tree AS (
    SELECT category_id, category_name, parent_category_id, 0 AS level
    FROM categories
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT c.category_id, c.category_name, c.parent_category_id, ct.level + 1
    FROM categories c
    JOIN category_tree ct ON c.parent_category_id = ct.category_id
)
SELECT REPEAT('    ', level) || category_name AS hierarchy
FROM category_tree
ORDER BY hierarchy;


-- Final integrated CTE report.
WITH customer_stats AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        c.city,
        c.registration_date,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COUNT(DISTINCT o.order_id) FILTER (WHERE o.order_status = 'Delivered') AS completed_orders,
        COUNT(DISTINCT o.order_id) FILTER (WHERE o.order_status = 'Cancelled') AS cancelled_orders,
        COUNT(DISTINCT oi.product_id) FILTER (WHERE o.order_status <> 'Cancelled') AS total_products_purchased,
        COALESCE(SUM(CASE WHEN o.order_status <> 'Cancelled' THEN o.total_amount ELSE 0 END),0) AS total_spent,
        COALESCE(AVG(CASE WHEN o.order_status <> 'Cancelled' THEN o.total_amount END),0) AS average_order_value,
        MAX(o.order_date) AS last_order_date
    FROM customers c
    LEFT JOIN orders o ON o.customer_id = c.customer_id
    LEFT JOIN order_items oi ON oi.order_id = o.order_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.city, c.registration_date
),
ranked AS (
    SELECT *,
           RANK() OVER (ORDER BY total_spent DESC) AS customer_rank
    FROM customer_stats
)
SELECT
    *,
    CASE
        WHEN total_spent >= 20000 THEN 'Platinum'
        WHEN total_spent >= 10000 THEN 'Gold'
        WHEN total_spent >= 5000 THEN 'Silver'
        ELSE 'Regular'
    END AS customer_category
FROM ranked
ORDER BY customer_rank, customer_id;
