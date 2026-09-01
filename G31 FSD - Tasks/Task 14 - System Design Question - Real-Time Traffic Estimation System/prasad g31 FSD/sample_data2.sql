-- ============================================================
-- ShopSphere E-Commerce Database
-- File: sample_data02.sql
-- ============================================================

-- ============================================================
-- 1. CATEGORIES - 11 RECORDS
-- ============================================================

INSERT INTO categories
(category_name, description, parent_category_id)
VALUES
('Electronics', 'Electronic devices and accessories', NULL),
('Computers', 'Computers and computing devices', 1),
('Laptops', 'Laptop computers', 2),
('Mobile Phones', 'Smartphones and mobile devices', 1),
('Accessories', 'Electronic accessories', 1),
('Home Appliances', 'Appliances for home use', NULL),
('Kitchen Appliances', 'Kitchen related appliances', 6),
('Fashion', 'Clothing and fashion products', NULL),
('Footwear', 'Shoes and footwear', 8),
('Books', 'Books and educational material', NULL),
('Gaming', 'Gaming devices and accessories', 1);


-- ============================================================
-- 2. CUSTOMERS - 20 RECORDS
-- ============================================================

INSERT INTO customers
(first_name, last_name, email, phone, city, country, registration_date, status)
VALUES
('Aarav', 'Sharma', 'aarav.sharma@gmail.com', '9876500001', 'Bangalore', 'India', '2025-01-15', 'Active'),
('Ananya', 'Reddy', 'ananya.reddy@gmail.com', '9876500002', 'Hyderabad', 'India', '2025-02-10', 'Active'),
('Rahul', 'Verma', 'rahul.verma@gmail.com', '9876500003', 'Delhi', 'India', '2025-02-25', 'Active'),
('Priya', 'Patel', 'priya.patel@gmail.com', '9876500004', 'Mumbai', 'India', '2025-03-12', 'Active'),
('Arjun', 'Kumar', 'arjun.kumar@gmail.com', '9876500005', 'Chennai', 'India', '2025-03-20', 'Active'),
('Sneha', 'Rao', 'sneha.rao@gmail.com', '9876500006', 'Pune', 'India', '2025-04-05', 'Active'),
('Vikram', 'Singh', 'vikram.singh@gmail.com', '9876500007', 'Delhi', 'India', '2025-04-18', 'Active'),
('Kavya', 'Nair', 'kavya.nair@gmail.com', '9876500008', 'Kochi', 'India', '2025-05-02', 'Active'),
('Rohan', 'Mehta', 'rohan.mehta@gmail.com', '9876500009', 'Ahmedabad', 'India', '2025-05-15', 'Active'),
('Pooja', 'Iyer', 'pooja.iyer@gmail.com', '9876500010', 'Bangalore', 'India', '2025-06-01', 'Active'),
('Kiran', 'Joshi', 'kiran.joshi@gmail.com', '9876500011', 'Jaipur', 'India', '2025-06-15', 'Active'),
('Divya', 'Menon', 'divya.menon@gmail.com', '9876500012', 'Chennai', 'India', '2025-07-01', 'Active'),
('Sanjay', 'Gupta', 'sanjay.gupta@gmail.com', '9876500013', 'Lucknow', 'India', '2025-07-20', 'Active'),
('Neha', 'Kapoor', 'neha.kapoor@gmail.com', '9876500014', 'Mumbai', 'India', '2025-08-05', 'Active'),
('Aditya', 'Desai', 'aditya.desai@gmail.com', '9876500015', 'Pune', 'India', '2025-08-20', 'Active'),
('Meera', 'Krishnan', 'meera.krishnan@gmail.com', '9876500016', 'Bangalore', 'India', '2025-09-10', 'Active'),
('Manoj', 'Pillai', 'manoj.pillai@gmail.com', '9876500017', 'Kochi', 'India', '2025-10-01', 'Active'),
('Ishita', 'Shah', 'ishita.shah@gmail.com', '9876500018', 'Ahmedabad', 'India', '2025-10-15', 'Inactive'),
('Nikhil', 'Bose', 'nikhil.bose@gmail.com', '9876500019', 'Kolkata', 'India', '2025-11-01', 'Active'),
('Sowmya', 'Reddy', 'sowmya.reddy@gmail.com', '9876500020', 'Hyderabad', 'India', '2025-11-20', 'Active');


-- ============================================================
-- 3. PRODUCTS - 30 RECORDS
-- ============================================================

INSERT INTO products
(product_name, category_id, price, stock_quantity, supplier_name, is_active)
VALUES
('Dell Inspiron 15', 3, 65000.00, 20, 'Dell India', TRUE),
('HP Pavilion 14', 3, 62000.00, 15, 'HP India', TRUE),
('Lenovo IdeaPad Slim 5', 3, 58000.00, 25, 'Lenovo India', TRUE),
('MacBook Air M3', 3, 105000.00, 10, 'Apple India', TRUE),
('ASUS VivoBook 15', 3, 55000.00, 18, 'ASUS India', TRUE),

('Samsung Galaxy S24', 4, 75000.00, 30, 'Samsung India', TRUE),
('iPhone 15', 4, 70000.00, 25, 'Apple India', TRUE),
('OnePlus 13', 4, 65000.00, 20, 'OnePlus India', TRUE),
('Google Pixel 9', 4, 72000.00, 12, 'Google India', TRUE),
('Nothing Phone 3', 4, 45000.00, 22, 'Nothing India', TRUE),

('Wireless Mouse', 5, 1200.00, 100, 'Logitech', TRUE),
('Mechanical Keyboard', 5, 4500.00, 60, 'Keychron', TRUE),
('USB-C Hub', 5, 2500.00, 70, 'Anker', TRUE),
('Laptop Backpack', 5, 2200.00, 50, 'American Tourister', TRUE),
('Wireless Headphones', 5, 5500.00, 45, 'Sony', TRUE),

('Refrigerator 265L', 6, 32000.00, 8, 'LG India', TRUE),
('Washing Machine 7KG', 6, 28000.00, 10, 'Samsung India', TRUE),
('Microwave Oven', 7, 12000.00, 15, 'IFB India', TRUE),
('Air Fryer', 7, 8000.00, 25, 'Philips India', TRUE),
('Mixer Grinder', 7, 4500.00, 30, 'Prestige', TRUE),

('Men Cotton Shirt', 8, 1800.00, 80, 'Levis India', TRUE),
('Women Kurti', 8, 1500.00, 70, 'FabIndia', TRUE),
('Denim Jeans', 8, 2500.00, 60, 'Levis India', TRUE),

('Running Shoes', 9, 3500.00, 50, 'Nike India', TRUE),
('Casual Sneakers', 9, 2800.00, 45, 'Puma India', TRUE),

('Clean Code', 10, 900.00, 40, 'Pearson', TRUE),
('Design Patterns', 10, 1100.00, 35, 'OReilly', TRUE),
('Effective Java', 10, 950.00, 30, 'Pearson', TRUE),

('PlayStation 5 Controller', 11, 6500.00, 20, 'Sony India', TRUE),
('Gaming Mouse', 11, 3000.00, 40, 'Razer India', TRUE);


-- ============================================================
-- 4. ORDERS - 40 RECORDS
-- ============================================================

INSERT INTO orders
(customer_id, order_date, order_status, shipping_city, shipping_country, total_amount)
VALUES
(1, '2026-01-05 10:30:00', 'Delivered', 'Bangalore', 'India', 65000),
(2, '2026-01-07 11:15:00', 'Delivered', 'Hyderabad', 'India', 75000),
(3, '2026-01-10 14:20:00', 'Delivered', 'Delhi', 'India', 4500),
(4, '2026-01-12 16:10:00', 'Shipped', 'Mumbai', 'India', 32000),
(5, '2026-01-15 09:45:00', 'Delivered', 'Chennai', 'India', 55000),

(6, '2026-01-18 12:30:00', 'Delivered', 'Pune', 'India', 12000),
(7, '2026-01-20 18:00:00', 'Cancelled', 'Delhi', 'India', 28000),
(8, '2026-01-22 13:45:00', 'Delivered', 'Kochi', 'India', 3500),
(9, '2026-01-25 15:30:00', 'Processing', 'Ahmedabad', 'India', 72000),
(10, '2026-01-28 17:15:00', 'Delivered', 'Bangalore', 'India', 2500),

(1, '2026-02-02 10:00:00', 'Delivered', 'Bangalore', 'India', 105000),
(2, '2026-02-04 11:30:00', 'Shipped', 'Hyderabad', 'India', 65000),
(3, '2026-02-06 14:00:00', 'Delivered', 'Delhi', 'India', 5500),
(4, '2026-02-08 16:45:00', 'Delivered', 'Mumbai', 'India', 28000),
(5, '2026-02-10 09:30:00', 'Processing', 'Chennai', 'India', 8000),

(6, '2026-02-12 12:15:00', 'Delivered', 'Pune', 'India', 1800),
(7, '2026-02-15 13:20:00', 'Delivered', 'Delhi', 'India', 70000),
(8, '2026-02-18 15:00:00', 'Cancelled', 'Kochi', 'India', 12000),
(9, '2026-02-20 16:30:00', 'Delivered', 'Ahmedabad', 'India', 4500),
(10, '2026-02-22 18:15:00', 'Delivered', 'Bangalore', 'India', 3000),

(11, '2026-02-25 10:45:00', 'Delivered', 'Jaipur', 'India', 62000),
(12, '2026-02-27 11:20:00', 'Shipped', 'Chennai', 'India', 2500),
(13, '2026-03-01 13:10:00', 'Delivered', 'Lucknow', 'India', 6500),
(14, '2026-03-03 14:30:00', 'Delivered', 'Mumbai', 'India', 1500),
(15, '2026-03-05 15:45:00', 'Processing', 'Pune', 'India', 3500),

(16, '2026-03-07 16:00:00', 'Delivered', 'Bangalore', 'India', 950),
(17, '2026-03-09 17:30:00', 'Delivered', 'Kochi', 'India', 1100),
(18, '2026-03-11 09:15:00', 'Cancelled', 'Ahmedabad', 'India', 5500),
(19, '2026-03-13 10:30:00', 'Delivered', 'Kolkata', 'India', 4500),
(20, '2026-03-15 11:45:00', 'Delivered', 'Hyderabad', 'India', 6500),

(1, '2026-03-18 12:00:00', 'Delivered', 'Bangalore', 'India', 75000),
(2, '2026-03-20 13:30:00', 'Processing', 'Hyderabad', 'India', 3000),
(3, '2026-03-22 14:15:00', 'Delivered', 'Delhi', 'India', 2200),
(4, '2026-03-24 15:00:00', 'Shipped', 'Mumbai', 'India', 2800),
(5, '2026-03-26 16:45:00', 'Delivered', 'Chennai', 'India', 900),

(6, '2026-03-28 17:10:00', 'Delivered', 'Pune', 'India', 2500),
(7, '2026-03-30 09:30:00', 'Delivered', 'Delhi', 'India', 65000),
(8, '2026-04-01 10:45:00', 'Processing', 'Kochi', 'India', 3500),
(9, '2026-04-03 12:15:00', 'Delivered', 'Ahmedabad', 'India', 1200),
(10, '2026-04-05 14:30:00', 'Delivered', 'Bangalore', 'India', 5500);


-- ============================================================
-- 5. ORDER ITEMS - 80+ RECORDS
-- ============================================================

INSERT INTO order_items
(order_id, product_id, quantity, unit_price, discount)
VALUES
(1, 1, 1, 65000, 0),
(2, 6, 1, 75000, 5),
(3, 12, 1, 4500, 0),
(4, 16, 1, 32000, 10),
(5, 5, 1, 55000, 5),

(6, 18, 1, 12000, 0),
(7, 17, 1, 28000, 0),
(8, 24, 1, 3500, 0),
(9, 9, 1, 72000, 5),
(10, 13, 1, 2500, 0),

(11, 4, 1, 105000, 10),
(12, 8, 1, 65000, 0),
(13, 15, 1, 5500, 0),
(14, 17, 1, 28000, 5),
(15, 19, 1, 8000, 0),

(16, 21, 1, 1800, 0),
(17, 7, 1, 70000, 5),
(18, 18, 1, 12000, 0),
(19, 20, 1, 4500, 0),
(20, 30, 1, 3000, 0),

(21, 2, 1, 62000, 5),
(22, 13, 1, 2500, 0),
(23, 29, 1, 6500, 0),
(24, 22, 1, 1500, 0),
(25, 24, 1, 3500, 0),

(26, 28, 1, 950, 0),
(27, 27, 1, 1100, 0),
(28, 15, 1, 5500, 0),
(29, 20, 1, 4500, 0),
(30, 29, 1, 6500, 5),

(31, 6, 1, 75000, 0),
(32, 30, 1, 3000, 0),
(33, 14, 1, 2200, 0),
(34, 25, 1, 2800, 0),
(35, 26, 1, 900, 0),

(36, 13, 1, 2500, 0),
(37, 1, 1, 65000, 5),
(38, 24, 1, 3500, 0),
(39, 11, 1, 1200, 0),
(40, 15, 1, 5500, 0),

(1, 11, 2, 1200, 0),
(2, 15, 1, 5500, 5),
(3, 13, 1, 2500, 0),
(4, 14, 1, 2200, 0),
(5, 11, 1, 1200, 0),

(6, 20, 2, 4500, 0),
(8, 25, 1, 2800, 0),
(9, 15, 1, 5500, 0),
(10, 11, 2, 1200, 0),
(11, 13, 1, 2500, 0),

(12, 14, 1, 2200, 0),
(13, 11, 1, 1200, 0),
(14, 20, 1, 4500, 0),
(15, 19, 1, 8000, 0),
(16, 26, 1, 900, 0),

(17, 29, 1, 6500, 0),
(19, 28, 1, 950, 0),
(20, 30, 1, 3000, 0),
(21, 15, 1, 5500, 0),
(22, 11, 3, 1200, 0),

(23, 13, 1, 2500, 0),
(24, 25, 1, 2800, 0),
(25, 26, 2, 900, 0),
(26, 27, 1, 1100, 0),
(27, 28, 1, 950, 0),

(29, 12, 1, 4500, 0),
(30, 15, 1, 5500, 0),
(31, 11, 1, 1200, 0),
(32, 13, 1, 2500, 0),
(33, 14, 1, 2200, 0),

(34, 24, 1, 3500, 0),
(35, 26, 1, 900, 0),
(36, 30, 1, 3000, 0),
(37, 15, 1, 5500, 0),
(38, 11, 1, 1200, 0),
(39, 13, 1, 2500, 0),
(40, 14, 1, 2200, 0);


-- ============================================================
-- 6. PAYMENTS - 35 RECORDS
-- ============================================================

INSERT INTO payments
(order_id, payment_date, payment_method, payment_status, amount, transaction_reference)
VALUES
(1, '2026-01-05 10:35:00', 'Credit Card', 'Completed', 65000, 'TXN10001'),
(2, '2026-01-07 11:20:00', 'UPI', 'Completed', 75000, 'TXN10002'),
(3, '2026-01-10 14:25:00', 'Debit Card', 'Completed', 4500, 'TXN10003'),
(4, '2026-01-12 16:15:00', 'Credit Card', 'Completed', 32000, 'TXN10004'),
(5, '2026-01-15 09:50:00', 'UPI', 'Completed', 55000, 'TXN10005'),

(6, '2026-01-18 12:35:00', 'Debit Card', 'Completed', 12000, 'TXN10006'),
(7, '2026-01-20 18:05:00', 'Credit Card', 'Failed', 28000, 'TXN10007'),
(8, '2026-01-22 13:50:00', 'UPI', 'Completed', 3500, 'TXN10008'),
(9, '2026-01-25 15:35:00', 'Credit Card', 'Completed', 72000, 'TXN10009'),
(10, '2026-01-28 17:20:00', 'UPI', 'Completed', 2500, 'TXN10010'),

(11, '2026-02-02 10:05:00', 'Credit Card', 'Completed', 105000, 'TXN10011'),
(12, '2026-02-04 11:35:00', 'UPI', 'Completed', 65000, 'TXN10012'),
(13, '2026-02-06 14:05:00', 'Debit Card', 'Completed', 5500, 'TXN10013'),
(14, '2026-02-08 16:50:00', 'Credit Card', 'Completed', 28000, 'TXN10014'),
(15, '2026-02-10 09:35:00', 'UPI', 'Pending', 8000, 'TXN10015'),

(16, '2026-02-12 12:20:00', 'UPI', 'Completed', 1800, 'TXN10016'),
(17, '2026-02-15 13:25:00', 'Credit Card', 'Completed', 70000, 'TXN10017'),
(18, '2026-02-18 15:05:00', 'Debit Card', 'Failed', 12000, 'TXN10018'),
(19, '2026-02-20 16:35:00', 'UPI', 'Completed', 4500, 'TXN10019'),
(20, '2026-02-22 18:20:00', 'Credit Card', 'Completed', 3000, 'TXN10020'),

(21, '2026-02-25 10:50:00', 'UPI', 'Completed', 62000, 'TXN10021'),
(22, '2026-02-27 11:25:00', 'Debit Card', 'Completed', 2500, 'TXN10022'),
(23, '2026-03-01 13:15:00', 'Credit Card', 'Completed', 6500, 'TXN10023'),
(24, '2026-03-03 14:35:00', 'UPI', 'Completed', 1500, 'TXN10024'),
(25, '2026-03-05 15:50:00', 'Debit Card', 'Completed', 3500, 'TXN10025'),

(26, '2026-03-07 16:05:00', 'UPI', 'Completed', 950, 'TXN10026'),
(27, '2026-03-09 17:35:00', 'Credit Card', 'Completed', 1100, 'TXN10027'),
(28, '2026-03-11 09:20:00', 'Debit Card', 'Failed', 5500, 'TXN10028'),
(29, '2026-03-13 10:35:00', 'UPI', 'Completed', 4500, 'TXN10029'),
(30, '2026-03-15 11:50:00', 'Credit Card', 'Completed', 6500, 'TXN10030'),

(31, '2026-03-18 12:05:00', 'UPI', 'Completed', 75000, 'TXN10031'),
(32, '2026-03-20 13:35:00', 'Credit Card', 'Pending', 3000, 'TXN10032'),
(33, '2026-03-22 14:20:00', 'UPI', 'Completed', 2200, 'TXN10033'),
(34, '2026-03-24 15:05:00', 'Debit Card', 'Completed', 2800, 'TXN10034'),
(35, '2026-03-26 16:50:00', 'UPI', 'Completed', 900, 'TXN10035');


-- ============================================================
-- 7. REVIEWS - 25 RECORDS
-- ============================================================

INSERT INTO reviews
(customer_id, product_id, rating, review_text, review_date)
VALUES
(1, 1, 5, 'Excellent laptop with great performance.', '2026-01-20'),
(2, 6, 4, 'Very good phone and camera.', '2026-01-22'),
(3, 12, 5, 'Keyboard quality is excellent.', '2026-01-25'),
(4, 16, 4, 'Good refrigerator with enough space.', '2026-01-28'),
(5, 5, 5, 'Very good laptop for daily work.', '2026-02-01'),

(6, 18, 4, 'Works well and heats food quickly.', '2026-02-03'),
(7, 17, 3, 'Good machine but slightly noisy.', '2026-02-05'),
(8, 24, 5, 'Very comfortable running shoes.', '2026-02-07'),
(9, 9, 4, 'Great phone display.', '2026-02-10'),
(10, 13, 5, 'Useful USB hub.', '2026-02-12'),

(1, 4, 5, 'MacBook performance is excellent.', '2026-02-15'),
(2, 8, 4, 'Good phone with smooth performance.', '2026-02-18'),
(3, 15, 5, 'Excellent sound quality.', '2026-02-20'),
(4, 17, 4, 'Washing machine works well.', '2026-02-22'),
(5, 19, 5, 'Air fryer is very useful.', '2026-02-25'),

(6, 21, 4, 'Good quality shirt.', '2026-02-27'),
(7, 7, 5, 'iPhone camera is amazing.', '2026-03-01'),
(8, 20, 3, 'Mixer is okay for the price.', '2026-03-03'),
(9, 30, 5, 'Great gaming mouse.', '2026-03-05'),
(10, 29, 4, 'Controller works perfectly.', '2026-03-07'),

(11, 2, 4, 'Good laptop for office use.', '2026-03-10'),
(12, 22, 5, 'Beautiful kurti and good material.', '2026-03-12'),
(13, 28, 5, 'Excellent Java reference book.', '2026-03-15'),
(14, 25, 4, 'Comfortable sneakers.', '2026-03-18'),
(15, 27, 5, 'Very useful book for developers.', '2026-03-20');


-- ============================================================
-- END OF SAMPLE DATA
-- ============================================================