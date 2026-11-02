-- 02_sample_data.sql
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
