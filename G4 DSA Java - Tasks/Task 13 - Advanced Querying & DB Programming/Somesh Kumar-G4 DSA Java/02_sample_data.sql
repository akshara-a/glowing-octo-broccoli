-- =========================================================
-- TASK 13 - ADVANCED QUERYING & DB PROGRAMMING
-- ShopSphere Sample Data
-- =========================================================

-- =========================================================
-- 1. CATEGORIES
-- Minimum required: 10
-- =========================================================

INSERT INTO categories
(category_name, description, parent_category_id)
VALUES
('Electronics', 'Electronic products', NULL),
('Computers', 'Computers and computer accessories', 1),
('Laptops', 'Laptop computers', 2),
('Mobile Devices', 'Smartphones and tablets', 1),
('Clothing', 'Clothing and fashion products', NULL),
('Books', 'Books and educational material', NULL),
('Home & Kitchen', 'Home and kitchen products', NULL),
('Sports', 'Sports and fitness products', NULL),
('Fiction', 'Fiction books', 6),
('Kitchen Accessories', 'Kitchen accessories and appliances', 7);


-- =========================================================
-- 2. CUSTOMERS
-- Minimum required: 20
-- Includes customers with different cities/countries
-- Includes Active, Inactive and Blocked customers
-- Customers 19 and 20 have no orders
-- =========================================================

INSERT INTO customers
(first_name, last_name, email, phone, address, city, country,
 registration_date, status)
VALUES
('Rahul', 'Sharma', 'rahul.sharma@example.com', '9876543210',
 '12 MG Road', 'Hyderabad', 'India', '2025-01-10', 'Active'),

('Priya', 'Reddy', 'priya.reddy@example.com', '9876543211',
 '45 Banjara Hills', 'Hyderabad', 'India', '2025-01-15', 'Active'),

('Arjun', 'Kumar', 'arjun.kumar@example.com', '9876543212',
 '78 Anna Nagar', 'Chennai', 'India', '2025-02-05', 'Active'),

('Sneha', 'Patel', 'sneha.patel@example.com', '9876543213',
 '23 Koregaon Park', 'Pune', 'India', '2025-02-12', 'Active'),

('Vikram', 'Singh', 'vikram.singh@example.com', '9876543214',
 '56 Sector 17', 'Delhi', 'India', '2025-03-01', 'Inactive'),

('Ananya', 'Das', 'ananya.das@example.com', '9876543215',
 '89 Salt Lake', 'Kolkata', 'India', '2025-03-10', 'Active'),

('Kiran', 'Rao', 'kiran.rao@example.com', '9876543216',
 '34 Hitech City', 'Hyderabad', 'India', '2025-03-15', 'Active'),

('Meera', 'Nair', 'meera.nair@example.com', '9876543217',
 '67 MG Road', 'Bangalore', 'India', '2025-03-20', 'Active'),

('Rohit', 'Verma', 'rohit.verma@example.com', '9876543218',
 '90 Gomti Nagar', 'Lucknow', 'India', '2025-04-01', 'Active'),

('Divya', 'Iyer', 'divya.iyer@example.com', '9876543219',
 '11 T Nagar', 'Chennai', 'India', '2025-04-10', 'Active'),

('Amit', 'Joshi', 'amit.joshi@example.com', '9876543220',
 '22 Park Street', 'Kolkata', 'India', '2025-04-20', 'Active'),

('Neha', 'Kapoor', 'neha.kapoor@example.com', '9876543221',
 '18 Connaught Place', 'Delhi', 'India', '2025-05-01', 'Active'),

('Sanjay', 'Mehta', 'sanjay.mehta@example.com', '9876543222',
 '44 FC Road', 'Pune', 'India', '2025-05-15', 'Inactive'),

('Pooja', 'Shah', 'pooja.shah@example.com', '9876543223',
 '55 CG Road', 'Ahmedabad', 'India', '2025-06-01', 'Active'),

('Ravi', 'Krishna', 'ravi.krishna@example.com', '9876543224',
 '66 Banjara Hills', 'Hyderabad', 'India', '2025-06-15', 'Active'),

('Swathi', 'Rao', 'swathi.rao@example.com', '9876543225',
 '77 Jubilee Hills', 'Hyderabad', 'India', '2025-07-01', 'Active'),

('Manoj', 'Gupta', 'manoj.gupta@example.com', '9876543226',
 '88 Civil Lines', 'Jaipur', 'India', '2025-07-15', 'Blocked'),

('Lakshmi', 'Menon', 'lakshmi.menon@example.com', '9876543227',
 '99 MG Road', 'Kochi', 'India', '2025-08-01', 'Active'),

('John', 'Smith', 'john.smith@example.com', '9876543228',
 '10 Main Street', 'New York', 'USA', '2025-08-15', 'Active'),

('Emma', 'Brown', 'emma.brown@example.com', NULL,
 '20 Oxford Street', 'London', 'UK', '2025-09-01', 'Inactive');


-- =========================================================
-- 3. PRODUCTS
-- Minimum required: 30
-- Includes high/low stock and products with no orders
-- =========================================================

INSERT INTO products
(product_name, category_id, price, stock_quantity, supplier_name,
 is_active)
VALUES
('Laptop Pro 15', 3, 75000.00, 25, 'TechWorld', TRUE),
('Wireless Headphones', 1, 3500.00, 50, 'SoundMax', TRUE),
('Smartphone X', 4, 45000.00, 30, 'MobileHub', TRUE),
('Mechanical Keyboard', 2, 4500.00, 40, 'KeyWorks', TRUE),
('Cotton T-Shirt', 5, 799.00, 100, 'FashionCo', TRUE),
('Denim Jeans', 5, 1999.00, 75, 'FashionCo', TRUE),
('Running Shoes', 8, 2999.00, 60, 'SportFit', TRUE),
('Java Programming', 6, 899.00, 35, 'BookHouse', TRUE),
('Database Systems', 6, 1299.00, 30, 'BookHouse', TRUE),
('Coffee Maker', 7, 4999.00, 20, 'HomePro', TRUE),
('Non-Stick Cookware Set', 7, 3499.00, 25, 'HomePro', TRUE),
('Yoga Mat', 8, 999.00, 80, 'SportFit', TRUE),
('Laptop Backpack', 2, 2499.00, 45, 'BagWorks', TRUE),
('Smartwatch S', 4, 6999.00, 15, 'MobileHub', TRUE),
('Bluetooth Speaker', 1, 2999.00, 55, 'SoundMax', TRUE),
('Casual Shirt', 5, 1299.00, 90, 'FashionCo', TRUE),
('Python Programming', 6, 1099.00, 40, 'BookHouse', TRUE),
('Air Fryer', 7, 5999.00, 18, 'HomePro', TRUE),
('Football', 8, 1499.00, 70, 'SportFit', TRUE),
('Cricket Bat', 8, 3999.00, 12, 'SportFit', TRUE),
('Tablet Pro', 4, 28999.00, 20, 'MobileHub', TRUE),
('USB-C Hub', 2, 1799.00, 35, 'TechWorld', TRUE),
('Gaming Mouse', 2, 2499.00, 8, 'KeyWorks', TRUE),
('Web Development', 6, 1399.00, 22, 'BookHouse', TRUE),
('Water Bottle', 8, 699.00, 5, 'SportFit', TRUE),
('LED Desk Lamp', 7, 1599.00, 28, 'HomePro', TRUE),
('Power Bank', 1, 1999.00, 45, 'TechWorld', TRUE),
('Formal Trousers', 5, 2199.00, 65, 'FashionCo', TRUE),
('Wireless Mouse', 2, 1299.00, 6, 'KeyWorks', TRUE),
('Cookbook', 6, 799.00, 33, 'BookHouse', TRUE);


-- =========================================================
-- 4. ORDERS
-- Minimum required: 40
-- Includes Pending, Processing, Shipped, Delivered, Cancelled
-- =========================================================

INSERT INTO orders
(customer_id, order_date, order_status, shipping_city,
 shipping_country, total_amount)
VALUES
(1,  '2026-01-10 10:30:00', 'Delivered',  'Hyderabad', 'India', 78500.00),
(2,  '2026-01-15 14:20:00', 'Delivered',  'Hyderabad', 'India', 3597.00),
(3,  '2026-01-20 09:15:00', 'Shipped',    'Chennai',   'India', 46999.00),
(4,  '2026-02-10 16:45:00', 'Delivered',  'Pune',      'India', 3998.00),
(5,  '2026-02-20 11:10:00', 'Pending',    'Delhi',     'India', 6598.00),
(6,  '2026-03-05 13:25:00', 'Delivered',  'Kolkata',   'India', 2997.00),
(7,  '2026-03-12 17:30:00', 'Shipped',    'Hyderabad', 'India', 79500.00),
(8,  '2026-03-20 10:00:00', 'Delivered',  'Bangalore', 'India', 4498.00),
(9,  '2026-04-01 15:40:00', 'Pending',    'Lucknow',   'India', 7698.00),
(10, '2026-04-05 12:15:00', 'Delivered',  'Chennai',   'India', 9499.00),
(11, '2026-04-10 09:30:00', 'Processing', 'Kolkata',   'India', 9999.00),
(12, '2026-04-15 14:00:00', 'Delivered',  'Delhi',     'India', 4298.00),
(13, '2026-04-20 16:20:00', 'Cancelled',  'Pune',      'India', 30098.00),
(14, '2026-05-01 11:45:00', 'Delivered',  'Pune',      'India', 4797.00),
(15, '2026-05-05 13:10:00', 'Shipped',    'Chennai',   'India', 2498.00),
(16, '2026-05-10 15:30:00', 'Delivered',  'Kolkata',   'India', 3797.00),
(17, '2026-05-15 10:20:00', 'Processing', 'Jaipur',    'India', 4698.00),
(18, '2026-05-20 17:00:00', 'Delivered',  'Hyderabad', 'India', 6297.00),
(1,  '2026-06-01 09:00:00', 'Delivered',  'Hyderabad', 'India', 3997.00),
(2,  '2026-06-05 12:30:00', 'Shipped',    'Hyderabad', 'India', 3998.00),
(3,  '2026-06-10 14:15:00', 'Delivered',  'Chennai',   'India', 77499.00),
(4,  '2026-06-15 16:00:00', 'Cancelled',  'Pune',      'India', 47999.00),
(5,  '2026-06-20 11:30:00', 'Delivered',  'Delhi',     'India', 3696.00),
(6,  '2026-07-01 10:15:00', 'Processing', 'Kolkata',   'India', 4198.00),
(7,  '2026-07-05 13:45:00', 'Delivered',  'Hyderabad', 'India', 2698.00),
(8,  '2026-07-10 15:20:00', 'Shipped',    'Bangalore', 'India', 10998.00),
(9,  '2026-07-15 09:45:00', 'Delivered',  'Lucknow',   'India', 6999.00),
(10, '2026-07-20 12:10:00', 'Cancelled',  'Chennai',   'India', 4498.00),
(11, '2026-08-01 14:30:00', 'Delivered',  'Kolkata',   'India', 5098.00),
(12, '2026-08-05 16:15:00', 'Pending',    'Delhi',     'India', 1998.00),
(13, '2026-08-10 10:30:00', 'Delivered',  'Pune',      'India', 2697.00),
(14, '2026-08-12 11:00:00', 'Processing', 'Ahmedabad', 'India', 5499.00),
(15, '2026-08-15 13:20:00', 'Delivered',  'Hyderabad', 'India', 35998.00),
(16, '2026-08-18 15:45:00', 'Shipped',    'Hyderabad', 'India', 4897.00),
(17, '2026-08-20 10:10:00', 'Cancelled',  'Jaipur',    'India', 2697.00),
(18, '2026-08-21 12:40:00', 'Delivered',  'Kochi',     'India', 7499.00),
(1,  '2026-08-22 14:50:00', 'Processing', 'Hyderabad', 'India', 3498.00),
(2,  '2026-08-23 09:25:00', 'Delivered',  'Hyderabad', 'India', 10998.00),
(3,  '2026-08-24 16:35:00', 'Shipped',    'Chennai',   'India', 5498.00),
(4,  '2026-08-25 11:15:00', 'Pending',    'Pune',      'India', 2698.00);


-- =========================================================
-- 5. ORDER ITEMS
-- Minimum required: 80
-- =========================================================

INSERT INTO order_items
(order_id, product_id, quantity, unit_price, discount)
VALUES
(1,  1, 1, 75000.00, 0),
(1,  2, 1, 3500.00, 0),

(2,  5, 2, 799.00, 0),
(2,  6, 1, 1999.00, 0),

(3,  3, 1, 45000.00, 0),
(3,  27, 1, 1999.00, 0),

(4,  7, 1, 2999.00, 0),
(4,  12, 1, 999.00, 0),

(5,  10, 1, 4999.00, 0),
(5,  26, 1, 1599.00, 0),

(6,  8, 1, 899.00, 0),
(6,  9, 1, 1299.00, 0),
(6,  30, 1, 799.00, 0),

(7,  1, 1, 75000.00, 0),
(7,  4, 1, 4500.00, 0),

(8,  11, 1, 3499.00, 0),
(8,  12, 1, 999.00, 0),

(9,  14, 1, 6999.00, 0),
(9,  25, 1, 699.00, 0),

(10, 18, 1, 5999.00, 0),
(10, 2, 1, 3500.00, 0),

(11, 2, 2, 3500.00, 0),
(11, 15, 1, 2999.00, 0),

(12, 13, 1, 2499.00, 0),
(12, 22, 1, 1799.00, 0),

(13, 21, 1, 28999.00, 0),
(13, 17, 1, 1099.00, 0),

(14, 16, 2, 1299.00, 0),
(14, 28, 1, 2199.00, 0),

(15, 17, 1, 1099.00, 0),
(15, 24, 1, 1399.00, 0),

(16, 19, 2, 1499.00, 0),
(16, 5, 1, 799.00, 0),

(17, 20, 1, 3999.00, 0),
(17, 25, 1, 699.00, 0),

(18, 23, 2, 2499.00, 0),
(18, 29, 1, 1299.00, 0),

(19, 26, 2, 1599.00, 0),
(19, 30, 1, 799.00, 0),

(20, 27, 2, 1999.00, 0),

(21, 1, 1, 75000.00, 0),
(21, 13, 1, 2499.00, 0),

(22, 3, 1, 45000.00, 0),
(22, 15, 1, 2999.00, 0),

(23, 5, 3, 799.00, 0),
(23, 16, 1, 1299.00, 0),

(24, 6, 1, 1999.00, 0),
(24, 28, 1, 2199.00, 0),

(25, 9, 1, 1299.00, 0),
(25, 24, 1, 1399.00, 0),

(26, 10, 1, 4999.00, 0),
(26, 18, 1, 5999.00, 0),

(27, 4, 1, 4500.00, 0),
(27, 23, 1, 2499.00, 0),

(28, 7, 1, 2999.00, 0),
(28, 19, 1, 1499.00, 0),

(29, 11, 1, 3499.00, 0),
(29, 26, 1, 1599.00, 0),

(30, 8, 1, 899.00, 0),
(30, 17, 1, 1099.00, 0),

(31, 12, 2, 999.00, 0),
(31, 25, 1, 699.00, 0),

(32, 2, 1, 3500.00, 0),
(32, 27, 1, 1999.00, 0),

(33, 14, 1, 6999.00, 0),
(33, 21, 1, 28999.00, 0),

(34, 22, 2, 1799.00, 0),
(34, 29, 1, 1299.00, 0),

(35, 30, 2, 799.00, 0),
(35, 17, 1, 1099.00, 0),

(36, 15, 1, 2999.00, 0),
(36, 4, 1, 4500.00, 0),

(37, 28, 1, 2199.00, 0),
(37, 16, 1, 1299.00, 0),

(38, 18, 1, 5999.00, 0),
(38, 10, 1, 4999.00, 0),

(39, 20, 1, 3999.00, 0),
(39, 19, 1, 1499.00, 0),

(40, 24, 1, 1399.00, 0),
(40, 9, 1, 1299.00, 0);


-- =========================================================
-- 6. PAYMENTS
-- Minimum required: 30
-- Includes Completed, Pending, Failed and Refunded
-- =========================================================

INSERT INTO payments
(order_id, payment_date, payment_method, payment_status,
 amount, transaction_reference)
VALUES
(1,  '2026-01-10 10:35:00', 'Credit Card', 'Completed',
 78500.00, 'TXN10001'),

(2,  '2026-01-15 14:25:00', 'UPI', 'Completed',
 3597.00, 'TXN10002'),

(3,  '2026-01-20 09:20:00', 'Debit Card', 'Completed',
 46999.00, 'TXN10003'),

(4,  '2026-02-10 16:50:00', 'UPI', 'Completed',
 3998.00, 'TXN10004'),

(5,  '2026-02-20 11:15:00', 'Credit Card', 'Pending',
 6598.00, 'TXN10005'),

(6,  '2026-03-05 13:30:00', 'UPI', 'Completed',
 2997.00, 'TXN10006'),

(7,  '2026-03-12 17:35:00', 'Credit Card', 'Completed',
 79500.00, 'TXN10007'),

(8,  '2026-03-20 10:05:00', 'Debit Card', 'Completed',
 4498.00, 'TXN10008'),

(9,  '2026-04-01 15:45:00', 'UPI', 'Pending',
 7698.00, 'TXN10009'),

(10, '2026-04-05 12:20:00', 'Credit Card', 'Completed',
 9499.00, 'TXN10010'),

(11, '2026-04-10 09:35:00', 'PayPal', 'Completed',
 9999.00, 'TXN10011'),

(12, '2026-04-15 14:05:00', 'UPI', 'Completed',
 4298.00, 'TXN10012'),

(13, '2026-04-20 16:25:00', 'Credit Card', 'Refunded',
 30098.00, 'TXN10013'),

(14, '2026-05-01 11:50:00', 'Debit Card', 'Completed',
 4797.00, 'TXN10014'),

(15, '2026-05-05 13:15:00', 'UPI', 'Completed',
 2498.00, 'TXN10015'),

(16, '2026-05-10 15:35:00', 'Credit Card', 'Completed',
 3797.00, 'TXN10016'),

(17, '2026-05-15 10:25:00', 'UPI', 'Failed',
 4698.00, 'TXN10017'),

(18, '2026-05-20 17:05:00', 'Credit Card', 'Completed',
 6297.00, 'TXN10018'),

(19, '2026-06-01 09:05:00', 'UPI', 'Completed',
 3997.00, 'TXN10019'),

(20, '2026-06-05 12:35:00', 'Debit Card', 'Completed',
 3998.00, 'TXN10020'),

(21, '2026-06-10 14:20:00', 'Credit Card', 'Completed',
 77499.00, 'TXN10021'),

(22, '2026-06-15 16:05:00', 'UPI', 'Refunded',
 47999.00, 'TXN10022'),

(23, '2026-06-20 11:35:00', 'Debit Card', 'Completed',
 3696.00, 'TXN10023'),

(24, '2026-07-01 10:20:00', 'UPI', 'Completed',
 4198.00, 'TXN10024'),

(25, '2026-07-05 13:50:00', 'Credit Card', 'Completed',
 2698.00, 'TXN10025'),

(26, '2026-07-10 15:25:00', 'Debit Card', 'Completed',
 10998.00, 'TXN10026'),

(27, '2026-07-15 09:50:00', 'UPI', 'Completed',
 6999.00, 'TXN10027'),

(28, '2026-07-20 12:15:00', 'Credit Card', 'Failed',
 4498.00, 'TXN10028'),

(29, '2026-08-01 14:35:00', 'UPI', 'Completed',
 5098.00, 'TXN10029'),

(30, '2026-08-05 16:20:00', 'Debit Card', 'Completed',
 1998.00, 'TXN10030');


-- =========================================================
-- 7. REVIEWS
-- Minimum required: 25
-- Includes different ratings and products without reviews
-- =========================================================

INSERT INTO reviews
(customer_id, product_id, rating, review_text, review_date)
VALUES
(1,  1, 5, 'Excellent laptop with great performance', '2026-01-20'),
(1,  2, 4, 'Very good sound quality', '2026-01-21'),
(2,  5, 5, 'Comfortable and good quality', '2026-01-25'),
(2,  6, 4, 'Good jeans for the price', '2026-01-26'),
(3,  3, 5, 'Amazing smartphone', '2026-02-01'),
(4,  7, 4, 'Comfortable for running', '2026-02-12'),
(5,  10, 5, 'Makes excellent coffee', '2026-02-22'),
(6,  8, 4, 'Good book for beginners', '2026-03-10'),
(7,  1, 5, 'Powerful laptop', '2026-03-15'),
(8,  12, 4, 'Good yoga mat', '2026-03-25'),
(9,  9, 5, 'Very useful database book', '2026-04-05'),
(10, 11, 4, 'Good cookware set', '2026-04-10'),
(11, 15, 5, 'Great speaker quality', '2026-04-15'),
(12, 14, 4, 'Useful smartwatch', '2026-04-20'),
(13, 21, 5, 'Excellent tablet', '2026-04-25'),
(14, 18, 4, 'Air fryer works well', '2026-05-05'),
(15, 20, 5, 'Good cricket bat', '2026-05-10'),
(16, 23, 4, 'Good gaming mouse', '2026-05-15'),
(17, 28, 3, 'Decent formal trousers', '2026-05-20'),
(18, 17, 5, 'Excellent programming book', '2026-06-01'),
(1,  24, 4, 'Helpful web development book', '2026-06-05'),
(3,  4, 5, 'Excellent keyboard', '2026-06-10'),
(6,  19, 4, 'Good football', '2026-06-15'),
(9,  26, 3, 'Nice desk lamp', '2026-07-01'),
(12, 30, 5, 'Useful cookbook', '2026-07-05');
