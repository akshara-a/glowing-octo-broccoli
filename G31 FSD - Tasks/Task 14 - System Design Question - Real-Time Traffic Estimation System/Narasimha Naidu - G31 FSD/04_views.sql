-- 04_views.sql

CREATE OR REPLACE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(CASE WHEN o.order_status <> 'Cancelled' THEN o.total_amount ELSE 0 END),0) AS total_spent,
    MAX(o.order_date) AS last_order_date
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

CREATE OR REPLACE VIEW product_sales_summary AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    COALESCE(SUM(CASE WHEN o.order_status <> 'Cancelled' THEN oi.quantity ELSE 0 END),0) AS total_quantity_sold,
    COALESCE(SUM(CASE WHEN o.order_status <> 'Cancelled'
                      THEN oi.quantity * oi.unit_price * (1-oi.discount/100.0)
                      ELSE 0 END),0) AS total_sales
FROM products p
JOIN categories c ON c.category_id = p.category_id
LEFT JOIN order_items oi ON oi.product_id = p.product_id
LEFT JOIN orders o ON o.order_id = oi.order_id
GROUP BY p.product_id, p.product_name, c.category_name;

-- Final integrated customer performance report.
CREATE OR REPLACE VIEW customer_performance_report AS
WITH customer_stats AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        c.city,
        c.registration_date,
        COUNT(o.order_id) FILTER (WHERE o.order_status IS NOT NULL) AS total_orders,
        COUNT(o.order_id) FILTER (WHERE o.order_status = 'Delivered') AS completed_orders,
        COUNT(o.order_id) FILTER (WHERE o.order_status = 'Cancelled') AS cancelled_orders,
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
    customer_id,
    customer_name,
    city,
    registration_date,
    total_orders,
    completed_orders,
    cancelled_orders,
    total_products_purchased,
    ROUND(total_spent,2) AS total_spent,
    ROUND(average_order_value,2) AS average_order_value,
    last_order_date,
    customer_rank,
    CASE
        WHEN total_spent >= 20000 THEN 'Platinum'
        WHEN total_spent >= 10000 THEN 'Gold'
        WHEN total_spent >= 5000 THEN 'Silver'
        ELSE 'Regular'
    END AS customer_category
FROM ranked;

-- View the final report.
SELECT * FROM customer_performance_report
ORDER BY customer_rank, customer_id;
