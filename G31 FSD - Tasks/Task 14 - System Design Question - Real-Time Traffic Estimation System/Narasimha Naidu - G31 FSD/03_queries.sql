-- 03_queries.sql
-- Queries 1-120 from the assignment.

-- =========================
-- BASIC SQL: 1-10
-- =========================

-- 1. Display all customers.
SELECT * FROM customers;

-- 2. Active customers.
SELECT first_name, last_name, email, city
FROM customers
WHERE status = 'Active';

-- 3. Products costing more than 1000.
SELECT * FROM products WHERE price > 1000;

-- 4. Products priced between 500 and 2000.
SELECT * FROM products WHERE price BETWEEN 500 AND 2000;

-- 5. Customers in three selected cities.
SELECT *
FROM customers
WHERE city IN ('Hyderabad','Mumbai','Chennai');

-- 6. First name starts with A.
SELECT *
FROM customers
WHERE first_name LIKE 'A%';

-- 7. Product name contains Phone.
SELECT *
FROM products
WHERE product_name ILIKE '%Phone%';

-- 8. Orders newest to oldest.
SELECT *
FROM orders
ORDER BY order_date DESC;

-- 9. Five most expensive products.
SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;

-- 10. Products with stock below 10.
SELECT *
FROM products
WHERE stock_quantity < 10;


-- =========================
-- AGGREGATES: 11-18
-- =========================

-- 11.
SELECT COUNT(*) AS total_customers FROM customers;

-- 12.
SELECT COUNT(*) AS total_products FROM products;

-- 13.
SELECT ROUND(AVG(price),2) AS average_product_price FROM products;

-- 14.
SELECT MIN(price) AS cheapest_product_price FROM products;

-- 15.
SELECT MAX(price) AS most_expensive_product_price FROM products;

-- 16.
SELECT ROUND(SUM(total_amount),2) AS total_order_value FROM orders;

-- 17.
SELECT ROUND(AVG(total_amount),2) AS average_order_amount FROM orders;

-- 18.
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- =========================
-- GROUP BY / HAVING: 19-24
-- =========================

-- 19.
SELECT category_id, COUNT(*) AS product_count
FROM products
GROUP BY category_id
ORDER BY category_id;

-- 20.
SELECT category_id, ROUND(AVG(price),2) AS average_price
FROM products
GROUP BY category_id;

-- 21.
SELECT category_id, ROUND(AVG(price),2) AS average_price
FROM products
GROUP BY category_id
HAVING AVG(price) > 1000;

-- 22.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COALESCE(SUM(o.total_amount),0) AS total_spent
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- 23.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COALESCE(SUM(o.total_amount),0) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_amount) > 5000
ORDER BY total_spent DESC;

-- 24. Products ordered more than five times (order-item rows).
SELECT
    p.product_id,
    p.product_name,
    COUNT(DISTINCT oi.order_id) AS number_of_orders
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(DISTINCT oi.order_id) > 5
ORDER BY number_of_orders DESC;


-- =========================
-- JOINS: 25-33
-- =========================

-- 25. INNER JOIN orders and customers.
SELECT
    o.order_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    o.order_date,
    o.order_status,
    o.total_amount
FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.order_id;

-- 26. Four-table join.
SELECT
    o.order_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
ORDER BY o.order_id, p.product_name;

-- 27. Product category join.
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price
FROM products p
JOIN categories c ON c.category_id = p.category_id
ORDER BY p.product_id;

-- 28. All customers and their orders.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_date;

-- 29. Customers with no orders.
SELECT c.*
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

-- 30. Products never ordered.
SELECT p.*
FROM products p
LEFT JOIN order_items oi ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;

-- 31. RIGHT JOIN.
SELECT
    c.customer_id,
    c.first_name,
    o.order_id,
    o.total_amount
FROM customers c
RIGHT JOIN orders o ON o.customer_id = c.customer_id
ORDER BY o.order_id;
-- RIGHT JOIN keeps every row from orders; INNER JOIN keeps only matches.

-- 32. FULL OUTER JOIN.
SELECT
    c.customer_id,
    c.first_name,
    o.order_id,
    o.total_amount
FROM customers c
FULL OUTER JOIN orders o ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_id;
-- Unmatched customers and unmatched orders both appear with NULLs.

-- 33. SELF JOIN categories.
SELECT
    child.category_name AS child_category,
    parent.category_name AS parent_category
FROM categories child
LEFT JOIN categories parent
  ON child.parent_category_id = parent.category_id
ORDER BY child.category_id;


-- =========================
-- SUBQUERIES: 34-40
-- =========================

-- 34.
SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 35.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(o.total_amount) AS total_order_amount
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_amount) > (SELECT AVG(total_amount) FROM orders);

-- 36. Most expensive product in each category.
SELECT p.*
FROM products p
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);

-- 37. Customers with at least one order.
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- 38. Customers with no order.
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

-- 39. Products more expensive than EVERY product in category 8.
SELECT *
FROM products
WHERE price > ALL (
    SELECT price
    FROM products
    WHERE category_id = 8
);

-- 40. Products more expensive than ANY product in category 8.
SELECT *
FROM products
WHERE price > ANY (
    SELECT price
    FROM products
    WHERE category_id = 8
);


-- =========================
-- CORRELATED SUBQUERIES: 41-43
-- =========================

-- 41. Most expensive product in every category.
SELECT p.*
FROM products p
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);

-- 42. Customer spending above average spending in same city.
WITH spending AS (
    SELECT
        c.customer_id,
        c.city,
        COALESCE(SUM(o.total_amount),0) AS total_spending
    FROM customers c
    LEFT JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY c.customer_id, c.city
)
SELECT s.*
FROM spending s
WHERE s.total_spending > (
    SELECT AVG(s2.total_spending)
    FROM spending s2
    WHERE s2.city = s.city
);

-- 43. Products with average rating above category average rating.
SELECT
    p.product_id,
    p.product_name,
    p.category_id,
    (SELECT AVG(r.rating)
     FROM reviews r
     WHERE r.product_id = p.product_id) AS product_avg_rating
FROM products p
WHERE COALESCE((
    SELECT AVG(r.rating)
    FROM reviews r
    WHERE r.product_id = p.product_id
),0) > COALESCE((
    SELECT AVG(r2.rating)
    FROM reviews r2
    JOIN products p2 ON p2.product_id = r2.product_id
    WHERE p2.category_id = p.category_id
),0);


-- =========================
-- CASE: 44-46
-- =========================

-- 44.
SELECT
    product_name,
    price,
    CASE
        WHEN price < 500 THEN 'Budget'
        WHEN price <= 2000 THEN 'Mid Range'
        ELSE 'Premium'
    END AS price_category
FROM products;

-- 45.
SELECT
    product_name,
    stock_quantity,
    CASE
        WHEN stock_quantity = 0 THEN 'Out of Stock'
        WHEN stock_quantity BETWEEN 1 AND 10 THEN 'Low Stock'
        WHEN stock_quantity BETWEEN 11 AND 50 THEN 'Medium Stock'
        ELSE 'High Stock'
    END AS stock_level
FROM products;

-- 46.
SELECT
    order_id,
    order_status,
    CASE order_status
        WHEN 'Pending' THEN 'Awaiting Processing'
        WHEN 'Shipped' THEN 'On the Way'
        WHEN 'Delivered' THEN 'Completed'
        WHEN 'Cancelled' THEN 'Order Cancelled'
        WHEN 'Processing' THEN 'Being Processed'
        ELSE 'Unknown'
    END AS status_description
FROM orders;


-- =========================
-- CTE: 47-50
-- =========================

-- 47.
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        COALESCE(SUM(o.total_amount),0) AS total_spent
    FROM customers c
    LEFT JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *
FROM customer_spending
WHERE total_spent > 5000
ORDER BY total_spent DESC;

-- 48.
WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        COALESCE(SUM(oi.quantity),0) AS total_quantity_sold
    FROM products p
    LEFT JOIN order_items oi ON oi.product_id = p.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT *
FROM product_sales
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- 49.
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
        SUM(quantity) AS total_quantity_sold,
        SUM(quantity * unit_price * (1-discount/100.0)) AS total_sales
    FROM order_items
    GROUP BY product_id
)
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    cos.total_orders,
    cos.total_spent,
    pss.total_quantity_sold,
    pss.total_sales
FROM customers c
LEFT JOIN customer_order_summary cos ON cos.customer_id = c.customer_id
CROSS JOIN LATERAL (
    SELECT
        COALESCE(SUM(ps.total_quantity_sold),0) AS total_quantity_sold,
        COALESCE(SUM(ps.total_sales),0) AS total_sales
    FROM product_sales_summary ps
) pss
WHERE cos.total_orders IS NOT NULL;

-- 50.
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        COALESCE(SUM(o.total_amount),0) AS total_spent
    FROM customers c
    LEFT JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *
FROM customer_spending
WHERE total_spent > (SELECT AVG(total_spent) FROM customer_spending)
ORDER BY total_spent DESC;


-- =========================
-- RECURSIVE CTE: 51-52
-- =========================

-- 51.
WITH RECURSIVE category_tree AS (
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        c.category_name::TEXT AS path,
        0 AS level
    FROM categories c
    WHERE c.parent_category_id IS NULL

    UNION ALL

    SELECT
        child.category_id,
        child.category_name,
        child.parent_category_id,
        (ct.path || ' > ' || child.category_name)::TEXT,
        ct.level + 1
    FROM categories child
    JOIN category_tree ct
      ON child.parent_category_id = ct.category_id
)
SELECT
    category_id,
    category_name,
    parent_category_id,
    level,
    path
FROM category_tree
ORDER BY path;

-- 52.
WITH RECURSIVE category_tree AS (
    SELECT category_id, category_name, parent_category_id, 0 AS level
    FROM categories
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT c.category_id, c.category_name, c.parent_category_id, ct.level + 1
    FROM categories c
    JOIN category_tree ct ON c.parent_category_id = ct.category_id
)
SELECT REPEAT('    ', level) || category_name AS category_hierarchy
FROM category_tree
ORDER BY category_hierarchy;


-- =========================
-- VIEWS: 53-57
-- =========================

-- 53.
CREATE OR REPLACE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount),0) AS total_spent,
    MAX(o.order_date) AS last_order_date
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 54.
SELECT *
FROM customer_order_summary
ORDER BY total_spent DESC
LIMIT 5;

-- 55.
CREATE OR REPLACE VIEW product_sales_summary AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    COALESCE(SUM(oi.quantity),0) AS total_quantity_sold,
    COALESCE(SUM(oi.quantity * oi.unit_price * (1-oi.discount/100.0)),0) AS total_sales
FROM products p
JOIN categories c ON c.category_id = p.category_id
LEFT JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name, c.category_name;

-- 56.
SELECT *
FROM product_sales_summary
WHERE total_sales > 10000
ORDER BY total_sales DESC;

-- 57. Aggregated view is not directly updatable.
-- This would normally fail because it contains GROUP BY/aggregates:
-- UPDATE customer_order_summary SET total_spent = 10000 WHERE customer_id = 1;


-- =========================
-- MATERIALIZED VIEW: 58-62
-- =========================

-- 58.
DROP MATERIALIZED VIEW IF EXISTS monthly_sales_summary;

CREATE MATERIALIZED VIEW monthly_sales_summary AS
SELECT
    EXTRACT(YEAR FROM o.order_date)::INT AS sales_year,
    EXTRACT(MONTH FROM o.order_date)::INT AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(oi.quantity),0) AS total_products_sold,
    COALESCE(SUM(oi.quantity * oi.unit_price * (1-oi.discount/100.0)),0) AS total_revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY EXTRACT(YEAR FROM o.order_date), EXTRACT(MONTH FROM o.order_date);

-- 59.
SELECT *
FROM monthly_sales_summary
ORDER BY sales_year, sales_month;

-- 60. Add a new order/item/payment, then query the materialized view.
-- The old materialized result does not automatically include the new rows.

-- 61.
REFRESH MATERIALIZED VIEW monthly_sales_summary;

-- 62. VIEW vs MATERIALIZED VIEW:
-- VIEW: stores the SQL definition, calculates when queried, always reflects current base data.
-- MATERIALIZED VIEW: stores the query result physically, can be faster for reporting,
-- but can become stale and needs REFRESH.


-- =========================
-- INDEXES: 63-69
-- =========================

-- 63.
CREATE INDEX IF NOT EXISTS idx_customers_email
ON customers(email);

-- 64.
CREATE INDEX IF NOT EXISTS idx_orders_customer
ON orders(customer_id);

-- 65.
CREATE INDEX IF NOT EXISTS idx_orders_order_date
ON orders(order_date);

-- 66.
CREATE INDEX IF NOT EXISTS idx_orders_status_date
ON orders(order_status, order_date);

-- 67.
CREATE INDEX IF NOT EXISTS idx_products_category_price
ON products(category_id, price);

-- 68.
EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 10;

-- 69.
-- DROP INDEX IF EXISTS idx_orders_customer;
-- Removing unused indexes can reduce storage and INSERT/UPDATE/DELETE overhead.


-- =========================
-- WINDOW FUNCTIONS: 79-84
-- =========================

-- 79.
SELECT
    product_id,
    product_name,
    price,
    RANK() OVER (ORDER BY price DESC) AS price_rank
FROM products;

-- 80.
SELECT
    product_id,
    product_name,
    category_id,
    price,
    RANK() OVER (
        PARTITION BY category_id
        ORDER BY price DESC
    ) AS category_price_rank
FROM products;

-- 81.
SELECT *
FROM (
    SELECT
        product_id,
        product_name,
        category_id,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY category_id
            ORDER BY price DESC
        ) AS rn
    FROM products
) x
WHERE rn <= 3
ORDER BY category_id, rn;

-- 82.
WITH daily_sales AS (
    SELECT
        DATE(o.order_date) AS sales_date,
        SUM(oi.quantity * oi.unit_price * (1-oi.discount/100.0)) AS daily_sales
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY DATE(o.order_date)
)
SELECT
    sales_date,
    daily_sales,
    SUM(daily_sales) OVER (ORDER BY sales_date) AS running_total
FROM daily_sales
ORDER BY sales_date;

-- 83.
SELECT
    order_id,
    customer_id,
    order_date,
    ROW_NUMBER() OVER (
        ORDER BY order_date, order_id
    ) AS order_number
FROM orders;

-- 84.
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_value
FROM orders;


-- =========================
-- DATE/TIME: 85-89
-- =========================

-- 85.
SELECT *
FROM orders
WHERE order_date::DATE = CURRENT_DATE;

-- 86.
SELECT *
FROM orders
WHERE order_date >= DATE_TRUNC('month', CURRENT_DATE)
  AND order_date < DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month';

-- 87.
SELECT
    DATE_TRUNC('month', order_date)::DATE AS sales_month,
    SUM(total_amount) AS monthly_revenue
FROM orders
WHERE order_status <> 'Cancelled'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;

-- 88.
SELECT c.*
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.order_date >= CURRENT_DATE - INTERVAL '6 months'
);

-- 89.
WITH first_orders AS (
    SELECT customer_id, MIN(order_date::DATE) AS first_order_date
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.registration_date,
    f.first_order_date,
    f.first_order_date - c.registration_date AS days_to_first_order
FROM customers c
JOIN first_orders f ON f.customer_id = c.customer_id;


-- =========================
-- STRING FUNCTIONS: 90-94
-- =========================

-- 90.
SELECT
    customer_id,
    first_name || ' ' || last_name AS complete_name
FROM customers;

-- 91.
SELECT LOWER(email) AS email_lowercase
FROM customers;

-- 92.
SELECT UPPER(product_name) AS product_name_uppercase
FROM products;

-- 93.
SELECT product_name, LENGTH(product_name) AS name_length
FROM products;

-- 94.
SELECT
    email,
    SPLIT_PART(email, '@', 2) AS email_domain
FROM customers;


-- =========================
-- NULL: 95-97
-- =========================

-- 95.
SELECT *
FROM customers
WHERE phone IS NULL;

-- 96.
SELECT
    customer_id,
    first_name,
    COALESCE(phone, 'Not Available') AS phone
FROM customers;

-- 97.
SELECT p.*
FROM products p
LEFT JOIN reviews r ON r.product_id = p.product_id
WHERE r.review_id IS NULL;


-- =========================
-- SET OPERATIONS: 98-101
-- =========================

-- 98.
SELECT city FROM customers
UNION
SELECT shipping_city FROM orders
ORDER BY city;

-- 99.
SELECT city FROM customers
UNION ALL
SELECT shipping_city FROM orders
ORDER BY city;

-- 100.
SELECT city FROM customers
INTERSECT
SELECT shipping_city FROM orders
ORDER BY city;

-- 101.
SELECT city FROM customers
EXCEPT
SELECT shipping_city FROM orders
ORDER BY city;


-- =========================
-- TRANSACTIONS: 102-103
-- =========================

-- 102. Successful transaction example.
-- Run as one transaction:
BEGIN;

INSERT INTO orders
(customer_id, order_date, order_status, shipping_city, shipping_country, total_amount)
VALUES
(1, CURRENT_TIMESTAMP, 'Pending', 'Hyderabad', 'India', 1000);

COMMIT;

-- 103. Failed transaction / rollback example.
BEGIN;

INSERT INTO orders
(customer_id, order_date, order_status, shipping_city, shipping_country, total_amount)
VALUES
(1, CURRENT_TIMESTAMP, 'Pending', 'Hyderabad', 'India', 500);

-- Simulate failure:
-- SELECT 1/0;

ROLLBACK;


-- =========================
-- ADVANCED BUSINESS QUERIES: 104-120
-- =========================

-- 104. Top five customers by spending.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(o.total_amount) AS total_spending
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spending DESC
LIMIT 5;

-- 105. Top five best-selling products by quantity.
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS quantity_sold
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY quantity_sold DESC
LIMIT 5;

-- 106. Top five products by revenue.
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price * (1-oi.discount/100.0)) AS revenue
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 5;

-- 107. Category generating most revenue.
SELECT
    c.category_id,
    c.category_name,
    SUM(oi.quantity * oi.unit_price * (1-oi.discount/100.0)) AS revenue
FROM categories c
JOIN products p ON p.category_id = c.category_id
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.category_id, c.category_name
ORDER BY revenue DESC
LIMIT 1;

-- 108. Customers who ordered more than five different products.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(DISTINCT oi.product_id) AS different_products
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT oi.product_id) > 5;

-- 109. Products ordered by more than ten different customers.
SELECT
    p.product_id,
    p.product_name,
    COUNT(DISTINCT o.customer_id) AS different_customers
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.product_id, p.product_name
HAVING COUNT(DISTINCT o.customer_id) > 10;

-- 110. Customers buying from at least three categories.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(DISTINCT p.category_id) AS category_count
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT p.category_id) >= 3;

-- 111. Most popular product in every category.
WITH product_counts AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category_id,
        SUM(oi.quantity) AS units_sold
    FROM products p
    JOIN order_items oi ON oi.product_id = p.product_id
    JOIN orders o ON o.order_id = oi.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY p.product_id, p.product_name, p.category_id
),
ranked AS (
    SELECT *,
           RANK() OVER (
               PARTITION BY category_id
               ORDER BY units_sold DESC
           ) AS rnk
    FROM product_counts
)
SELECT
    r.product_id,
    r.product_name,
    c.category_name,
    r.units_sold
FROM ranked r
JOIN categories c ON c.category_id = r.category_id
WHERE r.rnk = 1;

-- 112. Customers who purchased same product more than once.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    oi.product_id,
    p.product_name,
    COUNT(*) AS purchase_lines
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name, oi.product_id, p.product_name
HAVING COUNT(*) > 1;

-- 113. Customers above average customer spending.
WITH spending AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        COALESCE(SUM(CASE WHEN o.order_status <> 'Cancelled' THEN o.total_amount ELSE 0 END),0) AS total_spending
    FROM customers c
    LEFT JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *
FROM spending
WHERE total_spending > (SELECT AVG(total_spending) FROM spending)
ORDER BY total_spending DESC;

-- 114a. Second-highest priced product using subquery.
SELECT *
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE price < (SELECT MAX(price) FROM products)
);

-- 114b. Second-highest using window function.
SELECT product_id, product_name, price
FROM (
    SELECT *,
           DENSE_RANK() OVER (ORDER BY price DESC) AS price_rank
    FROM products
) x
WHERE price_rank = 2;

-- 115. Third-highest spending customer.
WITH spending AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        COALESCE(SUM(CASE WHEN o.order_status <> 'Cancelled' THEN o.total_amount ELSE 0 END),0) AS total_spending
    FROM customers c
    LEFT JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (ORDER BY total_spending DESC) AS spending_rank
    FROM spending
) x
WHERE spending_rank = 3;

-- 116. Month with highest revenue.
SELECT
    DATE_TRUNC('month', order_date)::DATE AS sales_month,
    SUM(total_amount) AS revenue
FROM orders
WHERE order_status <> 'Cancelled'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY revenue DESC
LIMIT 1;

-- 117. Product with highest average rating, minimum 3 reviews.
SELECT
    p.product_id,
    p.product_name,
    AVG(r.rating) AS average_rating,
    COUNT(r.review_id) AS review_count
FROM products p
JOIN reviews r ON r.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(r.review_id) >= 3
ORDER BY average_rating DESC
LIMIT 1;

-- 118. Customers with orders but no reviews.
SELECT c.*
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id
)
AND NOT EXISTS (
    SELECT 1 FROM reviews r WHERE r.customer_id = c.customer_id
);

-- 119. Low stock + high sales.
SELECT
    p.product_id,
    p.product_name,
    p.stock_quantity,
    SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
  AND p.stock_quantity < 10
GROUP BY p.product_id, p.product_name, p.stock_quantity
HAVING SUM(oi.quantity) > 20
ORDER BY units_sold DESC;

-- 120. Customers whose latest order was cancelled.
WITH latest_order AS (
    SELECT
        o.*,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC, order_id DESC
        ) AS rn
    FROM orders o
)
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    lo.order_id,
    lo.order_date,
    lo.order_status
FROM latest_order lo
JOIN customers c ON c.customer_id = lo.customer_id
WHERE lo.rn = 1
  AND lo.order_status = 'Cancelled';
