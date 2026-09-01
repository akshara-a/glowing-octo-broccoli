-- =========================================================
-- TASK 13 - ADVANCED QUERYING & DB PROGRAMMING
-- 03_queries.sql
-- ShopSphere Database
-- PostgreSQL
-- =========================================================


-- =========================================================
-- PART 3 - BASIC SQL QUERIES
-- =========================================================

-- Q1. Display all customers
SELECT *
FROM customers;


-- Q2. Display active customers
SELECT
    first_name,
    last_name,
    email,
    city
FROM customers
WHERE status = 'Active';


-- Q3. Products with price greater than 1000
SELECT *
FROM products
WHERE price > 1000;


-- Q4. Products with price between 500 and 2000
SELECT *
FROM products
WHERE price BETWEEN 500 AND 2000;


-- Q5. Customers from Hyderabad, Bangalore and Chennai
SELECT *
FROM customers
WHERE city IN ('Hyderabad', 'Bangalore', 'Chennai');


-- Q6. Customers whose first name starts with A
SELECT *
FROM customers
WHERE first_name ILIKE 'A%';


-- Q7. Products containing "Phone" in product name
SELECT *
FROM products
WHERE product_name ILIKE '%phone%';


-- Q8. Display orders latest first
SELECT *
FROM orders
ORDER BY order_date DESC;


-- Q9. Top 5 most expensive products
SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;


-- Q10. Products with stock less than 10
SELECT *
FROM products
WHERE stock_quantity < 10
ORDER BY stock_quantity;


-- =========================================================
-- PART 4 - AGGREGATE FUNCTIONS
-- =========================================================

-- Q11. Total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;


-- Q12. Total number of products
SELECT COUNT(*) AS total_products
FROM products;


-- Q13. Average product price
SELECT ROUND(AVG(price), 2) AS average_product_price
FROM products;


-- Q14. Cheapest product
SELECT *
FROM products
ORDER BY price ASC
LIMIT 1;


-- Q15. Most expensive product
SELECT *
FROM products
ORDER BY price DESC
LIMIT 1;


-- Q16. Total value of all orders
SELECT
    COALESCE(SUM(total_amount), 0) AS total_order_value
FROM orders;


-- Q17. Average order amount
SELECT
    ROUND(AVG(total_amount), 2) AS average_order_amount
FROM orders;


-- Q18. Number of orders by status
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- =========================================================
-- PART 5 - GROUP BY AND HAVING
-- =========================================================

-- Q19. Number of products in each category
SELECT
    c.category_id,
    c.category_name,
    COUNT(p.product_id) AS product_count
FROM categories c
LEFT JOIN products p
    ON p.category_id = c.category_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY c.category_id;


-- Q20. Average product price by category
SELECT
    c.category_id,
    c.category_name,
    ROUND(AVG(p.price), 2) AS average_price
FROM categories c
LEFT JOIN products p
    ON p.category_id = c.category_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY c.category_id;


-- Q21. Categories whose average product price is greater than 1000
SELECT
    c.category_id,
    c.category_name,
    ROUND(AVG(p.price), 2) AS average_price
FROM categories c
JOIN products p
    ON p.category_id = c.category_id
GROUP BY
    c.category_id,
    c.category_name
HAVING AVG(p.price) > 1000
ORDER BY average_price DESC;


-- Q22. Total spending by each customer
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC;


-- Q23. Customers who spent more than 5000
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING SUM(o.total_amount) > 5000
ORDER BY total_spent DESC;


-- Q24. Products ordered more than 5 times
SELECT
    p.product_id,
    p.product_name,
    COUNT(DISTINCT oi.order_id) AS times_ordered
FROM products p
JOIN order_items oi
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING COUNT(DISTINCT oi.order_id) > 5
ORDER BY times_ordered DESC;


-- =========================================================
-- PART 6 - SQL JOINS
-- =========================================================

-- Q25. INNER JOIN - Orders with customer details
SELECT
    o.order_id,
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    o.order_date,
    o.order_status,
    o.total_amount
FROM orders o
INNER JOIN customers c
    ON c.customer_id = o.customer_id
ORDER BY o.order_id;


-- Q26. Multiple table JOIN
-- Customer, order, product and order item details
SELECT
    o.order_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.discount
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON oi.order_id = o.order_id
JOIN products p
    ON p.product_id = oi.product_id
ORDER BY o.order_id, oi.order_item_id;


-- Q27. Product with category
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price
FROM products p
JOIN categories c
    ON c.category_id = p.category_id
ORDER BY p.product_id;


-- Q28. LEFT JOIN - Include customers even without orders
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    o.order_id,
    o.order_date,
    o.order_status,
    o.total_amount
FROM customers c
LEFT JOIN orders o
    ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_date;


-- Q29. Customers who have never placed an order
SELECT
    c.*
FROM customers c
LEFT JOIN orders o
    ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;


-- Q30. Products never ordered
SELECT
    p.*
FROM products p
LEFT JOIN order_items oi
    ON oi.product_id = p.product_id
WHERE oi.order_item_id IS NULL;


-- Q31. RIGHT JOIN example
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_status
FROM orders o
RIGHT JOIN customers c
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id;


-- Q32. FULL OUTER JOIN example
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_status
FROM customers c
FULL OUTER JOIN orders o
    ON o.customer_id = c.customer_id
ORDER BY c.customer_id, o.order_id;


-- Q33. SELF JOIN - Category and parent category
SELECT
    child.category_id,
    child.category_name AS category,
    parent.category_name AS parent_category
FROM categories child
LEFT JOIN categories parent
    ON child.parent_category_id = parent.category_id
ORDER BY child.category_id;


-- =========================================================
-- PART 7 - SUBQUERIES
-- =========================================================

-- Q34. Products priced above overall average price
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
)
ORDER BY price DESC;


-- Q35. Customers whose spending is above
-- average customer spending
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            customer_id,
            SUM(total_amount) AS customer_total
        FROM orders
        GROUP BY customer_id
    ) AS customer_spending
)
ORDER BY total_spent DESC;


-- Q36. Most expensive product in each category
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


-- Q37. EXISTS - Customers who placed at least one order
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);


-- Q38. NOT EXISTS - Customers who never placed an order
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);


-- Q39. ALL operator
-- Products more expensive than ALL products in category 5 (Clothing)
SELECT *
FROM products
WHERE price > ALL (
    SELECT price
    FROM products
    WHERE category_id = 5
)
ORDER BY price DESC;


-- Q40. ANY operator
-- Products more expensive than ANY product in category 5
SELECT *
FROM products
WHERE price > ANY (
    SELECT price
    FROM products
    WHERE category_id = 5
)
ORDER BY price;


-- =========================================================
-- PART 8 - CORRELATED SUBQUERIES
-- =========================================================

-- Q41. Highest priced product in each category
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


-- Q42. Customers spending more than the
-- average spending of customers in the same city
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        c.city,
        COALESCE(SUM(o.total_amount), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON o.customer_id = c.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name,
        c.city
)
SELECT
    cs.customer_id,
    cs.first_name,
    cs.last_name,
    cs.city,
    cs.total_spent
FROM customer_spending cs
WHERE cs.total_spent > (
    SELECT AVG(cs2.total_spent)
    FROM customer_spending cs2
    WHERE cs2.city = cs.city
)
ORDER BY cs.city, cs.total_spent DESC;


-- Q43. Products with rating above category average
SELECT DISTINCT
    p.product_id,
    p.product_name,
    p.category_id
FROM products p
JOIN reviews r
    ON r.product_id = p.product_id
WHERE r.rating > (
    SELECT AVG(r2.rating)
    FROM reviews r2
    JOIN products p2
        ON p2.product_id = r2.product_id
    WHERE p2.category_id = p.category_id
)
ORDER BY p.product_id;


-- =========================================================
-- PART 9 - CASE EXPRESSIONS
-- =========================================================

-- Q44. Categorize products based on price
SELECT
    product_id,
    product_name,
    price,
    CASE
        WHEN price < 500 THEN 'Budget'
        WHEN price BETWEEN 500 AND 2000 THEN 'Mid Range'
        ELSE 'Premium'
    END AS price_category
FROM products
ORDER BY price;


-- Q45. Categorize stock level
SELECT
    product_id,
    product_name,
    stock_quantity,
    CASE
        WHEN stock_quantity = 0 THEN 'Out of Stock'
        WHEN stock_quantity BETWEEN 1 AND 10 THEN 'Low Stock'
        WHEN stock_quantity BETWEEN 11 AND 50 THEN 'Medium Stock'
        ELSE 'High Stock'
    END AS stock_level
FROM products
ORDER BY stock_quantity;


-- Q46. Order status description
SELECT
    order_id,
    order_status,
    CASE order_status
        WHEN 'Pending' THEN 'Awaiting Processing'
        WHEN 'Processing' THEN 'Being Processed'
        WHEN 'Shipped' THEN 'On the Way'
        WHEN 'Delivered' THEN 'Completed'
        WHEN 'Cancelled' THEN 'Order Cancelled'
        ELSE 'Unknown Status'
    END AS status_description
FROM orders
ORDER BY order_id;


-- =========================================================
-- PART 18 - WINDOW FUNCTIONS
-- =========================================================

-- Q79. Rank all products by price
SELECT
    product_id,
    product_name,
    price,
    RANK() OVER (
        ORDER BY price DESC
    ) AS price_rank
FROM products;


-- Q80. Rank products by price within each category
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


-- Q81. Top 3 expensive products in each category
WITH ranked_products AS (
    SELECT
        p.*,
        ROW_NUMBER() OVER (
            PARTITION BY category_id
            ORDER BY price DESC
        ) AS row_num
    FROM products p
)
SELECT *
FROM ranked_products
WHERE row_num <= 3
ORDER BY category_id, row_num;


-- Q82. Running total of daily revenue
WITH daily_sales AS (
    SELECT
        order_date::DATE AS sales_date,
        SUM(total_amount) AS daily_revenue
    FROM orders
    GROUP BY order_date::DATE
)
SELECT
    sales_date,
    daily_revenue,
    SUM(daily_revenue) OVER (
        ORDER BY sales_date
    ) AS running_total
FROM daily_sales
ORDER BY sales_date;


-- Q83. Sequential order number for each customer's orders
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
ORDER BY customer_id, customer_order_number;


-- Q84. Compare order amount with customer's previous order
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date, order_id
    ) AS previous_order_amount
FROM orders
ORDER BY customer_id, order_date;


-- =========================================================
-- PART 19 - DATE AND TIME QUERIES
-- =========================================================

-- Q85. Orders placed today
SELECT *
FROM orders
WHERE order_date::DATE = CURRENT_DATE;


-- Q86. Orders placed in current month
SELECT *
FROM orders
WHERE DATE_TRUNC('month', order_date)
      = DATE_TRUNC('month', CURRENT_DATE)
ORDER BY order_date;


-- Q87. Monthly revenue
SELECT
    DATE_TRUNC('month', order_date)::DATE AS sales_month,
    SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;


-- Q88. Customers with no orders during last 6 months
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.order_date >= CURRENT_DATE - INTERVAL '6 months'
);


-- Q89. Days between registration and first order
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.registration_date::DATE AS registration_date,
    MIN(o.order_date)::DATE AS first_order_date,
    MIN(o.order_date)::DATE
        - c.registration_date::DATE AS days_to_first_order
FROM customers c
LEFT JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.registration_date
ORDER BY c.customer_id;


-- =========================================================
-- PART 20 - STRING FUNCTIONS
-- =========================================================

-- Q90. Combine customer first name and last name
SELECT
    customer_id,
    CONCAT_WS(' ', first_name, last_name) AS customer_name
FROM customers;


-- Q91. Convert email to lowercase
SELECT
    customer_id,
    LOWER(email) AS email_lowercase
FROM customers;


-- Q92. Convert product name to uppercase
SELECT
    product_id,
    UPPER(product_name) AS product_name_uppercase
FROM products;


-- Q93. Length of product names
SELECT
    product_id,
    product_name,
    LENGTH(product_name) AS name_length
FROM products
ORDER BY name_length DESC;


-- Q94. Extract email domain
SELECT
    customer_id,
    email,
    SPLIT_PART(email, '@', 2) AS email_domain
FROM customers;


-- =========================================================
-- PART 21 - NULL HANDLING
-- =========================================================

-- Q95. Customers whose phone is NULL
SELECT *
FROM customers
WHERE phone IS NULL;


-- Q96. Replace NULL phone with "Not Available"
SELECT
    customer_id,
    first_name,
    last_name,
    COALESCE(phone, 'Not Available') AS phone
FROM customers;


-- Q97. Products without reviews
SELECT
    p.*
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM reviews r
    WHERE r.product_id = p.product_id
);


-- =========================================================
-- PART 22 - SET OPERATIONS
-- =========================================================

-- Q98. UNION - unique cities
SELECT city
FROM customers

UNION

SELECT shipping_city
FROM orders;


-- Q99. UNION ALL - keeps duplicate cities
SELECT city
FROM customers

UNION ALL

SELECT shipping_city
FROM orders;


-- Q100. INTERSECT - cities present in both tables
SELECT city
FROM customers

INTERSECT

SELECT shipping_city
FROM orders;


-- Q101. EXCEPT - customer cities not used as shipping cities
SELECT city
FROM customers

EXCEPT

SELECT shipping_city
FROM orders;


-- =========================================================
-- PART 23 - TRANSACTIONS
-- =========================================================

-- Q102. Successful transaction example
--
-- IMPORTANT:
-- This demonstration uses ROLLBACK at the end so that your
-- original sample data remains unchanged while testing.
--
-- If assignment specifically asks to demonstrate COMMIT,
-- temporarily replace final ROLLBACK with COMMIT.

BEGIN;

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
    'Pending',
    'Hyderabad',
    'India',
    75000.00
);

INSERT INTO order_items (
    order_id,
    product_id,
    quantity,
    unit_price,
    discount
)
VALUES (
    currval(pg_get_serial_sequence('orders', 'order_id')),
    1,
    1,
    75000.00,
    0
);

UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 1
  AND stock_quantity >= 1;

INSERT INTO payments (
    order_id,
    payment_date,
    payment_method,
    payment_status,
    amount,
    transaction_reference
)
VALUES (
    currval(pg_get_serial_sequence('orders', 'order_id')),
    CURRENT_TIMESTAMP,
    'UPI',
    'Completed',
    75000.00,
    'TXN-DEMO-001'
);

-- Use COMMIT here for permanent changes.
ROLLBACK;


-- Q103. Rollback example
BEGIN;

UPDATE products
SET stock_quantity = stock_quantity - 5
WHERE product_id = 1;

-- Check temporary change
SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE product_id = 1;

ROLLBACK;

-- Verify rollback
SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE product_id = 1;


-- =========================================================
-- PART 24 - ADVANCED BUSINESS QUERIES
-- =========================================================

-- Q104. Top 5 customers by total spending
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC
LIMIT 5;


-- Q105. Top 5 products by quantity sold
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;


-- Q106. Top 5 products by revenue
SELECT
    p.product_id,
    p.product_name,
    ROUND(
        SUM(
            oi.quantity
            * oi.unit_price
            * (1 - oi.discount / 100.0)
        ),
        2
    ) AS total_revenue
FROM products p
JOIN order_items oi
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC
LIMIT 5;


-- Q107. Category generating highest revenue
SELECT
    c.category_id,
    c.category_name,
    ROUND(
        SUM(
            oi.quantity
            * oi.unit_price
            * (1 - oi.discount / 100.0)
        ),
        2
    ) AS category_revenue
FROM categories c
JOIN products p
    ON p.category_id = c.category_id
JOIN order_items oi
    ON oi.product_id = p.product_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY category_revenue DESC
LIMIT 1;


-- Q108. Customers who bought more than 5 different products
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(DISTINCT oi.product_id) AS different_products
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON oi.order_id = o.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(DISTINCT oi.product_id) > 5
ORDER BY different_products DESC;


-- Q109. Products purchased by more than 10 customers
SELECT
    p.product_id,
    p.product_name,
    COUNT(DISTINCT o.customer_id) AS distinct_customers
FROM products p
JOIN order_items oi
    ON oi.product_id = p.product_id
JOIN orders o
    ON o.order_id = oi.order_id
GROUP BY
    p.product_id,
    p.product_name
HAVING COUNT(DISTINCT o.customer_id) > 10
ORDER BY distinct_customers DESC;


-- Q110. Customers purchasing from at least 3 categories
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(DISTINCT p.category_id) AS category_count
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON oi.order_id = o.order_id
JOIN products p
    ON p.product_id = oi.product_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(DISTINCT p.category_id) >= 3
ORDER BY category_count DESC;


-- Q111. Best-selling product in each category
WITH product_sales AS (
    SELECT
        p.category_id,
        p.product_id,
        p.product_name,
        SUM(oi.quantity) AS quantity_sold
    FROM products p
    JOIN order_items oi
        ON oi.product_id = p.product_id
    GROUP BY
        p.category_id,
        p.product_id,
        p.product_name
),
ranked_products AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY category_id
            ORDER BY quantity_sold DESC
        ) AS sales_rank
    FROM product_sales
)
SELECT *
FROM ranked_products
WHERE sales_rank = 1
ORDER BY category_id;


-- Q112. Customers who ordered same product more than once
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    p.product_id,
    p.product_name,
    COUNT(DISTINCT o.order_id) AS number_of_orders
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON oi.order_id = o.order_id
JOIN products p
    ON p.product_id = oi.product_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    p.product_id,
    p.product_name
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY number_of_orders DESC;


-- Q113. Customers spending above average customer spending
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        COALESCE(SUM(o.total_amount), 0) AS total_spent
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
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM customer_spending
)
ORDER BY total_spent DESC;


-- Q114A. Second highest product price using subquery
SELECT *
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE price < (
        SELECT MAX(price)
        FROM products
    )
);


-- Q114B. Second highest product price using window function
WITH ranked_products AS (
    SELECT
        p.*,
        DENSE_RANK() OVER (
            ORDER BY price DESC
        ) AS price_rank
    FROM products p
)
SELECT *
FROM ranked_products
WHERE price_rank = 2;


-- Q115. Third highest spending customer
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        COALESCE(SUM(o.total_amount), 0) AS total_spent
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
        *,
        DENSE_RANK() OVER (
            ORDER BY total_spent DESC
        ) AS spending_rank
    FROM customer_spending
)
SELECT *
FROM ranked_customers
WHERE spending_rank = 3;


-- Q116. Month with highest revenue
SELECT
    DATE_TRUNC('month', order_date)::DATE AS sales_month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY revenue DESC
LIMIT 1;


-- Q117. Product with highest average rating
-- Minimum 3 reviews
SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.review_id) AS review_count
FROM products p
JOIN reviews r
    ON r.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING COUNT(r.review_id) >= 3
ORDER BY average_rating DESC
LIMIT 1;


-- Q118. Customers who ordered but never wrote a review
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
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
);


-- Q119. Low stock products with high sales
SELECT
    p.product_id,
    p.product_name,
    p.stock_quantity,
    SUM(oi.quantity) AS units_sold
FROM products p
JOIN order_items oi
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.stock_quantity
HAVING p.stock_quantity < 10
   AND SUM(oi.quantity) > 2
ORDER BY units_sold DESC;


-- Q120. Customers whose latest order was cancelled
WITH latest_orders AS (
    SELECT
        o.*,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC, order_id DESC
        ) AS row_num
    FROM orders o
)
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    lo.order_id,
    lo.order_date,
    lo.order_status
FROM customers c
JOIN latest_orders lo
    ON lo.customer_id = c.customer_id
WHERE lo.row_num = 1
  AND lo.order_status = 'Cancelled';


-- =========================================================
-- FINAL INTEGRATED CUSTOMER PERFORMANCE QUERY
-- =========================================================

WITH order_level AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        c.city,
        c.registration_date,
        o.order_id,
        o.order_date,
        o.order_status,
        o.total_amount,
        COALESCE(SUM(oi.quantity), 0) AS products_in_order
    FROM customers c
    LEFT JOIN orders o
        ON o.customer_id = c.customer_id
    LEFT JOIN order_items oi
        ON oi.order_id = o.order_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name,
        c.city,
        c.registration_date,
        o.order_id,
        o.order_date,
        o.order_status,
        o.total_amount
),

customer_stats AS (
    SELECT
        customer_id,
        customer_name,
        city,
        registration_date,

        COUNT(order_id) AS total_orders,

        COUNT(order_id)
            FILTER (
                WHERE order_status = 'Delivered'
            ) AS completed_orders,

        COUNT(order_id)
            FILTER (
                WHERE order_status = 'Cancelled'
            ) AS cancelled_orders,

        COALESCE(
            SUM(products_in_order),
            0
        ) AS total_products_purchased,

        COALESCE(
            SUM(total_amount),
            0
        ) AS total_spent,

        COALESCE(
            AVG(total_amount),
            0
        ) AS average_order_value,

        MAX(order_date) AS last_order_date

    FROM order_level
    GROUP BY
        customer_id,
        customer_name,
        city,
        registration_date
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
    ROUND(average_order_value, 2) AS average_order_value,
    last_order_date,

    RANK() OVER (
        ORDER BY total_spent DESC
    ) AS customer_rank,

    CASE
        WHEN total_spent >= 20000 THEN 'Platinum'
        WHEN total_spent >= 10000 THEN 'Gold'
        WHEN total_spent >= 5000 THEN 'Silver'
        ELSE 'Regular'
    END AS customer_category

FROM customer_stats
ORDER BY customer_rank;


-- =========================================================
-- 03_queries.sql COMPLETE
-- =========================================================