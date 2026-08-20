from pathlib import Path
import zipfile, textwrap, os

base = Path("G31 FSD - Tasks\\Task 14 - System Design Question - Real-Time Traffic Estimation System\\Narasimha Naidu - G31 FSD")
base.mkdir(exist_ok=True)

schema = r"""-- 01_schema.sql
-- Run: CREATE DATABASE shopsphere_db; then connect to it and run this file.

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    city VARCHAR(100),
    country VARCHAR(100),
    registration_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'Active',
    CONSTRAINT customers_status_check
        CHECK (status IN ('Active', 'Inactive', 'Blocked'))
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    parent_category_id INT,
    CONSTRAINT fk_parent_category
        FOREIGN KEY (parent_category_id)
        REFERENCES categories(category_id)
        ON DELETE SET NULL
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    price NUMERIC(12,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    supplier_name VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id) REFERENCES categories(category_id),
    CONSTRAINT product_price_check CHECK (price > 0),
    CONSTRAINT product_stock_check CHECK (stock_quantity >= 0)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(20) DEFAULT 'Pending',
    shipping_city VARCHAR(100),
    shipping_country VARCHAR(100),
    total_amount NUMERIC(12,2) DEFAULT 0,
    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT order_status_check
        CHECK (order_status IN ('Pending','Processing','Shipped','Delivered','Cancelled')),
    CONSTRAINT order_amount_check CHECK (total_amount >= 0)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price NUMERIC(12,2) NOT NULL,
    discount NUMERIC(5,2) DEFAULT 0,
    CONSTRAINT fk_order_item_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_order_item_product
        FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT order_item_quantity_check CHECK (quantity > 0),
    CONSTRAINT order_item_price_check CHECK (unit_price > 0),
    CONSTRAINT order_item_discount_check CHECK (discount >= 0 AND discount <= 100)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'Pending',
    amount NUMERIC(12,2) NOT NULL,
    transaction_reference VARCHAR(150),
    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT payment_method_check
        CHECK (payment_method IN ('Credit Card','Debit Card','UPI','PayPal','Cash on Delivery')),
    CONSTRAINT payment_status_check
        CHECK (payment_status IN ('Pending','Completed','Failed','Refunded')),
    CONSTRAINT payment_amount_check CHECK (amount >= 0)
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,
    review_text TEXT,
    review_date DATE DEFAULT CURRENT_DATE,
    CONSTRAINT fk_review_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_review_product
        FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT review_rating_check CHECK (rating BETWEEN 1 AND 5)
);

-- Helpful indexes on foreign keys used frequently in joins.
CREATE INDEX idx_products_category_id ON products(category_id);
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
CREATE INDEX idx_payments_order_id ON payments(order_id);
CREATE INDEX idx_reviews_customer_id ON reviews(customer_id);
CREATE INDEX idx_reviews_product_id ON reviews(product_id);
"""

sample = r"""-- 02_sample_data.sql
-- Designed for the schema in 01_schema.sql.
-- Inserts 20 customers, 10 categories, 30 products,
-- 40 orders, 80 order items, 30 payments and 25 reviews.

TRUNCATE TABLE reviews, payments, order_items, orders, products, categories, customers
RESTART IDENTITY CASCADE;

-- 20 customers. Customers 16-20 intentionally have no orders.
INSERT INTO customers
(first_name, last_name, email, phone, city, country, registration_date, status)
SELECT
    (ARRAY['Rahul','Priya','Arun','Sneha','Vikram','Anjali','Kiran','Meena','Ravi','Divya',
           'Asha','Rohan','Neha','Suresh','Pooja','Manoj','Kavya','Aditya','Nisha','Varun'])[g],
    (ARRAY['Kumar','Sharma','Reddy','Patel','Singh','Rao','Naidu','Iyer','Verma','Das',
           'Gupta','Mishra','Nair','Joshi','Mehta','Yadav','Kapoor','Bose','Shah','Pillai'])[g],
    'customer' || g || '@example.com',
    CASE WHEN g IN (4, 9, 14, 19) THEN NULL ELSE '98' || LPAD(g::text, 8, '0') END,
    (ARRAY['Hyderabad','Mumbai','Chennai','Bengaluru','Delhi','Pune','Kolkata','Ahmedabad','Jaipur','Nashik'])[((g-1)%10)+1],
    CASE WHEN g IN (3, 8, 13, 18) THEN 'USA' ELSE 'India' END,
    DATE '2025-01-01' + (g * 15),
    CASE
        WHEN g IN (4, 9, 14, 19) THEN 'Inactive'
        WHEN g = 20 THEN 'Blocked'
        ELSE 'Active'
    END
FROM generate_series(1,20) AS s(g);

-- 10 categories.
INSERT INTO categories (category_name, description, parent_category_id) VALUES
('Electronics','Electronic products',NULL),
('Computers','Computers and accessories',1),
('Laptops','Laptop computers',2),
('Desktops','Desktop computers',2),
('Mobile Devices','Mobile technology',1),
('Smartphones','Smartphones',5),
('Tablets','Tablets and e-readers',5),
('Accessories','Computer and mobile accessories',1),
('Audio','Headphones and speakers',8),
('Wearables','Smart watches and fitness devices',1);

-- 30 products. Products 21-30 are never ordered.
INSERT INTO products
(product_name, category_id, price, stock_quantity, supplier_name, created_at, is_active)
SELECT
    (ARRAY[
      'iPhone 15','Galaxy S24','Pixel 9','OnePlus 13','Dell Laptop',
      'HP Laptop','Lenovo ThinkPad','MacBook Air','Gaming Desktop','Office Desktop',
      'iPad Air','Galaxy Tab','Redmi Tablet','Wireless Mouse','Mechanical Keyboard',
      'USB-C Hub','Bluetooth Speaker','Noise Cancelling Headphones','Smart Watch','Fitness Band',
      '4K Monitor','Webcam Pro','Portable SSD','Gaming Headset','Power Bank',
      'Wireless Charger','Tablet Stand','Laptop Bag','Smart Ring','VR Headset'
    ])[g],
    CASE
      WHEN g IN (1,2,3,4) THEN 6
      WHEN g IN (5,6,7,8) THEN 3
      WHEN g IN (9,10) THEN 4
      WHEN g IN (11,12,13) THEN 7
      WHEN g IN (14,15,16,17,18) THEN 8
      WHEN g IN (19,20) THEN 10
      WHEN g IN (21,22,23,24,25,26,27,28,29,30) THEN 9
    END,
    CASE
      WHEN g = 1 THEN 65000
      WHEN g = 2 THEN 55000
      WHEN g = 3 THEN 60000
      WHEN g = 4 THEN 45000
      WHEN g BETWEEN 5 AND 8 THEN 40000 + g*1800
      WHEN g BETWEEN 9 AND 10 THEN 30000 + g*1200
      WHEN g BETWEEN 11 AND 13 THEN 18000 + g*700
      WHEN g BETWEEN 14 AND 20 THEN 700 + g*350
      ELSE 500 + g*250
    END,
    CASE
      WHEN g IN (6,18,21,24) THEN 5
      WHEN g IN (10,20,25) THEN 9
      ELSE 20 + g
    END,
    (ARRAY['TechWorld','MegaStore','DigitalHub','SmartSupply','GlobalTech'])[((g-1)%5)+1],
    TIMESTAMP '2026-01-01' + (g * INTERVAL '3 days'),
    CASE WHEN g IN (26,29) THEN FALSE ELSE TRUE END
FROM generate_series(1,30) AS s(g);

-- 40 orders. Customers 1-15 have orders; 16-20 do not.
INSERT INTO orders
(customer_id, order_date, order_status, shipping_city, shipping_country, total_amount)
SELECT
    ((g - 1) % 15) + 1,
    TIMESTAMP '2026-02-01' + (g * INTERVAL '5 days'),
    CASE
      WHEN g IN (7,16,25,34) THEN 'Cancelled'
      WHEN g IN (5,13,22,31) THEN 'Pending'
      WHEN g IN (4,12,20,29,37) THEN 'Processing'
      WHEN g IN (3,10,18,27,35) THEN 'Shipped'
      ELSE 'Delivered'
    END,
    (ARRAY['Hyderabad','Mumbai','Chennai','Bengaluru','Delhi','Pune','Kolkata','Ahmedabad','Jaipur','Nashik'])[(((g-1)%10)+1)],
    'India',
    0
FROM generate_series(1,40) AS s(g);

-- Exactly 80 order items: 2 per order.
-- Only products 1-20 are used, leaving products 21-30 never ordered.
INSERT INTO order_items
(order_id, product_id, quantity, unit_price, discount)
SELECT
    o.order_id,
    p.product_id,
    1 + ((o.order_id + k) % 4),
    p.price,
    CASE WHEN (o.order_id + k) % 5 = 0 THEN 10 ELSE 0 END
FROM orders o
CROSS JOIN generate_series(1,2) AS k
JOIN products p
  ON p.product_id = (((o.order_id * 2 + k - 1) % 20) + 1);

-- Calculate order totals from order items.
UPDATE orders o
SET total_amount = x.total_amount
FROM (
    SELECT
        order_id,
        ROUND(SUM(quantity * unit_price * (1 - discount/100.0)), 2) AS total_amount
    FROM order_items
    GROUP BY order_id
) x
WHERE o.order_id = x.order_id;

-- 30 payments for the first 30 orders.
INSERT INTO payments
(order_id, payment_date, payment_method, payment_status, amount, transaction_reference)
SELECT
    o.order_id,
    o.order_date + INTERVAL '1 day',
    (ARRAY['Credit Card','Debit Card','UPI','PayPal','Cash on Delivery'])[(((o.order_id-1)%5)+1)],
    CASE
      WHEN o.order_status = 'Cancelled' THEN 'Refunded'
      WHEN o.order_id IN (6,14,23) THEN 'Failed'
      WHEN o.order_id IN (5,13,22) THEN 'Pending'
      ELSE 'Completed'
    END,
    o.total_amount,
    'TXN-' || LPAD(o.order_id::text, 6, '0')
FROM orders o
WHERE o.order_id <= 30;

-- 25 reviews. Products 26-30 intentionally have no reviews.
INSERT INTO reviews
(customer_id, product_id, rating, review_text, review_date)
SELECT
    ((g-1)%15)+1,
    ((g-1)%25)+1,
    ((g+1)%5)+1,
    CASE ((g+1)%5)+1
      WHEN 5 THEN 'Excellent product!'
      WHEN 4 THEN 'Very good product.'
      WHEN 3 THEN 'Average experience.'
      WHEN 2 THEN 'Could be better.'
      ELSE 'Poor experience.'
    END,
    DATE '2026-04-01' + g
FROM generate_series(1,25) AS s(g);

-- Verification counts.
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews
ORDER BY table_name;
"""

queries = r"""-- 03_queries.sql
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
"""

views = r"""-- 04_views.sql

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
"""

materialized = r"""-- 05_materialized_views.sql

DROP MATERIALIZED VIEW IF EXISTS monthly_sales_summary;
DROP MATERIALIZED VIEW IF EXISTS executive_sales_dashboard;

CREATE MATERIALIZED VIEW monthly_sales_summary AS
SELECT
    DATE_TRUNC('month', o.order_date)::DATE AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_products_sold,
    SUM(oi.quantity * oi.unit_price * (1-oi.discount/100.0)) AS total_revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY DATE_TRUNC('month', o.order_date);

CREATE MATERIALIZED VIEW executive_sales_dashboard AS
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', o.order_date)::DATE AS sales_month,
        SUM(oi.quantity * oi.unit_price * (1-oi.discount/100.0)) AS total_revenue,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.quantity) AS total_products_sold,
        COUNT(DISTINCT o.customer_id) AS total_customers,
        AVG(o.total_amount) AS average_order_value
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY DATE_TRUNC('month', o.order_date)
)
SELECT
    sales_month,
    ROUND(total_revenue,2) AS total_revenue,
    total_orders,
    total_customers,
    total_products_sold,
    ROUND(average_order_value,2) AS average_order_value
FROM monthly;

CREATE INDEX idx_executive_sales_dashboard_month
ON executive_sales_dashboard(sales_month);

SELECT * FROM monthly_sales_summary ORDER BY sales_month;
SELECT * FROM executive_sales_dashboard ORDER BY sales_month;

-- After new data is inserted:
-- REFRESH MATERIALIZED VIEW monthly_sales_summary;
-- REFRESH MATERIALIZED VIEW executive_sales_dashboard;

-- Normal VIEW:
--   Stores query definition.
--   Always reads current base-table data.
--
-- Materialized VIEW:
--   Stores the result physically.
--   Usually faster for repeated reporting.
--   Can become stale.
--   Requires REFRESH.
"""

indexes = r"""-- 06_indexes.sql

-- Required assignment indexes.
CREATE INDEX IF NOT EXISTS idx_customers_email
ON customers(email);

CREATE INDEX IF NOT EXISTS idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX IF NOT EXISTS idx_orders_order_date
ON orders(order_date);

CREATE INDEX IF NOT EXISTS idx_orders_status_date
ON orders(order_status, order_date);

CREATE INDEX IF NOT EXISTS idx_products_category_price
ON products(category_id, price);

-- Useful indexes for joins/searches.
CREATE INDEX IF NOT EXISTS idx_order_items_order_product
ON order_items(order_id, product_id);

CREATE INDEX IF NOT EXISTS idx_reviews_product_rating
ON reviews(product_id, rating);

-- Performance case study.
EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 10
  AND order_status = 'Delivered'
  AND order_date >= DATE '2026-01-01';

-- Index specifically useful for the case-study predicate.
CREATE INDEX IF NOT EXISTS idx_orders_customer_status_date
ON orders(customer_id, order_status, order_date);

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 10
  AND order_status = 'Delivered'
  AND order_date >= DATE '2026-01-01';

-- Bonus: partial index for active products.
CREATE INDEX IF NOT EXISTS idx_active_products_category
ON products(category_id)
WHERE is_active = TRUE;

-- Bonus: prevent the same customer reviewing the same product twice.
CREATE UNIQUE INDEX IF NOT EXISTS uq_customer_product_review
ON reviews(customer_id, product_id);

-- To remove an index:
-- DROP INDEX IF EXISTS idx_orders_customer_status_date;
"""

procedures = r"""-- 07_procedures.sql
-- PostgreSQL procedures.

-- 70. Update product stock.
CREATE OR REPLACE PROCEDURE update_product_stock(
    p_product_id INT,
    p_quantity_change INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    current_stock INT;
BEGIN
    SELECT stock_quantity
    INTO current_stock
    FROM products
    WHERE product_id = p_product_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Product % does not exist', p_product_id;
    END IF;

    IF current_stock + p_quantity_change < 0 THEN
        RAISE EXCEPTION
            'Insufficient stock. Current stock: %, requested change: %',
            current_stock, p_quantity_change;
    END IF;

    UPDATE products
    SET stock_quantity = stock_quantity + p_quantity_change
    WHERE product_id = p_product_id;
END;
$$;

-- Example:
-- CALL update_product_stock(1, -2);
-- CALL update_product_stock(1, 5);


-- 71. Cancel an order and restore stock.
CREATE OR REPLACE PROCEDURE cancel_order(
    p_order_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status VARCHAR(20);
BEGIN
    SELECT order_status
    INTO v_status
    FROM orders
    WHERE order_id = p_order_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % does not exist', p_order_id;
    END IF;

    IF v_status = 'Delivered' THEN
        RAISE EXCEPTION 'Delivered order % cannot be cancelled', p_order_id;
    END IF;

    IF v_status = 'Cancelled' THEN
        RAISE EXCEPTION 'Order % is already cancelled', p_order_id;
    END IF;

    UPDATE orders
    SET order_status = 'Cancelled'
    WHERE order_id = p_order_id;

    UPDATE products p
    SET stock_quantity = p.stock_quantity + x.quantity
    FROM (
        SELECT product_id, SUM(quantity) AS quantity
        FROM order_items
        WHERE order_id = p_order_id
        GROUP BY product_id
    ) x
    WHERE p.product_id = x.product_id;
END;
$$;


-- 72. Process payment.
CREATE OR REPLACE PROCEDURE process_payment(
    p_order_id INT,
    p_payment_method VARCHAR(30),
    p_payment_amount NUMERIC(12,2),
    p_transaction_reference VARCHAR(150)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM orders WHERE order_id = p_order_id
    ) THEN
        RAISE EXCEPTION 'Order % does not exist', p_order_id;
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


-- 73. Mark old Processing orders as delayed.
-- The schema has no "Delayed" order status, so the assignment's
-- wording is represented by a notice rather than an invalid status.
CREATE OR REPLACE PROCEDURE mark_old_processing_orders(
    p_days INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_count INT;
BEGIN
    UPDATE orders
    SET order_status = 'Shipped'
    WHERE order_status = 'Processing'
      AND order_date < CURRENT_TIMESTAMP - make_interval(days => p_days);

    GET DIAGNOSTICS v_count = ROW_COUNT;

    RAISE NOTICE '% old Processing order(s) were advanced to Shipped status.', v_count;
END;
$$;

-- Examples:
-- CALL cancel_order(7);
-- CALL process_payment(31, 'UPI', 1500, 'TXN-MANUAL-31');
-- CALL mark_old_processing_orders(10);
"""

functions = r"""-- 08_functions.sql

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
"""

ctes = r"""-- 09_ctes.sql

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
"""

readme = r"""# ShopSphere E-Commerce Database

## Project
Advanced SQL Database Assignment using PostgreSQL.

## Files

- `01_schema.sql` - database tables, primary keys, foreign keys and constraints
- `02_sample_data.sql` - sample data
- `03_queries.sql` - assignment queries 1-120
- `04_views.sql` - views and final customer performance report
- `05_materialized_views.sql` - materialized reporting views
- `06_indexes.sql` - indexes and EXPLAIN ANALYZE examples
- `07_procedures.sql` - PostgreSQL stored procedures
- `08_functions.sql` - PostgreSQL functions
- `09_ctes.sql` - CTE and recursive CTE examples

## Software

PostgreSQL + pgAdmin 4.

## Execution Order

1. Create database `shopsphere_db`.
2. Connect to `shopsphere_db`.
3. Run `01_schema.sql`.
4. Run `02_sample_data.sql`.
5. Run `03_queries.sql`.
6. Run `04_views.sql`.
7. Run `05_materialized_views.sql`.
8. Run `06_indexes.sql`.
9. Run `07_procedures.sql`.
10. Run `08_functions.sql`.
11. Run `09_ctes.sql`.

## Important

Some queries are demonstration queries. For example, transaction examples containing
`ROLLBACK` are intentionally rolled back and therefore do not permanently insert data.

The assignment uses PostgreSQL-specific features such as PL/pgSQL procedures,
functions, recursive CTEs and materialized views.
"""

files = {
    "01_schema.sql": schema,
    "02_sample_data.sql": sample,
    "03_queries.sql": queries,
    "04_views.sql": views,
    "05_materialized_views.sql": materialized,
    "06_indexes.sql": indexes,
    "07_procedures.sql": procedures,
    "08_functions.sql": functions,
    "09_ctes.sql": ctes,
    "README.md": readme,
}

for name, content in files.items():
    (base / name).write_text(content, encoding="utf-8")

zip_path = Path("/mnt/data/shopsphere_sql_assignment.zip")
with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as z:
    for name in files:
        z.write(base / name, arcname=name)

print("Created files:")
for name in files:
    print(f" - {name}")
print(f"\nZIP: {zip_path}")
