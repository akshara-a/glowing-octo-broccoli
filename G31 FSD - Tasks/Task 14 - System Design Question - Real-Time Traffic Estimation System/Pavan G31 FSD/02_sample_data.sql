-- ============================================================
-- SHOPSPHERE E-COMMERCE DATABASE
-- FILE: 02_sample_data.sql
-- DATABASE: shopsphere_db
-- ============================================================


-- ============================================================
-- 1. CUSTOMERS — 20 RECORDS
-- ============================================================

INSERT INTO customers
(first_name, last_name, email, phone, city, country, registration_date, status)
VALUES
('Aarav', 'Sharma', 'aarav.sharma@example.com', '9876500001', 'Chennai', 'India', '2024-01-15', 'Active'),
('Diya', 'Patel', 'diya.patel@example.com', '9876500002', 'Bangalore', 'India', '2024-02-10', 'Active'),
('Arjun', 'Reddy', 'arjun.reddy@example.com', '9876500003', 'Hyderabad', 'India', '2024-03-05', 'Active'),
('Meera', 'Iyer', 'meera.iyer@example.com', '9876500004', 'Coimbatore', 'India', '2024-03-22', 'Inactive'),
('Rohan', 'Gupta', 'rohan.gupta@example.com', '9876500005', 'Delhi', 'India', '2024-04-18', 'Active'),
('Ananya', 'Singh', 'ananya.singh@example.com', '9876500006', 'Mumbai', 'India', '2024-05-11', 'Active'),
('Vikram', 'Kumar', 'vikram.kumar@example.com', '9876500007', 'Pune', 'India', '2024-05-29', 'Blocked'),
('Ishita', 'Nair', 'ishita.nair@example.com', '9876500008', 'Kochi', 'India', '2024-06-14', 'Active'),
('Karan', 'Verma', 'karan.verma@example.com', '9876500009', 'Jaipur', 'India', '2024-07-03', 'Active'),
('Sneha', 'Rao', 'sneha.rao@example.com', '9876500010', 'Mysore', 'India', '2024-07-25', 'Inactive'),
('Rahul', 'Menon', 'rahul.menon@example.com', '9876500011', 'Tirupati', 'India', '2024-08-08', 'Active'),
('Priya', 'Joshi', 'priya.joshi@example.com', '9876500012', 'Ahmedabad', 'India', '2024-08-19', 'Active'),
('Aditya', 'Das', 'aditya.das@example.com', '9876500013', 'Kolkata', 'India', '2024-09-02', 'Active'),
('Nisha', 'Kapoor', 'nisha.kapoor@example.com', '9876500014', 'Chandigarh', 'India', '2024-09-17', 'Active'),
('Siddharth', 'Mishra', 'siddharth.mishra@example.com', '9876500015', 'Lucknow', 'India', '2024-10-05', 'Active'),
('Pooja', 'Shah', 'pooja.shah@example.com', '9876500016', 'Surat', 'India', '2024-10-21', 'Inactive'),
('Manish', 'Yadav', 'manish.yadav@example.com', '9876500017', 'Bhopal', 'India', '2024-11-09', 'Active'),
('Kavya', 'Krishnan', 'kavya.krishnan@example.com', '9876500018', 'Madurai', 'India', '2024-11-27', 'Active'),
('Naveen', 'Bhat', 'naveen.bhat@example.com', '9876500019', 'Mangalore', 'India', '2024-12-12', 'Active'),
('Tanya', 'Roy', 'tanya.roy@example.com', '9876500020', 'Guwahati', 'India', '2025-01-06', 'Active');


-- ============================================================
-- 2. CATEGORIES — 10 RECORDS
-- ============================================================

INSERT INTO categories
(category_name, description, parent_category_id)
VALUES
('Electronics', 'Electronic devices and accessories', NULL),
('Mobiles', 'Smartphones and mobile accessories', 1),
('Laptops', 'Laptops and computing devices', 1),
('Audio', 'Headphones, speakers and audio devices', 1),
('Home Appliances', 'Appliances for home and kitchen', NULL),
('Kitchen', 'Kitchen appliances and equipment', 5),
('Fashion', 'Clothing and fashion products', NULL),
('Footwear', 'Shoes and footwear products', 7),
('Books', 'Books and educational material', NULL),
('Sports', 'Sports and fitness products', NULL);


-- ============================================================
-- 3. PRODUCTS — 30 RECORDS
-- ============================================================

INSERT INTO products
(product_name, category_id, price, stock_quantity, supplier_name, created_at, is_active)
VALUES
('Galaxy Pro Smartphone', 2, 69999.00, 25, 'TechWorld', '2025-01-05 10:00:00', TRUE),
('Pixel Max Smartphone', 2, 59999.00, 8, 'MobileHub', '2025-01-08 11:30:00', TRUE),
('OnePlus Ultra', 2, 44999.00, 0, 'MobileHub', '2025-01-12 09:15:00', TRUE),
('iPhone Elite', 2, 89999.00, 15, 'AppleStore', '2025-01-15 14:20:00', TRUE),
('USB-C Fast Charger', 2, 1499.00, 75, 'ChargeTech', '2025-01-18 12:00:00', TRUE),

('ThinkBook Pro Laptop', 3, 84999.00, 12, 'LenovoStore', '2025-01-20 10:30:00', TRUE),
('MacBook Air Plus', 3, 114999.00, 6, 'AppleStore', '2025-01-22 13:10:00', TRUE),
('Gaming Beast Laptop', 3, 129999.00, 3, 'GameTech', '2025-01-25 16:00:00', TRUE),
('Budget Student Laptop', 3, 45999.00, 40, 'EduTech', '2025-01-28 09:45:00', TRUE),

('Noise Cancelling Headphones', 4, 7999.00, 30, 'SoundMax', '2025-02-01 11:00:00', TRUE),
('Wireless Earbuds Pro', 4, 4999.00, 50, 'SoundMax', '2025-02-04 12:20:00', TRUE),
('Bluetooth Speaker', 4, 3499.00, 18, 'AudioWorks', '2025-02-07 15:30:00', TRUE),
('Studio Monitor Headphones', 4, 9999.00, 2, 'AudioWorks', '2025-02-10 10:15:00', TRUE),

('Smart Air Conditioner', 5, 45999.00, 10, 'HomeTech', '2025-02-14 13:00:00', TRUE),
('Robot Vacuum Cleaner', 5, 29999.00, 7, 'CleanHome', '2025-02-17 14:40:00', TRUE),
('Smart Washing Machine', 5, 54999.00, 5, 'HomeTech', '2025-02-20 11:50:00', TRUE),

('Air Fryer Digital', 6, 8999.00, 22, 'KitchenPro', '2025-02-23 09:00:00', TRUE),
('Mixer Grinder Pro', 6, 4999.00, 35, 'KitchenPro', '2025-02-26 10:25:00', TRUE),
('Coffee Maker Deluxe', 6, 7499.00, 0, 'BrewMaster', '2025-03-01 12:10:00', TRUE),

('Classic Cotton Shirt', 7, 1999.00, 45, 'FashionHub', '2025-03-04 13:30:00', TRUE),
('Premium Denim Jacket', 7, 3999.00, 14, 'FashionHub', '2025-03-07 15:10:00', TRUE),
('Formal Trousers', 7, 2499.00, 28, 'StyleWorks', '2025-03-10 11:45:00', TRUE),

('Running Shoes Pro', 8, 5999.00, 20, 'SportFit', '2025-03-13 10:00:00', TRUE),
('Training Sneakers', 8, 4499.00, 4, 'SportFit', '2025-03-16 14:00:00', TRUE),
('Leather Casual Shoes', 8, 6999.00, 11, 'FootStyle', '2025-03-19 16:30:00', TRUE),

('SQL Mastery Book', 9, 1299.00, 60, 'BookWorld', '2025-03-22 09:30:00', TRUE),
('C Programming Guide', 9, 999.00, 55, 'BookWorld', '2025-03-25 12:30:00', TRUE),
('Database Design Handbook', 9, 1599.00, 25, 'TechBooks', '2025-03-28 10:45:00', TRUE),

('Yoga Mat Premium', 10, 1999.00, 32, 'FitLife', '2025-04-01 08:30:00', TRUE),
('Adjustable Dumbbells', 10, 7999.00, 9, 'FitLife', '2025-04-04 17:00:00', TRUE);


-- ============================================================
-- 4. ORDERS — 40 RECORDS
-- ============================================================

INSERT INTO orders
(customer_id, order_date, order_status, shipping_city, shipping_country, total_amount)
VALUES
(1,  '2025-04-01 10:15:00', 'Delivered',  'Chennai',    'India', 71498.00),
(2,  '2025-04-02 11:20:00', 'Delivered',  'Bangalore',  'India', 64998.00),
(3,  '2025-04-03 09:40:00', 'Processing', 'Hyderabad',  'India', 46998.00),
(5,  '2025-04-04 14:10:00', 'Shipped',    'Delhi',      'India', 87998.00),
(6,  '2025-04-05 16:25:00', 'Delivered',  'Mumbai',     'India', 8999.00),
(8,  '2025-04-06 10:50:00', 'Pending',    'Kochi',      'India', 54999.00),
(9,  '2025-04-07 13:30:00', 'Delivered',  'Jaipur',     'India', 12498.00),
(11, '2025-04-08 15:45:00', 'Cancelled',  'Tirupati',   'India', 5999.00),
(12, '2025-04-09 09:25:00', 'Delivered',  'Ahmedabad',  'India', 3999.00),
(13, '2025-04-10 12:15:00', 'Processing', 'Kolkata',    'India', 9999.00),

(14, '2025-04-11 14:35:00', 'Delivered',  'Chandigarh', 'India', 1299.00),
(15, '2025-04-12 16:00:00', 'Shipped',    'Lucknow',    'India', 5999.00),
(17, '2025-04-13 10:20:00', 'Delivered',  'Bhopal',     'India', 7999.00),
(18, '2025-04-14 11:45:00', 'Processing', 'Madurai',    'India', 7499.00),
(19, '2025-04-15 13:05:00', 'Delivered',  'Mangalore',  'India', 4499.00),
(20, '2025-04-16 15:30:00', 'Pending',    'Guwahati',   'India', 1999.00),
(1,  '2025-04-17 09:10:00', 'Delivered',  'Chennai',    'India', 7999.00),
(2,  '2025-04-18 10:55:00', 'Shipped',    'Bangalore',  'India', 3499.00),
(3,  '2025-04-19 12:40:00', 'Delivered',  'Hyderabad',  'India', 2499.00),
(5,  '2025-04-20 14:15:00', 'Cancelled',  'Delhi',      'India', 8999.00),

(6,  '2025-04-21 16:10:00', 'Delivered',  'Mumbai',     'India', 9999.00),
(8,  '2025-04-22 11:30:00', 'Processing', 'Kochi',      'India', 6999.00),
(9,  '2025-04-23 09:50:00', 'Delivered',  'Jaipur',     'India', 1999.00),
(11, '2025-04-24 13:20:00', 'Shipped',    'Tirupati',   'India', 7999.00),
(12, '2025-04-25 15:05:00', 'Delivered',  'Ahmedabad',  'India', 1599.00),
(13, '2025-04-26 10:40:00', 'Pending',    'Kolkata',    'India', 4999.00),
(14, '2025-04-27 12:55:00', 'Delivered',  'Chandigarh', 'India', 5999.00),
(15, '2025-04-28 14:25:00', 'Processing', 'Lucknow',    'India', 8999.00),
(17, '2025-04-29 16:15:00', 'Delivered',  'Bhopal',     'India', 6999.00),
(18, '2025-04-30 09:35:00', 'Cancelled',  'Madurai',    'India', 1999.00),

(19, '2025-05-01 11:10:00', 'Delivered',  'Mangalore',  'India', 1299.00),
(20, '2025-05-02 13:45:00', 'Shipped',    'Guwahati',   'India', 7999.00),
(1,  '2025-05-03 15:20:00', 'Delivered',  'Chennai',    'India', 4999.00),
(2,  '2025-05-04 10:05:00', 'Processing', 'Bangalore',  'India', 1599.00),
(3,  '2025-05-05 12:30:00', 'Delivered',  'Hyderabad',  'India', 3499.00),
(5,  '2025-05-06 14:50:00', 'Pending',    'Delhi',      'India', 9999.00),
(6,  '2025-05-07 16:40:00', 'Delivered',  'Mumbai',     'India', 8999.00),
(8,  '2025-05-08 09:15:00', 'Cancelled',  'Kochi',      'India', 4499.00),
(9,  '2025-05-09 11:55:00', 'Delivered',  'Jaipur',     'India', 7999.00),
(12, '2025-05-10 13:25:00', 'Shipped',    'Ahmedabad',  'India', 6999.00);


-- ============================================================
-- 5. ORDER ITEMS — 80+ RECORDS
-- ============================================================

INSERT INTO order_items
(order_id, product_id, quantity, unit_price, discount)
VALUES
(1,  1, 1, 69999.00, 0),
(1,  5, 1, 1499.00, 0),

(2,  2, 1, 59999.00, 0),
(2,  5, 1, 1499.00, 0),

(3,  3, 1, 44999.00, 0),
(3,  5, 1, 1499.00, 0),

(4,  6, 1, 84999.00, 0),
(4,  5, 2, 1499.00, 0),

(5,  17, 1, 8999.00, 0),

(6,  16, 1, 54999.00, 0),

(7,  10, 1, 7999.00, 0),
(7,  11, 1, 4999.00, 0),

(8,  23, 1, 5999.00, 0),

(9,  21, 1, 3999.00, 0),

(10, 13, 1, 9999.00, 0),

(11, 26, 1, 1299.00, 0),

(12, 23, 1, 5999.00, 0),

(13, 10, 1, 7999.00, 0),

(14, 19, 1, 7499.00, 0),

(15, 24, 1, 4499.00, 0),

(16, 29, 1, 1999.00, 0),

(17, 10, 1, 7999.00, 0),

(18, 12, 1, 3499.00, 0),

(19, 22, 1, 2499.00, 0),

(20, 17, 1, 8999.00, 0),

(21, 13, 1, 9999.00, 0),

(22, 25, 1, 6999.00, 0),

(23, 29, 1, 1999.00, 0),

(24, 30, 1, 7999.00, 0),

(25, 28, 1, 1599.00, 0),

(26, 18, 1, 4999.00, 0),

(27, 23, 1, 5999.00, 0),

(28, 17, 1, 8999.00, 0),

(29, 25, 1, 6999.00, 0),

(30, 29, 1, 1999.00, 0),

(31, 26, 1, 1299.00, 0),

(32, 30, 1, 7999.00, 0),

(33, 18, 1, 4999.00, 0),

(34, 28, 1, 1599.00, 0),

(35, 12, 1, 3499.00, 0),

(36, 13, 1, 9999.00, 0),

(37, 24, 1, 4499.00, 0),

(38, 30, 1, 7999.00, 0),

(39, 25, 1, 6999.00, 0),
(39, 11, 1, 4999.00, 0),

(40, 10, 1, 7999.00, 0),

-- Additional items to exceed 80 records
(3,  11, 1, 4999.00, 5),
(4,  10, 1, 7999.00, 10),
(5,  18, 1, 4999.00, 0),
(6,  15, 1, 29999.00, 5),
(7,  12, 1, 3499.00, 0),
(8,  24, 1, 4499.00, 0),
(9,  22, 1, 2499.00, 0),
(10, 11, 1, 4999.00, 0),
(12, 27, 1, 999.00, 0),
(13, 14, 1, 45999.00, 10),
(14, 20, 1, 1999.00, 0),
(15, 21, 1, 3999.00, 0),
(16, 30, 1, 7999.00, 0),
(17, 28, 1, 1599.00, 0),
(18, 23, 1, 5999.00, 0),
(19, 11, 1, 4999.00, 0),
(20, 17, 1, 8999.00, 0),
(21, 19, 1, 7499.00, 0),
(22, 10, 1, 7999.00, 0),
(23, 30, 1, 7999.00, 0),
(24, 26, 1, 1299.00, 0),
(25, 29, 1, 1999.00, 0),
(26, 21, 1, 3999.00, 0),
(27, 18, 1, 4999.00, 0),
(28, 16, 1, 54999.00, 0),
(29, 24, 1, 4499.00, 0),
(30, 22, 1, 2499.00, 0),
(31, 10, 1, 7999.00, 0),
(32, 17, 1, 8999.00, 0),
(33, 11, 1, 4999.00, 0),
(34, 23, 1, 5999.00, 0),
(35, 27, 1, 999.00, 0),
(36, 15, 1, 29999.00, 0),
(37, 19, 1, 7499.00, 0),
(38, 28, 1, 1599.00, 0),
(39, 12, 1, 3499.00, 0),
(40, 10, 1, 7999.00, 0);


-- ============================================================
-- 6. PAYMENTS — 30 RECORDS
-- ============================================================

INSERT INTO payments
(order_id, payment_date, payment_method, payment_status, amount, transaction_reference)
VALUES
(1,  '2025-04-01 10:20:00', 'Credit Card', 'Completed', 71498.00, 'TXN10001'),
(2,  '2025-04-02 11:25:00', 'UPI', 'Completed', 64998.00, 'TXN10002'),
(3,  '2025-04-03 09:45:00', 'Debit Card', 'Completed', 46998.00, 'TXN10003'),
(4,  '2025-04-04 14:15:00', 'Credit Card', 'Completed', 87998.00, 'TXN10004'),
(5,  '2025-04-05 16:30:00', 'UPI', 'Completed', 8999.00, 'TXN10005'),
(6,  '2025-04-06 10:55:00', 'PayPal', 'Pending', 54999.00, 'TXN10006'),
(7,  '2025-04-07 13:35:00', 'Debit Card', 'Completed', 12498.00, 'TXN10007'),
(8,  '2025-04-08 15:50:00', 'UPI', 'Failed', 5999.00, 'TXN10008'),
(9,  '2025-04-09 09:30:00', 'Credit Card', 'Completed', 3999.00, 'TXN10009'),
(10, '2025-04-10 12:20:00', 'Debit Card', 'Completed', 9999.00, 'TXN10010'),

(11, '2025-04-11 14:40:00', 'UPI', 'Completed', 1299.00, 'TXN10011'),
(12, '2025-04-12 16:05:00', 'Credit Card', 'Completed', 5999.00, 'TXN10012'),
(13, '2025-04-13 10:25:00', 'PayPal', 'Completed', 7999.00, 'TXN10013'),
(14, '2025-04-14 11:50:00', 'UPI', 'Completed', 7499.00, 'TXN10014'),
(15, '2025-04-15 13:10:00', 'Debit Card', 'Completed', 4499.00, 'TXN10015'),
(16, '2025-04-16 15:35:00', 'Cash on Delivery', 'Pending', 1999.00, 'TXN10016'),
(17, '2025-04-17 09:15:00', 'Credit Card', 'Completed', 7999.00, 'TXN10017'),
(18, '2025-04-18 11:00:00', 'UPI', 'Completed', 3499.00, 'TXN10018'),
(19, '2025-04-19 12:45:00', 'Debit Card', 'Completed', 2499.00, 'TXN10019'),
(20, '2025-04-20 14:20:00', 'UPI', 'Refunded', 8999.00, 'TXN10020'),

(21, '2025-04-21 16:15:00', 'Credit Card', 'Completed', 9999.00, 'TXN10021'),
(22, '2025-04-22 11:35:00', 'Debit Card', 'Completed', 6999.00, 'TXN10022'),
(23, '2025-04-23 09:55:00', 'UPI', 'Completed', 1999.00, 'TXN10023'),
(24, '2025-04-24 13:25:00', 'PayPal', 'Completed', 7999.00, 'TXN10024'),
(25, '2025-04-25 15:10:00', 'Credit Card', 'Completed', 1599.00, 'TXN10025'),
(26, '2025-04-26 10:45:00', 'UPI', 'Failed', 4999.00, 'TXN10026'),
(27, '2025-04-27 13:00:00', 'Debit Card', 'Completed', 5999.00, 'TXN10027'),
(28, '2025-04-28 14:30:00', 'Credit Card', 'Completed', 8999.00, 'TXN10028'),
(29, '2025-04-29 16:20:00', 'UPI', 'Completed', 6999.00, 'TXN10029'),
(30, '2025-04-30 09:40:00', 'Cash on Delivery', 'Pending', 1999.00, 'TXN10030');


-- ============================================================
-- 7. REVIEWS — 25+ RECORDS
-- ============================================================

INSERT INTO reviews
(customer_id, product_id, rating, review_text, review_date)
VALUES
(1,  1, 5, 'Excellent smartphone with great performance.', '2025-04-05'),
(2,  2, 4, 'Good phone with a bright display.', '2025-04-06'),
(3,  3, 5, 'Fast and reliable smartphone.', '2025-04-07'),
(5,  6, 4, 'Good laptop for professional work.', '2025-04-08'),
(6,  17, 5, 'The air fryer is easy to use.', '2025-04-09'),
(8,  16, 4, 'Washing machine works very well.', '2025-04-10'),
(9,  10, 5, 'Excellent noise cancellation.', '2025-04-11'),
(11, 23, 4, 'Comfortable running shoes.', '2025-04-12'),
(12, 21, 3, 'Nice jacket but slightly expensive.', '2025-04-13'),
(13, 13, 5, 'Great headphones for studio use.', '2025-04-14'),
(14, 26, 4, 'Very useful SQL reference book.', '2025-04-15'),
(15, 24, 5, 'Comfortable sneakers for training.', '2025-04-16'),
(17, 29, 4, 'Good quality yoga mat.', '2025-04-17'),
(18, 30, 5, 'Dumbbells are sturdy and adjustable.', '2025-04-18'),
(19, 12, 4, 'Good sound quality for the price.', '2025-04-19'),
(20, 18, 3, 'Works well but could be quieter.', '2025-04-20'),
(1,  5, 5, 'Fast charging and compact design.', '2025-04-21'),
(2,  11, 4, 'Clear sound and comfortable fit.', '2025-04-22'),
(3,  14, 5, 'Cools the room quickly.', '2025-04-23'),
(5,  15, 4, 'Great cleaning performance.', '2025-04-24'),
(6,  19, 5, 'Excellent coffee maker.', '2025-04-25'),
(8,  20, 4, 'Comfortable cotton shirt.', '2025-04-26'),
(9,  22, 3, 'Good trousers for office wear.', '2025-04-27'),
(11,  27, 5, 'Helpful C programming book.', '2025-04-28'),
(12,  28, 4, 'Useful database reference.', '2025-04-29'),
(13,  10, 5, 'Very comfortable headphones.', '2025-04-30'),
(14,  23, 4, 'Good shoes for daily running.', '2025-05-01'),
(15,  30, 5, 'Excellent equipment for home workouts.', '2025-05-02');


-- ============================================================
-- VERIFY RECORD COUNTS
-- ============================================================

SELECT 'customers' AS table_name, COUNT(*) AS record_count FROM customers
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
SELECT 'reviews', COUNT(*) FROM reviews;