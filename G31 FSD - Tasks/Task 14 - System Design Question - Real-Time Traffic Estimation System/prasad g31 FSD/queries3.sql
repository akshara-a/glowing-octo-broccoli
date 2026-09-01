-- ============================================================
-- 03_queries.sql
-- ShopSphere SQL Assignment
-- ============================================================


-- ============================================================
-- SECTION A: BASIC SELECT & FILTERING
-- ============================================================


-- Q1. List all customers
SELECT *
FROM customers;


-- Q2. List all products with their name and price
SELECT
    product_name,
    price
FROM products;


-- Q3. Find products costing more than ₹50,000
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price > 50000
ORDER BY price DESC;


-- Q4. Find all active products
SELECT
    product_id,
    product_name,
    price,
    stock_quantity
FROM products
WHERE is_active = TRUE;


-- Q5. Find customers from Bangalore
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    city
FROM customers
WHERE city = 'Bangalore';


-- Q6. Find products with price between ₹5,000 and ₹30,000
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price BETWEEN 5000 AND 30000
ORDER BY price;


-- Q7. Find customers whose first name starts with 'A'
SELECT
    customer_id,
    first_name,
    last_name,
    email
FROM customers
WHERE first_name LIKE 'A%';


-- Q8. Find products whose name contains 'Mouse'
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE product_name ILIKE '%Mouse%';


-- Q9. Display the 5 most expensive products
SELECT
    product_id,
    product_name,
    price
FROM products
ORDER BY price DESC
LIMIT 5;


-- Q10. Display products with stock less than 20
SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity < 20
ORDER BY stock_quantity;


-- ============================================================
-- SECTION B: JOINS
-- ============================================================


-- Q11. Display customers and their orders
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    o.order_status,
    o.total_amount
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;


-- Q12. Display orders along with customer names
SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    c.first_name,
    c.last_name,
    c.email
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
ORDER BY o.order_date;


-- Q13. Display products with their category names
SELECT
    p.product_id,
    p.product_name,
    p.price,
    c.category_name
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
ORDER BY c.category_name, p.product_name;


-- Q14. Display order details with product names
SELECT
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.discount
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
ORDER BY oi.order_id;


-- Q15. Display complete order information:
-- customer + order + product
SELECT
    o.order_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    o.order_date,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.discount
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
ORDER BY o.order_id;


-- Q16. Display products and their categories,
-- including products that don't have a matching category
SELECT
    p.product_id,
    p.product_name,
    p.price,
    c.category_name
FROM products p
LEFT JOIN categories c
    ON p.category_id = c.category_id
ORDER BY p.product_id;


-- Q17. Display ALL customers, including customers
-- who have never placed an order
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id;


-- Q18. Find customers who have never placed an order
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


-- Q19. Display orders and their payment information
SELECT
    o.order_id,
    o.order_date,
    o.total_amount,
    p.payment_method,
    p.payment_status,
    p.amount,
    p.transaction_reference
FROM orders o
LEFT JOIN payments p
    ON o.order_id = p.order_id
ORDER BY o.order_id;


-- Q20. Display products that have received reviews
SELECT
    p.product_id,
    p.product_name,
    r.rating,
    r.review_text,
    r.review_date
FROM products p
INNER JOIN reviews r
    ON p.product_id = r.product_id
ORDER BY p.product_id;



-- ============================================================
-- SECTION C: GROUP BY & AGGREGATION
-- ============================================================


-- Q21. Count the total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;


-- Q22. Count the total number of products
SELECT COUNT(*) AS total_products
FROM products;


-- Q23. Find the average product price
SELECT
    AVG(price) AS average_product_price
FROM products;


-- Q24. Find the cheapest and most expensive product
SELECT
    MIN(price) AS cheapest_price,
    MAX(price) AS highest_price
FROM products;


-- Q25. Find the total stock available across all products
SELECT
    SUM(stock_quantity) AS total_stock
FROM products;


-- Q26. Count the number of products in each category
SELECT
    c.category_name,
    COUNT(p.product_id) AS product_count
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY product_count DESC;


-- Q27. Find the average product price for each category
SELECT
    c.category_name,
    ROUND(AVG(p.price), 2) AS average_price
FROM categories c
INNER JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY average_price DESC;


-- Q28. Find the total number of orders placed by each customer
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_orders DESC;


-- Q29. Find the total amount spent by each customer
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;


-- Q30. Find customers who have placed more than 2 orders
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) > 2
ORDER BY total_orders DESC;


-- Q31. Find the number of orders for each order status
SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;


-- Q32. Find the total revenue for each order status
SELECT
    order_status,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY order_status
ORDER BY total_revenue DESC;


-- Q33. Find the average order value
SELECT
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders;


-- Q34. Find the highest order amount
SELECT
    MAX(total_amount) AS highest_order_amount
FROM orders;


-- Q35. Find the total revenue generated from delivered orders
SELECT
    SUM(total_amount) AS delivered_revenue
FROM orders
WHERE order_status = 'Delivered';


-- Q36. Find the number of orders placed in each city
SELECT
    shipping_city,
    COUNT(*) AS order_count
FROM orders
GROUP BY shipping_city
ORDER BY order_count DESC;


-- Q37. Find the average rating for each product
SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating), 2) AS average_rating
FROM products p
INNER JOIN reviews r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
ORDER BY average_rating DESC;


-- Q38. Find products that have an average rating of at least 4
SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating), 2) AS average_rating
FROM products p
INNER JOIN reviews r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(r.rating) >= 4
ORDER BY average_rating DESC;


-- Q39. Count the number of reviews for each product
SELECT
    p.product_id,
    p.product_name,
    COUNT(r.review_id) AS review_count
FROM products p
LEFT JOIN reviews r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
ORDER BY review_count DESC;


-- Q40. Find the total quantity sold for each product
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC;


-- ============================================================
-- SECTION D: SUBQUERIES & EXISTS
-- ============================================================


-- Q41. Find products that are more expensive than
-- the average product price
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


-- Q42. Find the most expensive product
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);


-- Q43. Find products that are cheaper than
-- the average product price
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE price < (
    SELECT AVG(price)
    FROM products
)
ORDER BY price;


-- Q44. Find customers who have placed at least one order
-- using EXISTS
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


-- Q45. Find customers who have never placed an order
-- using NOT EXISTS
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


-- Q46. Find products that have at least one review
-- using EXISTS
SELECT
    p.product_id,
    p.product_name,
    p.price
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM reviews r
    WHERE r.product_id = p.product_id
)
ORDER BY p.product_id;


-- Q47. Find products that have never been reviewed
SELECT
    p.product_id,
    p.product_name,
    p.price
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM reviews r
    WHERE r.product_id = p.product_id
)
ORDER BY p.product_id;


-- Q48. Find customers whose total spending is
-- greater than the average customer spending
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            customer_id,
            SUM(total_amount) AS customer_total
        FROM orders
        GROUP BY customer_id
    ) AS customer_totals
)
ORDER BY total_spent DESC;


-- Q49. Find products whose price is greater than
-- every product in the Accessories category
SELECT
    p.product_id,
    p.product_name,
    p.price
FROM products p
WHERE p.price > ALL (
    SELECT p2.price
    FROM products p2
    INNER JOIN categories c
        ON p2.category_id = c.category_id
    WHERE c.category_name = 'Accessories'
)
ORDER BY p.price DESC;


-- Q50. Find products whose price is greater than
-- at least one product in the Accessories category
SELECT
    p.product_id,
    p.product_name,
    p.price
FROM products p
WHERE p.price > ANY (
    SELECT p2.price
    FROM products p2
    INNER JOIN categories c
        ON p2.category_id = c.category_id
    WHERE c.category_name = 'Accessories'
)
ORDER BY p.price DESC;




-- ============================================================
-- SECTION E: CTEs (COMMON TABLE EXPRESSIONS)
-- ============================================================


-- Q51. Calculate total spending for each customer using a CTE

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    cs.total_spent
FROM customers c
INNER JOIN customer_spending cs
    ON c.customer_id = cs.customer_id
ORDER BY cs.total_spent DESC;


-- Q52. Find the top 5 customers by total spending

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    cs.total_spent
FROM customers c
INNER JOIN customer_spending cs
    ON c.customer_id = cs.customer_id
ORDER BY cs.total_spent DESC
LIMIT 5;


-- Q53. Calculate total revenue by product

WITH product_sales AS (
    SELECT
        product_id,
        SUM(quantity * unit_price) AS revenue
    FROM order_items
    GROUP BY product_id
)
SELECT
    p.product_id,
    p.product_name,
    ps.revenue
FROM products p
INNER JOIN product_sales ps
    ON p.product_id = ps.product_id
ORDER BY ps.revenue DESC;


-- Q54. Find customers whose spending is greater than 100000

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    cs.total_spent
FROM customers c
INNER JOIN customer_spending cs
    ON c.customer_id = cs.customer_id
WHERE cs.total_spent > 100000
ORDER BY cs.total_spent DESC;


-- ============================================================
-- SECTION F: WINDOW FUNCTIONS
-- ============================================================


-- Q55. Rank products according to their price

SELECT
    product_id,
    product_name,
    price,
    RANK() OVER (
        ORDER BY price DESC
    ) AS price_rank
FROM products
ORDER BY price_rank;


-- Q56. Rank customers according to their total spending

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    cs.total_spent,
    RANK() OVER (
        ORDER BY cs.total_spent DESC
    ) AS spending_rank
FROM customers c
INNER JOIN customer_spending cs
    ON c.customer_id = cs.customer_id
ORDER BY spending_rank;


-- Q57. Assign a row number to each order for every customer

SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS customer_order_number
FROM orders
ORDER BY customer_id, customer_order_number;


-- Q58. Find the highest-value order for each customer

WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        total_amount,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY total_amount DESC
        ) AS order_rank
    FROM orders
)
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount
FROM ranked_orders
WHERE order_rank = 1
ORDER BY customer_id;


-- Q59. Calculate running revenue over time

SELECT
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_revenue
FROM orders
ORDER BY order_date;


-- Q60. Calculate the average order value for each customer

SELECT
    order_id,
    customer_id,
    total_amount,
    ROUND(
        AVG(total_amount) OVER (
            PARTITION BY customer_id
        ),
        2
    ) AS customer_average_order_value
FROM orders
ORDER BY customer_id, order_id;


-- Q61. Compare each order with the customer's previous order

SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_amount
FROM orders
ORDER BY customer_id, order_date;


-- Q62. Compare each order with the customer's next order

SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    LEAD(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS next_order_amount
FROM orders
ORDER BY customer_id, order_date;


-- Q63. Find the difference between the current order
-- and the customer's previous order

SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    total_amount
        - LAG(total_amount) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS difference_from_previous_order
FROM orders
ORDER BY customer_id, order_date;


-- Q64. Rank products within each category by price

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    RANK() OVER (
        PARTITION BY c.category_id
        ORDER BY p.price DESC
    ) AS category_price_rank
FROM products p
INNER JOIN categories c
    ON p.category_id = c.category_id
ORDER BY c.category_name, category_price_rank;


-- Q65. Find the most expensive product in each category

WITH ranked_products AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category_id,
        p.price,
        ROW_NUMBER() OVER (
            PARTITION BY p.category_id
            ORDER BY p.price DESC
        ) AS product_rank
    FROM products p
)
SELECT
    rp.product_id,
    rp.product_name,
    c.category_name,
    rp.price
FROM ranked_products rp
INNER JOIN categories c
    ON rp.category_id = c.category_id
WHERE rp.product_rank = 1
ORDER BY c.category_name;




-- ============================================================
-- SECTION G: ADVANCED SQL
-- ============================================================


-- Q66. Display the category hierarchy using a recursive CTE
--
-- This works because categories can have a parent_category_id.

WITH RECURSIVE category_tree AS (

    -- Starting point: top-level categories
    SELECT
        category_id,
        category_name,
        parent_category_id,
        1 AS category_level,
        category_name::TEXT AS category_path
    FROM categories
    WHERE parent_category_id IS NULL

    UNION ALL

    -- Find child categories
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ct.category_level + 1,
        ct.category_path || ' > ' || c.category_name
    FROM categories c
    INNER JOIN category_tree ct
        ON c.parent_category_id = ct.category_id
)

SELECT
    category_id,
    category_name,
    parent_category_id,
    category_level,
    category_path
FROM category_tree
ORDER BY category_path;


-- ============================================================
-- Q67. Create a view showing customer order summary
-- ============================================================

CREATE OR REPLACE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    COALESCE(ROUND(AVG(o.total_amount), 2), 0) AS average_order_value
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email;


-- Test the view
SELECT *
FROM customer_order_summary
ORDER BY total_spent DESC;


-- ============================================================
-- Q68. Create an accurate product performance view
-- ============================================================

CREATE OR REPLACE VIEW product_performance AS

WITH sales AS (
    SELECT
        product_id,
        SUM(quantity) AS total_quantity_sold
    FROM order_items
    GROUP BY product_id
),

ratings AS (
    SELECT
        product_id,
        ROUND(AVG(rating), 2) AS average_rating
    FROM reviews
    GROUP BY product_id
)

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.stock_quantity,
    COALESCE(s.total_quantity_sold, 0) AS total_quantity_sold,
    COALESCE(r.average_rating, 0) AS average_rating

FROM products p

LEFT JOIN categories c
    ON p.category_id = c.category_id

LEFT JOIN sales s
    ON p.product_id = s.product_id

LEFT JOIN ratings r
    ON p.product_id = r.product_id;



-- ============================================================
-- Q69. Create indexes for frequently searched columns
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_customers_email
ON customers(email);

CREATE INDEX IF NOT EXISTS idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX IF NOT EXISTS idx_orders_order_date
ON orders(order_date);

CREATE INDEX IF NOT EXISTS idx_products_category_id
ON products(category_id);

CREATE INDEX IF NOT EXISTS idx_order_items_product_id
ON order_items(product_id);

CREATE INDEX IF NOT EXISTS idx_reviews_product_id
ON reviews(product_id);


-- ============================================================
-- Q70. Check the execution plan for a customer search
-- ============================================================

EXPLAIN ANALYZE
SELECT *
FROM customers
WHERE email = 'aarav.sharma@gmail.com';


-- ============================================================
-- Q71. Check the execution plan for customer orders
-- ============================================================

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 1;


-- ============================================================
-- Q72. Find the top 3 products in each category
-- ============================================================

WITH ranked_products AS (

    SELECT
        p.product_id,
        p.product_name,
        p.category_id,
        p.price,

        ROW_NUMBER() OVER (
            PARTITION BY p.category_id
            ORDER BY p.price DESC
        ) AS product_rank

    FROM products p
)

SELECT
    rp.product_id,
    rp.product_name,
    c.category_name,
    rp.price,
    rp.product_rank
FROM ranked_products rp
INNER JOIN categories c
    ON rp.category_id = c.category_id
WHERE rp.product_rank <= 3
ORDER BY
    c.category_name,
    rp.product_rank;


-- ============================================================
-- Q73. Find the best-rated product
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating), 2) AS average_rating
FROM products p
INNER JOIN reviews r
    ON p.product_id = r.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY average_rating DESC
LIMIT 1;


-- ============================================================
-- Q74. Find the customer with the highest total spending
-- ============================================================

SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC
LIMIT 1;


-- ============================================================
-- Q75. Find the best-selling product by quantity
-- ============================================================

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 1;