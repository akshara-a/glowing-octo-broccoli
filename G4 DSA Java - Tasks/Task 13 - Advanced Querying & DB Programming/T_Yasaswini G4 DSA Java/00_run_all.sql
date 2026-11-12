

-- ==================== 01_schema.sql ====================

-- ShopSphere database schema (PostgreSQL)
-- Run this file while connected to shopsphere_db.
DROP TABLE IF EXISTS reviews, payments, order_items, orders, products, categories, customers CASCADE;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(80) NOT NULL,
    country VARCHAR(80) NOT NULL,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(10) NOT NULL CHECK (status IN ('Active','Inactive','Blocked'))
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    parent_category_id INT REFERENCES categories(category_id) ON DELETE SET NULL
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL REFERENCES categories(category_id),
    price NUMERIC(12,2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    supplier_name VARCHAR(120),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(15) NOT NULL CHECK
      (order_status IN ('Pending','Processing','Shipped','Delivered','Cancelled')),
    shipping_city VARCHAR(80) NOT NULL,
    shipping_country VARCHAR(80) NOT NULL,
    total_amount NUMERIC(12,2) NOT NULL CHECK (total_amount >= 0)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INT NOT NULL REFERENCES products(product_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(12,2) NOT NULL CHECK (unit_price > 0),
    discount NUMERIC(5,2) NOT NULL DEFAULT 0 CHECK (discount BETWEEN 0 AND 100)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id),
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(30) NOT NULL CHECK
      (payment_method IN ('Credit Card','Debit Card','UPI','PayPal','Cash on Delivery')),
    payment_status VARCHAR(15) NOT NULL CHECK
      (payment_status IN ('Pending','Completed','Failed','Refunded')),
    amount NUMERIC(12,2) NOT NULL CHECK (amount >= 0),
    transaction_reference VARCHAR(100) UNIQUE
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Optional rule: one review per customer/product pair.
CREATE UNIQUE INDEX uq_reviews_customer_product
    ON reviews(customer_id, product_id);


-- ==================== 02_sample_data.sql ====================

-- Sample data for ShopSphere. Run after 01_schema.sql.
INSERT INTO customers (first_name, last_name, email, phone, city, country, status) VALUES
    ('Aarav', 'Sharma', 'aarav.sharma@example.com', '9876500001', 'Hyderabad', 'India', 'Active'),
    ('Ananya', 'Reddy', 'ananya.reddy@example.com', '9876500002', 'Proddatur', 'India', 'Active'),
    ('Arjun', 'Patel', 'arjun.patel@example.com', '9876500003', 'Bengaluru', 'India', 'Active'),
    ('Diya', 'Nair', 'diya.nair@example.com', '9876500004', 'Chennai', 'India', 'Inactive'),
    ('Ishaan', 'Gupta', 'ishaan.gupta@example.com', '9876500005', 'Mumbai', 'India', 'Active'),
    ('Meera', 'Iyer', 'meera.iyer@example.com', '9876500006', 'Pune', 'India', 'Active'),
    ('Rohan', 'Kumar', 'rohan.kumar@example.com', '9876500007', 'Delhi', 'India', 'Blocked'),
    ('Sana', 'Khan', 'sana.khan@example.com', '9876500008', 'Hyderabad', 'India', 'Active'),
    ('Kabir', 'Singh', 'kabir.singh@example.com', '9876500009', 'Kolkata', 'India', 'Active'),
    ('Priya', 'Das', 'priya.das@example.com', '9876500010', 'Chennai', 'India', 'Active'),
    ('Vikram', 'Rao', 'vikram.rao@example.com', '9876500011', 'Bengaluru', 'India', 'Inactive'),
    ('Aditi', 'Joshi', 'aditi.joshi@example.com', '9876500012', 'Jaipur', 'India', 'Active'),
    ('Neil', 'Thomas', 'neil.thomas@example.com', '9876500013', 'Kochi', 'India', 'Active'),
    ('Kavya', 'Mohan', 'kavya.mohan@example.com', '9876500014', 'Pune', 'India', 'Active'),
    ('Rahul', 'Verma', 'rahul.verma@example.com', '9876500015', 'Lucknow', 'India', 'Active'),
    ('Zoya', 'Ali', 'zoya.ali@example.com', '9876500016', 'Dubai', 'UAE', 'Active'),
    ('Liam', 'Brown', 'liam.brown@example.com', '9876500017', 'London', 'UK', 'Active'),
    ('Olivia', 'Wilson', 'olivia.wilson@example.com', '9876500018', 'New York', 'USA', 'Inactive'),
    ('Noah', 'Martin', 'noah.martin@example.com', '9876500019', 'Toronto', 'Canada', 'Active'),
    ('Emma', 'Taylor', 'emma.taylor@example.com', '9876500020', 'Sydney', 'Australia', 'Active'),
    ('Asha', 'Menon', 'asha.menon@example.com', NULL, 'Mysuru', 'India', 'Active'),
    ('Kiran', 'Rao', 'kiran.rao@example.com', '9876500022', 'Vijayawada', 'India', 'Active');

INSERT INTO categories (category_name, description, parent_category_id) VALUES
    ('Electronics', 'Electronic devices', NULL),
    ('Computers', 'Computers and accessories', 1),
    ('Laptops', 'Portable computers', 2),
    ('Desktops', 'Desktop computers', 2),
    ('Mobile Devices', 'Mobile phones and tablets', 1),
    ('Smartphones', 'Smart mobile phones', 5),
    ('Tablets', 'Tablet computers', 5),
    ('Home Appliances', 'Appliances for home', NULL),
    ('Audio', 'Audio equipment', 1),
    ('Accessories', 'Computer and mobile accessories', 1),
    ('Kitchen', 'Kitchen appliances', 8);

INSERT INTO products (product_name, category_id, price, stock_quantity, supplier_name, is_active) VALUES
    ('Phone Alpha', 6, 18999, 25, 'TechSource', True),
    ('Phone Beta', 6, 12999, 8, 'MobileHub', True),
    ('Phone Lite', 6, 7999, 45, 'MobileHub', True),
    ('Laptop Pro', 3, 65999, 12, 'CompWorld', True),
    ('Laptop Air', 3, 54999, 7, 'CompWorld', True),
    ('Laptop Basic', 3, 32999, 18, 'CompWorld', True),
    ('Desktop Max', 4, 72000, 5, 'CompWorld', True),
    ('Desktop Office', 4, 42000, 22, 'CompWorld', True),
    ('Tablet Plus', 7, 24999, 16, 'MobileHub', True),
    ('Tablet Mini', 7, 15999, 9, 'MobileHub', True),
    ('Headphones X', 9, 2999, 60, 'SoundHouse', True),
    ('Bluetooth Speaker', 9, 1999, 35, 'SoundHouse', True),
    ('USB Cable', 10, 199, 150, 'CableCo', True),
    ('Wireless Mouse', 10, 799, 80, 'Peripherals Ltd', True),
    ('Mechanical Keyboard', 10, 3499, 28, 'Peripherals Ltd', True),
    ('Monitor 24', 2, 11999, 14, 'ScreenWorks', True),
    ('Monitor 27', 2, 18999, 6, 'ScreenWorks', True),
    ('Webcam HD', 2, 2499, 40, 'VisionTech', True),
    ('Smart Watch', 6, 4999, 55, 'MobileHub', True),
    ('Power Bank', 10, 1499, 75, 'PowerPlus', True),
    ('Refrigerator', 8, 28999, 11, 'HomeTech', True),
    ('Washing Machine', 8, 23999, 4, 'HomeTech', True),
    ('Mixer Grinder', 11, 3499, 32, 'KitchenPro', True),
    ('Electric Kettle', 11, 1299, 50, 'KitchenPro', True),
    ('Air Fryer', 11, 6999, 17, 'KitchenPro', True),
    ('Gaming Console', 1, 39999, 3, 'GameZone', True),
    ('Router', 2, 2799, 26, 'NetWorks', True),
    ('Printer', 2, 8999, 13, 'OfficeTech', True),
    ('Old Phone Case', 10, 299, 0, 'Accessories Inc', False),
    ('Desk Lamp', 8, 899, 21, 'HomeTech', True),
    ('Unused Product', 10, 1599, 10, 'Other Supplier', True),
    ('Premium Headset', 9, 8999, 15, 'SoundHouse', True);

INSERT INTO orders (customer_id, order_date, order_status, shipping_city, shipping_country, total_amount) VALUES
    (1, '2026-01-03 11:07:00', 'Delivered', 'Hyderabad', 'India', 77394.4),
    (2, '2026-02-06 12:14:00', 'Delivered', 'Proddatur', 'India', 113772.90000000001),
    (3, '2026-03-09 13:21:00', 'Processing', 'Bengaluru', 'India', 99794.6),
    (4, '2026-04-12 14:28:00', 'Shipped', 'Chennai', 'India', 20496.1),
    (5, '2026-05-15 15:35:00', 'Pending', 'Mumbai', 'India', 126444.40000000001),
    (6, '2026-06-18 16:42:00', 'Cancelled', 'Pune', 'India', 46542.899999999994),
    (7, '2026-07-21 17:49:00', 'Delivered', 'Delhi', 'India', 111094.6),
    (8, '2026-08-24 18:56:00', 'Delivered', 'Hyderabad', 'India', 5836.1),
    (9, '2026-09-27 10:03:00', 'Processing', 'Kolkata', 'India', 40415.4),
    (10, '2026-10-03 11:10:00', 'Shipped', 'Chennai', 'India', 189423.9),
    (11, '2026-01-06 12:17:00', 'Pending', 'Bengaluru', 'India', 106596.6),
    (12, '2026-02-09 13:24:00', 'Cancelled', 'Jaipur', 'India', 71697.1),
    (13, '2026-03-12 14:31:00', 'Delivered', 'Kochi', 'India', 138957.3),
    (14, '2026-04-15 15:38:00', 'Delivered', 'Pune', 'India', 107793.9),
    (15, '2026-05-18 16:45:00', 'Processing', 'Lucknow', 'India', 2175.6),
    (16, '2026-06-21 17:52:00', 'Shipped', 'Dubai', 'UAE', 18647.1),
    (17, '2026-07-24 18:59:00', 'Pending', 'London', 'UK', 117495.40000000001),
    (18, '2026-08-27 10:06:00', 'Cancelled', 'New York', 'USA', 65813.90000000001),
    (19, '2026-09-03 11:13:00', 'Delivered', 'Toronto', 'Canada', 32795.6),
    (20, '2026-10-06 12:20:00', 'Delivered', 'Sydney', 'Australia', 24197.1),
    (1, '2026-01-09 13:27:00', 'Processing', 'Hyderabad', 'India', 92135.40000000001),
    (2, '2026-02-12 14:34:00', 'Shipped', 'Proddatur', 'India', 120093.90000000001),
    (3, '2026-03-15 15:41:00', 'Pending', 'Bengaluru', 'India', 188995.6),
    (4, '2026-04-18 16:48:00', 'Cancelled', 'Chennai', 'India', 48648.1),
    (5, '2026-05-21 17:55:00', 'Delivered', 'Mumbai', 'India', 12445.400000000001),
    (6, '2026-06-24 18:02:00', 'Delivered', 'Pune', 'India', 100753.90000000001),
    (7, '2026-07-27 10:09:00', 'Processing', 'Delhi', 'India', 65895.6),
    (8, '2026-08-03 11:16:00', 'Shipped', 'Hyderabad', 'India', 6817.1),
    (9, '2026-09-06 12:23:00', 'Pending', 'Kolkata', 'India', 9075.400000000001),
    (10, '2026-10-09 13:30:00', 'Cancelled', 'Chennai', 'India', 172593.9),
    (11, '2026-01-12 14:37:00', 'Delivered', 'Bengaluru', 'India', 67015.6),
    (12, '2026-02-15 15:44:00', 'Delivered', 'Jaipur', 'India', 145799.0),
    (13, '2026-03-18 16:51:00', 'Processing', 'Kochi', 'India', 58395.4),
    (14, '2026-04-21 17:58:00', 'Shipped', 'Pune', 'India', 89773.90000000001),
    (15, '2026-05-24 18:05:00', 'Pending', 'Lucknow', 'India', 96995.6),
    (16, '2026-06-27 10:12:00', 'Cancelled', 'Dubai', 'UAE', 11497.1),
    (17, '2026-07-03 11:19:00', 'Delivered', 'London', 'UK', 71445.40000000001),
    (18, '2026-08-06 12:26:00', 'Delivered', 'New York', 'USA', 30543.899999999998),
    (19, '2026-09-09 13:33:00', 'Processing', 'Toronto', 'Canada', 107595.6),
    (20, '2026-10-12 14:40:00', 'Shipped', 'Sydney', 'Australia', 4337.1),
    (1, '2026-01-15 15:47:00', 'Pending', 'Hyderabad', 'India', 40415.4),
    (2, '2026-02-18 16:54:00', 'Cancelled', 'Proddatur', 'India', 189423.9);

INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount) VALUES
    (1, 3, 2, 7999, 5),
    (1, 10, 3, 15999, 10),
    (2, 6, 3, 32999, 10),
    (2, 13, 4, 199, 15),
    (3, 9, 4, 24999, 15),
    (3, 16, 1, 11999, 0),
    (4, 12, 1, 1999, 0),
    (4, 19, 2, 4999, 5),
    (5, 15, 2, 3499, 5),
    (5, 22, 3, 23999, 10),
    (6, 18, 3, 2499, 10),
    (6, 25, 4, 6999, 15),
    (7, 21, 4, 28999, 15),
    (7, 28, 1, 8999, 0),
    (8, 24, 1, 1299, 0),
    (8, 31, 2, 1599, 5),
    (9, 27, 2, 2799, 5),
    (9, 2, 3, 12999, 10),
    (10, 30, 3, 899, 10),
    (10, 5, 4, 54999, 15),
    (11, 1, 4, 18999, 15),
    (11, 8, 1, 42000, 0),
    (12, 4, 1, 65999, 0),
    (12, 11, 2, 2999, 5),
    (13, 7, 2, 72000, 5),
    (13, 14, 3, 799, 10),
    (14, 10, 3, 15999, 10),
    (14, 17, 4, 18999, 15),
    (15, 13, 4, 199, 15),
    (15, 20, 1, 1499, 0),
    (16, 16, 1, 11999, 0),
    (16, 23, 2, 3499, 5),
    (17, 19, 2, 4999, 5),
    (17, 26, 3, 39999, 10),
    (18, 22, 3, 23999, 10),
    (18, 29, 4, 299, 15),
    (19, 25, 4, 6999, 15),
    (19, 32, 1, 8999, 0),
    (20, 28, 1, 8999, 0),
    (20, 3, 2, 7999, 5),
    (21, 31, 2, 1599, 5),
    (21, 6, 3, 32999, 10),
    (22, 2, 3, 12999, 10),
    (22, 9, 4, 24999, 15),
    (23, 5, 4, 54999, 15),
    (23, 12, 1, 1999, 0),
    (24, 8, 1, 42000, 0),
    (24, 15, 2, 3499, 5),
    (25, 11, 2, 2999, 5),
    (25, 18, 3, 2499, 10),
    (26, 14, 3, 799, 10),
    (26, 21, 4, 28999, 15),
    (27, 17, 4, 18999, 15),
    (27, 24, 1, 1299, 0),
    (28, 20, 1, 1499, 0),
    (28, 27, 2, 2799, 5),
    (29, 23, 2, 3499, 5),
    (29, 30, 3, 899, 10),
    (30, 26, 3, 39999, 10),
    (30, 1, 4, 18999, 15),
    (31, 29, 4, 299, 15),
    (31, 4, 1, 65999, 0),
    (32, 32, 1, 8999, 0),
    (32, 7, 2, 72000, 5),
    (33, 3, 2, 7999, 5),
    (33, 10, 3, 15999, 10),
    (34, 6, 3, 32999, 10),
    (34, 13, 4, 199, 15),
    (35, 9, 4, 24999, 15),
    (35, 16, 1, 11999, 0),
    (36, 12, 1, 1999, 0),
    (36, 19, 2, 4999, 5),
    (37, 15, 2, 3499, 5),
    (37, 22, 3, 23999, 10),
    (38, 18, 3, 2499, 10),
    (38, 25, 4, 6999, 15),
    (39, 21, 4, 28999, 15),
    (39, 28, 1, 8999, 0),
    (40, 24, 1, 1299, 0),
    (40, 31, 2, 1599, 5),
    (41, 27, 2, 2799, 5),
    (41, 2, 3, 12999, 10),
    (42, 30, 3, 899, 10),
    (42, 5, 4, 54999, 15),
    (1, 17, 1, 18999, 0),
    (2, 22, 1, 23999, 0),
    (3, 27, 1, 2799, 0),
    (4, 32, 1, 8999, 0),
    (5, 5, 1, 54999, 0),
    (6, 10, 1, 15999, 0),
    (7, 15, 1, 3499, 0),
    (8, 20, 1, 1499, 0);

INSERT INTO payments (order_id, payment_date, payment_method, payment_status, amount, transaction_reference) VALUES
    (1, '2026-01-03 12:00:00', 'Credit Card', 'Completed', 77394.4, 'TXN00001'),
    (2, '2026-02-06 12:00:00', 'Debit Card', 'Completed', 113772.90000000001, 'TXN00002'),
    (3, '2026-03-09 12:00:00', 'PayPal', 'Completed', 99794.6, 'TXN00003'),
    (4, '2026-04-12 12:00:00', 'Cash on Delivery', 'Completed', 20496.1, 'TXN00004'),
    (5, '2026-05-15 12:00:00', 'UPI', 'Pending', 126444.40000000001, 'TXN00005'),
    (6, '2026-06-18 12:00:00', 'Credit Card', 'Failed', 46542.899999999994, 'TXN00006'),
    (7, '2026-07-21 12:00:00', 'Debit Card', 'Completed', 111094.6, 'TXN00007'),
    (8, '2026-08-24 12:00:00', 'PayPal', 'Completed', 5836.1, 'TXN00008'),
    (9, '2026-09-27 12:00:00', 'Cash on Delivery', 'Completed', 40415.4, 'TXN00009'),
    (10, '2026-10-03 12:00:00', 'UPI', 'Completed', 189423.9, 'TXN00010'),
    (11, '2026-01-06 12:00:00', 'Credit Card', 'Pending', 106596.6, 'TXN00011'),
    (12, '2026-02-09 12:00:00', 'Debit Card', 'Completed', 71697.1, 'TXN00012'),
    (13, '2026-03-12 12:00:00', 'PayPal', 'Completed', 138957.3, 'TXN00013'),
    (14, '2026-04-15 12:00:00', 'Cash on Delivery', 'Completed', 107793.9, 'TXN00014'),
    (15, '2026-05-18 12:00:00', 'UPI', 'Completed', 2175.6, 'TXN00015'),
    (16, '2026-06-21 12:00:00', 'Credit Card', 'Completed', 18647.1, 'TXN00016'),
    (17, '2026-07-24 12:00:00', 'Debit Card', 'Completed', 117495.40000000001, 'TXN00017'),
    (18, '2026-08-27 12:00:00', 'PayPal', 'Failed', 65813.90000000001, 'TXN00018'),
    (19, '2026-09-03 12:00:00', 'Cash on Delivery', 'Completed', 32795.6, 'TXN00019'),
    (20, '2026-10-06 12:00:00', 'UPI', 'Completed', 24197.1, 'TXN00020'),
    (21, '2026-01-09 12:00:00', 'Credit Card', 'Completed', 92135.40000000001, 'TXN00021'),
    (22, '2026-02-12 12:00:00', 'Debit Card', 'Completed', 120093.90000000001, 'TXN00022'),
    (23, '2026-03-15 12:00:00', 'PayPal', 'Completed', 188995.6, 'TXN00023'),
    (24, '2026-04-18 12:00:00', 'Cash on Delivery', 'Completed', 48648.1, 'TXN00024'),
    (25, '2026-05-21 12:00:00', 'UPI', 'Completed', 12445.400000000001, 'TXN00025'),
    (26, '2026-06-24 12:00:00', 'Credit Card', 'Completed', 100753.90000000001, 'TXN00026'),
    (27, '2026-07-27 12:00:00', 'Debit Card', 'Completed', 65895.6, 'TXN00027'),
    (28, '2026-08-03 12:00:00', 'PayPal', 'Completed', 6817.1, 'TXN00028'),
    (29, '2026-09-06 12:00:00', 'Cash on Delivery', 'Completed', 9075.400000000001, 'TXN00029'),
    (30, '2026-10-09 12:00:00', 'UPI', 'Failed', 172593.9, 'TXN00030'),
    (31, '2026-01-12 12:00:00', 'Credit Card', 'Completed', 67015.6, 'TXN00031'),
    (32, '2026-02-15 12:00:00', 'Debit Card', 'Completed', 145799.0, 'TXN00032'),
    (33, '2026-03-18 12:00:00', 'PayPal', 'Completed', 58395.4, 'TXN00033'),
    (34, '2026-04-21 12:00:00', 'Cash on Delivery', 'Completed', 89773.90000000001, 'TXN00034'),
    (35, '2026-05-24 12:00:00', 'UPI', 'Completed', 96995.6, 'TXN00035'),
    (36, '2026-06-27 12:00:00', 'Credit Card', 'Completed', 11497.1, 'TXN00036');

INSERT INTO reviews (customer_id, product_id, rating, review_text, review_date) VALUES
    (1, 5, 2, 'Sample customer review 1', '2026-01-02'),
    (2, 10, 3, 'Sample customer review 2', '2026-02-04'),
    (3, 15, 4, 'Sample customer review 3', '2026-03-06'),
    (4, 20, 5, 'Sample customer review 4', '2026-04-08'),
    (5, 25, 1, 'Sample customer review 5', '2026-05-10'),
    (6, 30, 2, 'Sample customer review 6', '2026-06-12'),
    (7, 3, 3, 'Sample customer review 7', '2026-07-14'),
    (8, 8, 4, 'Sample customer review 8', '2026-08-16'),
    (9, 13, 5, 'Sample customer review 9', '2026-09-18'),
    (10, 18, 1, 'Sample customer review 10', '2026-10-20'),
    (11, 23, 2, 'Sample customer review 11', '2026-01-22'),
    (12, 28, 3, 'Sample customer review 12', '2026-02-24'),
    (13, 1, 4, 'Sample customer review 13', '2026-03-26'),
    (14, 6, 5, 'Sample customer review 14', '2026-04-01'),
    (15, 11, 1, 'Sample customer review 15', '2026-05-03'),
    (16, 16, 2, 'Sample customer review 16', '2026-06-05'),
    (17, 21, 3, 'Sample customer review 17', '2026-07-07'),
    (18, 26, 4, 'Sample customer review 18', '2026-08-09'),
    (19, 31, 5, 'Sample customer review 19', '2026-09-11'),
    (20, 4, 1, 'Sample customer review 20', '2026-10-13'),
    (1, 9, 2, 'Sample customer review 21', '2026-01-15'),
    (2, 14, 3, 'Sample customer review 22', '2026-02-17'),
    (3, 19, 4, 'Sample customer review 23', '2026-03-19'),
    (4, 24, 5, 'Sample customer review 24', '2026-04-21'),
    (5, 29, 1, 'Sample customer review 25', '2026-05-23'),
    (6, 2, 2, 'Sample customer review 26', '2026-06-25'),
    (7, 7, 3, 'Sample customer review 27', '2026-07-27');

-- Reset SERIAL sequences after explicit/generated bulk inserts.
SELECT setval(pg_get_serial_sequence('customers','customer_id'), (SELECT MAX(customer_id) FROM customers));
SELECT setval(pg_get_serial_sequence('categories','category_id'), (SELECT MAX(category_id) FROM categories));
SELECT setval(pg_get_serial_sequence('products','product_id'), (SELECT MAX(product_id) FROM products));
SELECT setval(pg_get_serial_sequence('orders','order_id'), (SELECT MAX(order_id) FROM orders));
SELECT setval(pg_get_serial_sequence('order_items','order_item_id'), (SELECT MAX(order_item_id) FROM order_items));
SELECT setval(pg_get_serial_sequence('payments','payment_id'), (SELECT MAX(payment_id) FROM payments));
SELECT setval(pg_get_serial_sequence('reviews','review_id'), (SELECT MAX(review_id) FROM reviews));


-- ==================== 04_views.sql ====================

-- Task 53: Customer order summary
CREATE OR REPLACE VIEW customer_order_summary AS
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS customer_name,
       COUNT(o.order_id) AS total_orders,
       COALESCE(SUM(o.total_amount) FILTER (WHERE o.order_status <> 'Cancelled'),0) AS total_spent,
       MAX(o.order_date) AS last_order_date
FROM customers c LEFT JOIN orders o USING(customer_id)
GROUP BY c.customer_id,c.first_name,c.last_name;

-- Task 54
SELECT * FROM customer_order_summary ORDER BY total_spent DESC LIMIT 5;

-- Task 55: Product sales summary
CREATE OR REPLACE VIEW product_sales_summary AS
SELECT p.product_id,p.product_name,c.category_name,
       COALESCE(SUM(oi.quantity),0) AS total_quantity_sold,
       COALESCE(SUM(oi.quantity*oi.unit_price*(1-oi.discount/100)),0) AS total_sales
FROM products p JOIN categories c USING(category_id)
LEFT JOIN order_items oi USING(product_id)
GROUP BY p.product_id,p.product_name,c.category_name;

-- Task 56
SELECT * FROM product_sales_summary WHERE total_sales > 10000;

-- Task 57: Demonstrate a simple updatable view.
CREATE OR REPLACE VIEW active_customers AS
SELECT customer_id,first_name,last_name,email,status
FROM customers WHERE status='Active'
WITH LOCAL CHECK OPTION;
-- This succeeds only when the updated row continues to satisfy status='Active'.
-- UPDATE active_customers SET last_name='Updated' WHERE customer_id=1;
-- Aggregate/join view customer_order_summary is not automatically updatable.


-- ==================== 05_materialized_views.sql ====================

-- Tasks 58-61
CREATE MATERIALIZED VIEW IF NOT EXISTS monthly_sales_summary AS
SELECT EXTRACT(YEAR FROM o.order_date)::int AS sales_year,
       EXTRACT(MONTH FROM o.order_date)::int AS sales_month,
       COUNT(DISTINCT o.order_id) AS total_orders,
       COALESCE(SUM(oi.quantity),0) AS total_products_sold,
       COALESCE(SUM(oi.quantity*oi.unit_price*(1-oi.discount/100)),0) AS total_revenue
FROM orders o LEFT JOIN order_items oi USING(order_id)
WHERE o.order_status <> 'Cancelled'
GROUP BY 1,2;

-- Task 59
SELECT * FROM monthly_sales_summary ORDER BY sales_year,sales_month;

-- Task 60: Changes to base tables are not visible until refresh.
-- Add test data separately, then run the refresh below.

-- Task 61
REFRESH MATERIALIZED VIEW monthly_sales_summary;
SELECT * FROM monthly_sales_summary ORDER BY sales_year,sales_month;

-- Task 62:
-- A VIEW stores only its SQL definition and computes from current base-table data on access.
-- A MATERIALIZED VIEW stores query results physically, so reads can be faster but data may be stale.
-- A materialized view must be refreshed to show later changes.
-- Dashboard: materialize monthly aggregates and refresh hourly (for example, from a scheduled job).
CREATE MATERIALIZED VIEW IF NOT EXISTS executive_sales_dashboard AS
SELECT date_trunc('month',o.order_date)::date AS sales_month,
       SUM(o.total_amount) FILTER(WHERE o.order_status<>'Cancelled') AS total_revenue,
       COUNT(DISTINCT o.order_id) FILTER(WHERE o.order_status<>'Cancelled') AS total_orders,
       COUNT(DISTINCT o.customer_id) FILTER(WHERE o.order_status<>'Cancelled') AS total_customers,
       COALESCE(SUM(oi.quantity) FILTER(WHERE o.order_status<>'Cancelled'),0) AS total_products_sold,
       AVG(o.total_amount) FILTER(WHERE o.order_status<>'Cancelled') AS average_order_value
FROM orders o LEFT JOIN order_items oi USING(order_id)
GROUP BY date_trunc('month',o.order_date)::date;
CREATE INDEX IF NOT EXISTS idx_executive_sales_dashboard_month
    ON executive_sales_dashboard(sales_month);
REFRESH MATERIALIZED VIEW executive_sales_dashboard;

-- For REFRESH MATERIALIZED VIEW CONCURRENTLY, create a unique index covering all rows
-- (for example, a unique index on sales_month if each month appears once).
-- Concurrent refresh avoids blocking readers, but requires a populated materialized view
-- and a qualifying unique index with only column names (no expression or partial predicate).


-- ==================== 06_indexes.sql ====================

-- Tasks 63-67
CREATE UNIQUE INDEX IF NOT EXISTS idx_customers_email ON customers(email);
CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_orders_order_date ON orders(order_date);
CREATE INDEX IF NOT EXISTS idx_orders_status_date ON orders(order_status,order_date);
CREATE INDEX IF NOT EXISTS idx_products_category_price ON products(category_id,price);

-- Task 68: inspect before and after index creation.
EXPLAIN ANALYZE SELECT * FROM orders WHERE customer_id=10;
CREATE INDEX IF NOT EXISTS idx_orders_customer_id_explain ON orders(customer_id);
ANALYZE orders;
EXPLAIN ANALYZE SELECT * FROM orders WHERE customer_id=10;
-- On a small table PostgreSQL may prefer a sequential scan. Test on a large table
-- and compare the plan and actual execution time.

-- Task 69: example index removal
DROP INDEX IF EXISTS idx_orders_customer_id_explain;

-- Task 25 performance case study:
-- customer_id equality, order_status equality, and order_date range are all predicates.
-- A composite B-tree index is a reasonable starting point:
CREATE INDEX IF NOT EXISTS idx_orders_customer_status_date
    ON orders(customer_id,order_status,order_date);
EXPLAIN ANALYZE
SELECT * FROM orders
WHERE customer_id=500
  AND order_status='Delivered'
  AND order_date >= DATE '2026-01-01';

-- Discussion:
-- 1. Indexes speed selective lookups by avoiding scanning every row.
-- 2. INSERT/UPDATE/DELETE must maintain indexes, adding work and storage.
-- 3. Composite index contains more than one key column.
-- 4. Column order matters; leading columns should match common equality filters,
--    followed by range/filter columns. Workload and selectivity should guide order.
-- 5. Unique index enforces uniqueness; ordinary index does not.
-- 6. Avoid indexes on tiny tables, rarely filtered columns, low-selectivity columns
--    without a workload reason, and columns frequently modified.


-- ==================== 07_procedures.sql ====================

-- Task 70
CREATE OR REPLACE PROCEDURE update_product_stock(
    p_product_id INT, p_quantity_change INT
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE products
       SET stock_quantity = stock_quantity + p_quantity_change
     WHERE product_id = p_product_id
       AND stock_quantity + p_quantity_change >= 0;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Product not found or stock would become negative';
    END IF;
END;
$$;
-- CALL update_product_stock(1, 5);

-- Task 71
CREATE OR REPLACE PROCEDURE cancel_order(p_order_id INT)
LANGUAGE plpgsql AS $$
DECLARE v_status TEXT;
BEGIN
    SELECT order_status INTO v_status
      FROM orders WHERE order_id=p_order_id FOR UPDATE;
    IF NOT FOUND THEN RAISE EXCEPTION 'Order % does not exist',p_order_id; END IF;
    IF v_status='Delivered' THEN RAISE EXCEPTION 'Delivered orders cannot be cancelled'; END IF;
    IF v_status='Cancelled' THEN RAISE EXCEPTION 'Order is already cancelled'; END IF;

    UPDATE products p
       SET stock_quantity=p.stock_quantity+x.qty
      FROM (SELECT product_id,SUM(quantity) AS qty
              FROM order_items WHERE order_id=p_order_id GROUP BY product_id) x
     WHERE p.product_id=x.product_id;

    UPDATE orders SET order_status='Cancelled' WHERE order_id=p_order_id;
    UPDATE payments SET payment_status='Refunded'
     WHERE order_id=p_order_id AND payment_status='Completed';
END;
$$;
-- CALL cancel_order(4);

-- Task 72
CREATE OR REPLACE PROCEDURE process_payment(
    p_order_id INT,
    p_payment_method VARCHAR(30),
    p_payment_amount NUMERIC(12,2),
    p_transaction_reference VARCHAR(100)
)
LANGUAGE plpgsql AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM orders WHERE order_id=p_order_id) THEN
        RAISE EXCEPTION 'Order % does not exist',p_order_id;
    END IF;
    INSERT INTO payments(order_id,payment_date,payment_method,payment_status,amount,transaction_reference)
    VALUES(p_order_id,CURRENT_TIMESTAMP,p_payment_method,'Completed',p_payment_amount,p_transaction_reference);
END;
$$;
-- CALL process_payment(1,'UPI',500,'TXN-NEW-001');

-- Task 73: assignment order_status CHECK list has no Delayed value.
-- Extend it before using the procedure:
-- ALTER TABLE orders DROP CONSTRAINT orders_order_status_check;
-- ALTER TABLE orders ADD CONSTRAINT orders_order_status_check
-- CHECK (order_status IN ('Pending','Processing','Shipped','Delivered','Cancelled','Delayed'));
CREATE OR REPLACE PROCEDURE mark_delayed_orders(p_days INT)
LANGUAGE plpgsql AS $$
BEGIN
    IF p_days < 0 THEN RAISE EXCEPTION 'Days must be non-negative'; END IF;
    UPDATE orders SET order_status='Delayed'
     WHERE order_status='Processing'
       AND order_date < CURRENT_TIMESTAMP - make_interval(days => p_days);
END;
$$;


-- ==================== 08_functions.sql ====================

-- Task 74
CREATE OR REPLACE FUNCTION calculate_order_total(p_order_id INT)
RETURNS NUMERIC LANGUAGE SQL STABLE AS $$
    SELECT COALESCE(SUM(quantity*unit_price*(1-discount/100)),0)
    FROM order_items WHERE order_id=p_order_id;
$$;

-- Task 75
CREATE OR REPLACE FUNCTION customer_total_spending(p_customer_id INT)
RETURNS NUMERIC LANGUAGE SQL STABLE AS $$
    SELECT COALESCE(SUM(total_amount),0)
    FROM orders
    WHERE customer_id=p_customer_id AND order_status<>'Cancelled';
$$;

-- Task 76
CREATE OR REPLACE FUNCTION get_customer_order_count(p_customer_id INT)
RETURNS BIGINT LANGUAGE SQL STABLE AS $$
    SELECT COUNT(*) FROM orders WHERE customer_id=p_customer_id;
$$;

-- Task 77
CREATE OR REPLACE FUNCTION product_average_rating(p_product_id INT)
RETURNS NUMERIC LANGUAGE SQL STABLE AS $$
    SELECT COALESCE(AVG(rating),0) FROM reviews WHERE product_id=p_product_id;
$$;

-- Task 78
SELECT customer_id,first_name,customer_total_spending(customer_id) AS total_spending,
       get_customer_order_count(customer_id) AS order_count
FROM customers;
SELECT product_id,product_name,product_average_rating(product_id) AS average_rating
FROM products;
SELECT order_id,calculate_order_total(order_id) AS calculated_total
FROM orders;

-- Procedure vs Function:
-- Function returns a value (or table) and is called in SELECT or expressions.
-- Procedure is invoked with CALL and is used for actions/workflows.
-- PostgreSQL functions cannot perform transaction control in the same way procedures can;
-- procedures may use transaction control in permitted CALL contexts.


-- ==================== 09_ctes.sql ====================

-- Task 47: customer spending above 5000
WITH customer_spending AS (
  SELECT c.customer_id,c.first_name,c.last_name,
         COALESCE(SUM(o.total_amount) FILTER(WHERE o.order_status<>'Cancelled'),0) AS total_spent
  FROM customers c LEFT JOIN orders o USING(customer_id)
  GROUP BY c.customer_id
)
SELECT * FROM customer_spending WHERE total_spent>5000;

-- Task 48: ten highest-selling products
WITH product_sales AS (
  SELECT p.product_id,p.product_name,COALESCE(SUM(oi.quantity),0) AS quantity_sold,
         COALESCE(SUM(oi.quantity*oi.unit_price*(1-oi.discount/100)),0) AS sales
  FROM products p LEFT JOIN order_items oi USING(product_id)
  GROUP BY p.product_id,p.product_name
)
SELECT * FROM product_sales ORDER BY quantity_sold DESC LIMIT 10;

-- Task 49: multiple CTEs
WITH customer_order_summary AS (
  SELECT customer_id,COUNT(*) AS order_count,SUM(total_amount) AS order_value
  FROM orders GROUP BY customer_id
),
product_sales_summary AS (
  SELECT product_id,SUM(quantity) AS units_sold
  FROM order_items GROUP BY product_id
)
SELECT c.customer_id,c.first_name,
       COALESCE(cos.order_count,0) AS order_count,
       COALESCE(cos.order_value,0) AS order_value,
       COALESCE(ps.units_sold,0) AS total_units_sold
FROM customers c
LEFT JOIN customer_order_summary cos USING(customer_id)
LEFT JOIN LATERAL (
  SELECT SUM(oi.quantity) AS units_sold
  FROM orders o JOIN order_items oi USING(order_id)
  WHERE o.customer_id=c.customer_id
) ps ON TRUE;

-- Task 50: spending above average customer spending
WITH spend AS (
  SELECT c.customer_id,c.first_name,c.last_name,
         COALESCE(SUM(o.total_amount) FILTER(WHERE o.order_status<>'Cancelled'),0) AS total_spent
  FROM customers c LEFT JOIN orders o USING(customer_id)
  GROUP BY c.customer_id
)
SELECT * FROM spend
WHERE total_spent>(SELECT AVG(total_spent) FROM spend);

-- Task 51: recursive hierarchy
WITH RECURSIVE category_tree AS (
  SELECT category_id,category_name,parent_category_id,0 AS level
  FROM categories WHERE parent_category_id IS NULL
  UNION ALL
  SELECT c.category_id,c.category_name,c.parent_category_id,ct.level+1
  FROM categories c JOIN category_tree ct ON c.parent_category_id=ct.category_id
)
SELECT ct.category_id,ct.category_name,p.category_name AS parent_category,ct.level
FROM category_tree ct LEFT JOIN categories p ON p.category_id=ct.parent_category_id
ORDER BY ct.category_id;

-- Task 52: indented hierarchy
WITH RECURSIVE tree AS (
  SELECT category_id,category_name,parent_category_id,0 AS lvl,
         category_name::text AS sort_path
  FROM categories WHERE parent_category_id IS NULL
  UNION ALL
  SELECT c.category_id,c.category_name,c.parent_category_id,t.lvl+1,
         t.sort_path || ' > ' || c.category_name
  FROM categories c JOIN tree t ON c.parent_category_id=t.category_id
)
SELECT REPEAT('    ',lvl)||category_name AS category_hierarchy
FROM tree ORDER BY sort_path;


-- ==================== 03_queries.sql ====================

-- ShopSphere answers: Queries 1-46 and 57-62, 68-69, 102-120.
-- Queries 47-52 are also provided in 09_ctes.sql; views in 04_views.sql;
-- indexes in 06_indexes.sql; procedures in 07_procedures.sql; functions in 08_functions.sql.

-- Query 1: Display all customers
SELECT * FROM customers;


-- Query 2: Active customers
SELECT first_name, last_name, email, city FROM customers WHERE status = 'Active';


-- Query 3: Products costing more than 1000
SELECT * FROM products WHERE price > 1000;


-- Query 4: Products priced between 500 and 2000
SELECT * FROM products WHERE price BETWEEN 500 AND 2000;


-- Query 5: Customers in three selected cities
SELECT * FROM customers WHERE city IN ('Hyderabad','Chennai','Bengaluru');


-- Query 6: First names beginning with A
SELECT * FROM customers WHERE first_name ILIKE 'A%';


-- Query 7: Product names containing Phone
SELECT * FROM products WHERE product_name ILIKE '%Phone%';


-- Query 8: Orders newest first
SELECT * FROM orders ORDER BY order_date DESC;


-- Query 9: Five most expensive products
SELECT * FROM products ORDER BY price DESC LIMIT 5;


-- Query 10: Stock below 10
SELECT * FROM products WHERE stock_quantity < 10;


-- Query 11: Total customers
SELECT COUNT(*) AS total_customers FROM customers;


-- Query 12: Total products
SELECT COUNT(*) AS total_products FROM products;


-- Query 13: Average product price
SELECT AVG(price) AS average_price FROM products;


-- Query 14: Cheapest product
SELECT product_name, price FROM products ORDER BY price ASC LIMIT 1;


-- Query 15: Most expensive product
SELECT product_name, price FROM products ORDER BY price DESC LIMIT 1;


-- Query 16: Total value of all orders
SELECT SUM(total_amount) AS total_order_value FROM orders;


-- Query 17: Average order amount
SELECT AVG(total_amount) AS average_order_amount FROM orders;


-- Query 18: Orders by status
SELECT order_status, COUNT(*) AS total_orders FROM orders GROUP BY order_status ORDER BY order_status;


-- Query 19: Products in each category
SELECT c.category_name, COUNT(p.product_id) AS product_count FROM categories c LEFT JOIN products p USING (category_id) GROUP BY c.category_id,c.category_name ORDER BY c.category_name;


-- Query 20: Average price per category
SELECT c.category_name, AVG(p.price) AS average_price FROM categories c JOIN products p USING(category_id) GROUP BY c.category_id,c.category_name;


-- Query 21: Categories with average price above 1000
SELECT c.category_name, AVG(p.price) AS average_price FROM categories c JOIN products p USING(category_id) GROUP BY c.category_id,c.category_name HAVING AVG(p.price) > 1000;


-- Query 22: Spending per customer
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS customer_name, COALESCE(SUM(o.total_amount) FILTER (WHERE o.order_status <> 'Cancelled'),0) AS total_spent FROM customers c LEFT JOIN orders o USING(customer_id) GROUP BY c.customer_id;


-- Query 23: Customers spending above 5000
SELECT c.customer_id,c.first_name || ' ' || c.last_name AS customer_name,SUM(o.total_amount) AS total_spent FROM customers c JOIN orders o USING(customer_id) WHERE o.order_status <> 'Cancelled' GROUP BY c.customer_id HAVING SUM(o.total_amount)>5000;


-- Query 24: Products ordered more than five times
SELECT p.product_id,p.product_name,SUM(oi.quantity) AS times_ordered FROM products p JOIN order_items oi USING(product_id) GROUP BY p.product_id,p.product_name HAVING SUM(oi.quantity)>5;


-- Query 25: INNER JOIN orders and customers
SELECT o.order_id,c.first_name || ' ' || c.last_name AS customer_name,o.order_date,o.order_status,o.total_amount FROM orders o INNER JOIN customers c USING(customer_id);


-- Query 26: Join customers, orders, items and products
SELECT o.order_id,c.first_name || ' ' || c.last_name AS customer_name,p.product_name,oi.quantity,oi.unit_price FROM customers c JOIN orders o USING(customer_id) JOIN order_items oi USING(order_id) JOIN products p USING(product_id) ORDER BY o.order_id;


-- Query 27: Products with category names
SELECT p.product_id,p.product_name,c.category_name,p.price FROM products p JOIN categories c USING(category_id);


-- Query 28: All customers and any orders
SELECT c.customer_id,c.first_name,c.last_name,o.order_id,o.order_date,o.order_status FROM customers c LEFT JOIN orders o USING(customer_id) ORDER BY c.customer_id;


-- Query 29: Customers without orders
SELECT c.* FROM customers c LEFT JOIN orders o USING(customer_id) WHERE o.order_id IS NULL;


-- Query 30: Products never ordered
SELECT p.* FROM products p LEFT JOIN order_items oi USING(product_id) WHERE oi.product_id IS NULL;


-- Query 31: RIGHT JOIN example
SELECT c.customer_id,c.first_name,o.order_id,o.order_status FROM customers c RIGHT JOIN orders o USING(customer_id);


-- Query 32: FULL OUTER JOIN example
SELECT c.customer_id,c.first_name,o.order_id,o.order_status FROM customers c FULL OUTER JOIN orders o USING(customer_id);


-- Query 33: Category self join
SELECT child.category_name AS child_category,parent.category_name AS parent_category FROM categories child LEFT JOIN categories parent ON child.parent_category_id=parent.category_id;


-- Query 34: Products above average price
SELECT * FROM products WHERE price > (SELECT AVG(price) FROM products);


-- Query 35: Customers with total order amount above average order amount
SELECT c.customer_id,c.first_name,c.last_name,SUM(o.total_amount) AS customer_total FROM customers c JOIN orders o USING(customer_id) GROUP BY c.customer_id HAVING SUM(o.total_amount) > (SELECT AVG(total_amount) FROM orders);


-- Query 36: Most expensive product in each category
SELECT p.* FROM products p WHERE p.price=(SELECT MAX(p2.price) FROM products p2 WHERE p2.category_id=p.category_id);


-- Query 37: Customers with at least one order using EXISTS
SELECT c.* FROM customers c WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id);


-- Query 38: Customers with no orders using NOT EXISTS
SELECT c.* FROM customers c WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id);


-- Query 39: Products more expensive than every product in category 10
SELECT * FROM products WHERE price > ALL (SELECT price FROM products WHERE category_id=10);


-- Query 40: Products more expensive than at least one product in category 9
SELECT * FROM products WHERE price > ANY (SELECT price FROM products WHERE category_id=9);


-- Query 41: Correlated: highest-priced product per category
SELECT p.* FROM products p WHERE p.price=(SELECT MAX(p2.price) FROM products p2 WHERE p2.category_id=p.category_id);


-- Query 42: Spending above average spending in same city
WITH spending AS (SELECT c.customer_id,c.city,COALESCE(SUM(o.total_amount) FILTER(WHERE o.order_status<>'Cancelled'),0) AS spent FROM customers c LEFT JOIN orders o USING(customer_id) GROUP BY c.customer_id,c.city) SELECT * FROM spending s WHERE spent > (SELECT AVG(s2.spent) FROM spending s2 WHERE s2.city=s.city);


-- Query 43: Products with average review above category's average product rating
SELECT p.product_id,p.product_name,AVG(r.rating) AS avg_rating FROM products p JOIN reviews r USING(product_id) GROUP BY p.product_id,p.product_name,p.category_id HAVING AVG(r.rating) > (SELECT AVG(r2.rating) FROM products p2 JOIN reviews r2 USING(product_id) WHERE p2.category_id=p.category_id);


-- Query 44: Price categories
SELECT product_name,price,CASE WHEN price<500 THEN 'Budget' WHEN price<=2000 THEN 'Mid Range' ELSE 'Premium' END AS price_category FROM products;


-- Query 45: Stock categories
SELECT product_name,stock_quantity,CASE WHEN stock_quantity=0 THEN 'Out of Stock' WHEN stock_quantity<=10 THEN 'Low Stock' WHEN stock_quantity<=50 THEN 'Medium Stock' ELSE 'High Stock' END AS stock_category FROM products;


-- Query 46: Order status descriptions
SELECT order_id,order_status,CASE order_status WHEN 'Pending' THEN 'Awaiting Processing' WHEN 'Shipped' THEN 'On the Way' WHEN 'Delivered' THEN 'Completed' WHEN 'Cancelled' THEN 'Order Cancelled' WHEN 'Processing' THEN 'Being Prepared' END AS status_description FROM orders;


-- Query 47: CTE customer spending above 5000
WITH customer_spending AS (SELECT c.customer_id,c.first_name,c.last_name,COALESCE(SUM(o.total_amount) FILTER(WHERE o.order_status<>'Cancelled'),0) AS total_spent FROM customers c LEFT JOIN orders o USING(customer_id) GROUP BY c.customer_id) SELECT * FROM customer_spending WHERE total_spent>5000;


-- Query 48: Ten highest-selling products
WITH product_sales AS (SELECT p.product_id,p.product_name,COALESCE(SUM(oi.quantity),0) AS quantity_sold,COALESCE(SUM(oi.quantity*oi.unit_price*(1-oi.discount/100)),0) AS sales FROM products p LEFT JOIN order_items oi USING(product_id) GROUP BY p.product_id,p.product_name) SELECT * FROM product_sales ORDER BY quantity_sold DESC LIMIT 10;


-- Query 49: Multiple CTEs
WITH customer_order_summary AS (SELECT customer_id,COUNT(*) AS order_count,SUM(total_amount) AS order_value FROM orders GROUP BY customer_id), product_sales_summary AS (SELECT product_id,SUM(quantity) AS units_sold FROM order_items GROUP BY product_id) SELECT c.customer_id,c.first_name,COALESCE(cos.order_count,0) AS order_count,COALESCE(cos.order_value,0) AS order_value,COALESCE(pss.units_sold,0) AS units_sold FROM customers c LEFT JOIN customer_order_summary cos USING(customer_id) CROSS JOIN (SELECT SUM(units_sold) AS all_units FROM product_sales_summary) total LEFT JOIN LATERAL (SELECT SUM(quantity) AS units_sold FROM order_items oi JOIN orders o USING(order_id) WHERE o.customer_id=c.customer_id) pss ON TRUE;


-- Query 50: Customers above average customer spending
WITH spend AS (SELECT c.customer_id,c.first_name,c.last_name,COALESCE(SUM(o.total_amount) FILTER(WHERE o.order_status<>'Cancelled'),0) AS total_spent FROM customers c LEFT JOIN orders o USING(customer_id) GROUP BY c.customer_id) SELECT * FROM spend WHERE total_spent>(SELECT AVG(total_spent) FROM spend);


-- Query 51: Recursive category hierarchy
WITH RECURSIVE category_tree AS (SELECT category_id,category_name,parent_category_id,0 AS level FROM categories WHERE parent_category_id IS NULL UNION ALL SELECT c.category_id,c.category_name,c.parent_category_id,ct.level+1 FROM categories c JOIN category_tree ct ON c.parent_category_id=ct.category_id) SELECT ct.category_id,ct.category_name,p.category_name AS parent_category,ct.level FROM category_tree ct LEFT JOIN categories p ON p.category_id=ct.parent_category_id ORDER BY category_id;


-- Query 52: Indented category hierarchy
WITH RECURSIVE tree AS (SELECT category_id,category_name,parent_category_id,0 AS lvl,category_name::text AS path FROM categories WHERE parent_category_id IS NULL UNION ALL SELECT c.category_id,c.category_name,c.parent_category_id,t.lvl+1,t.path || ' > ' || c.category_name FROM categories c JOIN tree t ON c.parent_category_id=t.category_id) SELECT REPEAT('    ',lvl)||category_name AS category_hierarchy FROM tree ORDER BY path;


-- Query 53: Customer order summary view
CREATE OR REPLACE VIEW customer_order_summary AS SELECT c.customer_id,c.first_name||' '||c.last_name AS customer_name,COUNT(o.order_id) AS total_orders,COALESCE(SUM(o.total_amount) FILTER(WHERE o.order_status<>'Cancelled'),0) AS total_spent,MAX(o.order_date) AS last_order_date FROM customers c LEFT JOIN orders o USING(customer_id) GROUP BY c.customer_id,c.first_name,c.last_name;


-- Query 54: Five highest spending customers from view
SELECT * FROM customer_order_summary ORDER BY total_spent DESC LIMIT 5;


-- Query 55: Product sales summary view
CREATE OR REPLACE VIEW product_sales_summary AS SELECT p.product_id,p.product_name,c.category_name,COALESCE(SUM(oi.quantity),0) AS total_quantity_sold,COALESCE(SUM(oi.quantity*oi.unit_price*(1-oi.discount/100)),0) AS total_sales FROM products p JOIN categories c USING(category_id) LEFT JOIN order_items oi USING(product_id) GROUP BY p.product_id,p.product_name,c.category_name;


-- Query 56: Products with sales above 10000
SELECT * FROM product_sales_summary WHERE total_sales>10000;


-- Query 57: View update example and explanation
-- customer_order_summary is not automatically updatable because it contains joins, GROUP BY and aggregates.
-- A simple single-table view can be updatable when it has no grouping, aggregates, DISTINCT, set operations, or other disqualifying constructs.
-- Example of an updatable view:
CREATE OR REPLACE VIEW active_customers AS SELECT customer_id,first_name,last_name,email,status FROM customers WHERE status='Active';
UPDATE active_customers SET last_name='Updated' WHERE customer_id=1;
-- The UPDATE changes the underlying customers row. WITH CHECK OPTION can prevent updates that make a row no longer satisfy the view predicate.


-- Query 58: Monthly sales materialized view
CREATE MATERIALIZED VIEW IF NOT EXISTS monthly_sales_summary AS SELECT EXTRACT(YEAR FROM o.order_date)::int AS sales_year,EXTRACT(MONTH FROM o.order_date)::int AS sales_month,COUNT(DISTINCT o.order_id) AS total_orders,COALESCE(SUM(oi.quantity),0) AS total_products_sold,COALESCE(SUM(oi.quantity*oi.unit_price*(1-oi.discount/100)),0) AS total_revenue FROM orders o LEFT JOIN order_items oi USING(order_id) WHERE o.order_status<>'Cancelled' GROUP BY 1,2;


-- Query 59: Query monthly materialized view
SELECT * FROM monthly_sales_summary ORDER BY sales_year,sales_month;


-- Query 60: New order and stale materialized view demonstration
-- Insert a sample order and item (choose an existing customer and product).
INSERT INTO orders(customer_id,order_date,order_status,shipping_city,shipping_country,total_amount) VALUES (1,CURRENT_TIMESTAMP,'Pending','Hyderabad','India',1000) RETURNING order_id;
-- Insert an order item for the returned order_id, then query the materialized view.
-- New rows are not reflected until REFRESH MATERIALIZED VIEW is executed.


-- Query 61: Refresh materialized view
REFRESH MATERIALIZED VIEW monthly_sales_summary;
SELECT * FROM monthly_sales_summary ORDER BY sales_year,sales_month;


-- Query 62: View vs materialized view explanation
-- VIEW: stores query definition only; underlying query runs when selected; always reflects current committed base-table data; no refresh.
-- MATERIALIZED VIEW: stores query result physically; reads can be faster for expensive reports; data can become stale; refresh is required.


-- Query 63: Index customers.email
CREATE UNIQUE INDEX IF NOT EXISTS idx_customers_email ON customers(email);


-- Query 64: Index orders.customer_id
CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);


-- Query 65: Index orders.order_date
CREATE INDEX IF NOT EXISTS idx_orders_order_date ON orders(order_date);


-- Query 66: Composite index on status and date
CREATE INDEX IF NOT EXISTS idx_orders_status_date ON orders(order_status,order_date);


-- Query 67: Composite index products category and price
CREATE INDEX IF NOT EXISTS idx_products_category_price ON products(category_id,price);


-- Query 68: Inspect query plan before and after index
EXPLAIN ANALYZE SELECT * FROM orders WHERE customer_id=10;
-- Create index if it does not already exist, then run EXPLAIN ANALYZE again.
CREATE INDEX IF NOT EXISTS idx_orders_customer_id_explain ON orders(customer_id);
EXPLAIN ANALYZE SELECT * FROM orders WHERE customer_id=10;
-- Small tables may still use a sequential scan because it is cheaper. Compare plan node, estimated/actual rows and execution time.


-- Query 69: Drop index
DROP INDEX IF EXISTS idx_orders_customer_id_explain;
-- Drop an index when it is redundant, unused, costly to maintain, or consumes unnecessary storage.


-- Query 70: Procedure update_product_stock
CREATE OR REPLACE PROCEDURE update_product_stock(p_product_id INT,p_quantity_change INT) LANGUAGE plpgsql AS $$ BEGIN UPDATE products SET stock_quantity=stock_quantity+p_quantity_change WHERE product_id=p_product_id AND stock_quantity+p_quantity_change>=0; IF NOT FOUND THEN RAISE EXCEPTION 'Product not found or stock would become negative'; END IF; END; $$;
-- Example: CALL update_product_stock(1,5);


-- Query 71: Procedure cancel_order
CREATE OR REPLACE PROCEDURE cancel_order(p_order_id INT) LANGUAGE plpgsql AS $$ DECLARE v_status TEXT; BEGIN SELECT order_status INTO v_status FROM orders WHERE order_id=p_order_id FOR UPDATE; IF NOT FOUND THEN RAISE EXCEPTION 'Order % does not exist',p_order_id; END IF; IF v_status='Delivered' THEN RAISE EXCEPTION 'Delivered orders cannot be cancelled'; END IF; IF v_status='Cancelled' THEN RAISE EXCEPTION 'Order is already cancelled'; END IF; UPDATE products p SET stock_quantity=p.stock_quantity+x.qty FROM (SELECT product_id,SUM(quantity) qty FROM order_items WHERE order_id=p_order_id GROUP BY product_id) x WHERE p.product_id=x.product_id; UPDATE orders SET order_status='Cancelled' WHERE order_id=p_order_id; UPDATE payments SET payment_status='Refunded' WHERE order_id=p_order_id AND payment_status='Completed'; END; $$;
-- Example: CALL cancel_order(4);


-- Query 72: Procedure process_payment
CREATE OR REPLACE PROCEDURE process_payment(p_order_id INT,p_payment_method VARCHAR,p_payment_amount NUMERIC,p_transaction_reference VARCHAR) LANGUAGE plpgsql AS $$ BEGIN IF NOT EXISTS(SELECT 1 FROM orders WHERE order_id=p_order_id) THEN RAISE EXCEPTION 'Order does not exist'; END IF; INSERT INTO payments(order_id,payment_date,payment_method,payment_status,amount,transaction_reference) VALUES(p_order_id,CURRENT_TIMESTAMP,p_payment_method,'Completed',p_payment_amount,p_transaction_reference); END; $$;
-- Example: CALL process_payment(1,'UPI',1000,'TXN-NEW-001');


-- Query 73: Procedure mark old processing orders delayed
-- The assignment status list does not include Delayed, so this procedure uses Shipped as a workflow flag only if your schema is extended.
-- Recommended schema extension: ALTER TABLE orders DROP CONSTRAINT orders_order_status_check; then add Delayed to allowed values.
CREATE OR REPLACE PROCEDURE mark_delayed_orders(p_days INT) LANGUAGE plpgsql AS $$ BEGIN IF p_days<0 THEN RAISE EXCEPTION 'Days must be non-negative'; END IF; UPDATE orders SET order_status='Shipped' WHERE order_status='Processing' AND order_date < CURRENT_TIMESTAMP - make_interval(days=>p_days); END; $$;
-- To represent Delayed correctly, extend the CHECK constraint to include 'Delayed' and change SET order_status='Shipped' to 'Delayed'.


-- Query 74: Function calculate_order_total
CREATE OR REPLACE FUNCTION calculate_order_total(p_order_id INT) RETURNS NUMERIC LANGUAGE SQL STABLE AS $$ SELECT COALESCE(SUM(quantity*unit_price*(1-discount/100)),0) FROM order_items WHERE order_id=p_order_id; $$;


-- Query 75: Function customer_total_spending
CREATE OR REPLACE FUNCTION customer_total_spending(p_customer_id INT) RETURNS NUMERIC LANGUAGE SQL STABLE AS $$ SELECT COALESCE(SUM(total_amount),0) FROM orders WHERE customer_id=p_customer_id AND order_status<>'Cancelled'; $$;


-- Query 76: Function get_customer_order_count
CREATE OR REPLACE FUNCTION get_customer_order_count(p_customer_id INT) RETURNS BIGINT LANGUAGE SQL STABLE AS $$ SELECT COUNT(*) FROM orders WHERE customer_id=p_customer_id; $$;


-- Query 77: Function product_average_rating
CREATE OR REPLACE FUNCTION product_average_rating(p_product_id INT) RETURNS NUMERIC LANGUAGE SQL STABLE AS $$ SELECT COALESCE(AVG(rating),0) FROM reviews WHERE product_id=p_product_id; $$;


-- Query 78: Use functions in queries
SELECT customer_id,first_name,customer_total_spending(customer_id) AS total_spending,get_customer_order_count(customer_id) AS order_count FROM customers;
SELECT product_id,product_name,product_average_rating(product_id) AS average_rating FROM products;
SELECT order_id,calculate_order_total(order_id) AS calculated_total FROM orders;


-- Query 79: Rank products by price
SELECT product_id,product_name,price,RANK() OVER(ORDER BY price DESC) AS price_rank FROM products;


-- Query 80: Rank products within category
SELECT product_id,product_name,category_id,price,RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS category_rank FROM products;


-- Query 81: Top three products per category
SELECT * FROM (SELECT p.*,ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY price DESC) AS rn FROM products p) x WHERE rn<=3;


-- Query 82: Running total sales by date
SELECT o.order_date::date AS sales_date,o.order_id,o.total_amount,SUM(o.total_amount) OVER(ORDER BY o.order_date,o.order_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_sales FROM orders o WHERE o.order_status<>'Cancelled';


-- Query 83: Number every customer order
SELECT order_id,customer_id,order_date,ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) AS customer_order_number FROM orders;


-- Query 84: Compare order value with previous customer order
SELECT order_id,customer_id,order_date,total_amount,LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS previous_order_amount,total_amount-LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS difference_from_previous FROM orders;


-- Query 85: Orders placed today
SELECT * FROM orders WHERE order_date::date=CURRENT_DATE;


-- Query 86: Orders in current month
SELECT * FROM orders WHERE order_date>=date_trunc('month',CURRENT_DATE) AND order_date<date_trunc('month',CURRENT_DATE)+INTERVAL '1 month';


-- Query 87: Monthly revenue
SELECT date_trunc('month',o.order_date)::date AS month,SUM(oi.quantity*oi.unit_price*(1-oi.discount/100)) AS revenue FROM orders o JOIN order_items oi USING(order_id) WHERE o.order_status<>'Cancelled' GROUP BY 1 ORDER BY 1;


-- Query 88: Customers with no order in last six months
SELECT c.* FROM customers c WHERE NOT EXISTS(SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id AND o.order_date>=CURRENT_DATE-INTERVAL '6 months');


-- Query 89: Days from registration to first order
SELECT c.customer_id,c.first_name,c.registration_date,MIN(o.order_date)::date AS first_order_date,MIN(o.order_date)::date-c.registration_date AS days_to_first_order FROM customers c LEFT JOIN orders o USING(customer_id) GROUP BY c.customer_id;


-- Query 90: Customer full names
SELECT customer_id,CONCAT(first_name,' ',last_name) AS customer_name FROM customers;


-- Query 91: Emails lowercase
SELECT customer_id,LOWER(email) AS email_lowercase FROM customers;


-- Query 92: Product names uppercase
SELECT product_id,UPPER(product_name) AS product_name_upper FROM products;


-- Query 93: Product name lengths
SELECT product_name,LENGTH(product_name) AS name_length FROM products;


-- Query 94: Email domains
SELECT email,SPLIT_PART(email,'@',2) AS email_domain FROM customers;


-- Query 95: Customers without phone
SELECT * FROM customers WHERE phone IS NULL;


-- Query 96: Phone with fallback
SELECT customer_id,first_name,COALESCE(phone,'Not Available') AS phone FROM customers;


-- Query 97: Products without reviews
SELECT p.* FROM products p WHERE NOT EXISTS(SELECT 1 FROM reviews r WHERE r.product_id=p.product_id);


-- Query 98: UNION unique cities
SELECT city AS city_name FROM customers UNION SELECT shipping_city FROM orders ORDER BY city_name;


-- Query 99: UNION ALL cities
SELECT city AS city_name FROM customers UNION ALL SELECT shipping_city FROM orders ORDER BY city_name;
-- UNION removes duplicate rows; UNION ALL preserves duplicates and is generally faster.


-- Query 100: INTERSECT cities
SELECT city FROM customers INTERSECT SELECT shipping_city FROM orders;


-- Query 101: Customer cities never used for shipping
SELECT city FROM customers EXCEPT SELECT shipping_city FROM orders;


-- Query 102: Successful order transaction
BEGIN;
-- Use a customer and product that exist and have enough stock.
WITH new_order AS (
  INSERT INTO orders(customer_id,order_date,order_status,shipping_city,shipping_country,total_amount)
  VALUES(1,CURRENT_TIMESTAMP,'Pending','Hyderabad','India',1999)
  RETURNING order_id
)
INSERT INTO order_items(order_id,product_id,quantity,unit_price,discount)
SELECT order_id,12,1,1999,0 FROM new_order;
UPDATE products SET stock_quantity=stock_quantity-1 WHERE product_id=12 AND stock_quantity>=1;
INSERT INTO payments(order_id,payment_method,payment_status,amount,transaction_reference)
SELECT MAX(order_id),'UPI','Completed',1999,'TXN-TRANSACTION-DEMO' FROM orders;
COMMIT;


-- Query 103: Failed transaction and rollback
BEGIN;
-- This deliberately violates the stock constraint.
UPDATE products SET stock_quantity=-10 WHERE product_id=1;
-- PostgreSQL marks the transaction as failed; execute:
ROLLBACK;
-- Transactions keep order, items, stock and payment changes consistent.
-- COMMIT saves all changes; ROLLBACK cancels all changes in the transaction.


-- Query 104: Top five customers by spending
SELECT c.customer_id,c.first_name||' '||c.last_name AS customer_name,SUM(o.total_amount) AS total_spent FROM customers c JOIN orders o USING(customer_id) WHERE o.order_status<>'Cancelled' GROUP BY c.customer_id ORDER BY total_spent DESC LIMIT 5;


-- Query 105: Top five best-selling products by quantity
SELECT p.product_id,p.product_name,SUM(oi.quantity) AS quantity_sold FROM products p JOIN order_items oi USING(product_id) JOIN orders o USING(order_id) WHERE o.order_status<>'Cancelled' GROUP BY p.product_id ORDER BY quantity_sold DESC LIMIT 5;


-- Query 106: Top five products by revenue
SELECT p.product_id,p.product_name,SUM(oi.quantity*oi.unit_price*(1-oi.discount/100)) AS revenue FROM products p JOIN order_items oi USING(product_id) JOIN orders o USING(order_id) WHERE o.order_status<>'Cancelled' GROUP BY p.product_id ORDER BY revenue DESC LIMIT 5;


-- Query 107: Category generating most revenue
SELECT c.category_id,c.category_name,SUM(oi.quantity*oi.unit_price*(1-oi.discount/100)) AS revenue FROM categories c JOIN products p USING(category_id) JOIN order_items oi USING(product_id) JOIN orders o USING(order_id) WHERE o.order_status<>'Cancelled' GROUP BY c.category_id ORDER BY revenue DESC LIMIT 1;


-- Query 108: Customers ordered more than five different products
SELECT c.customer_id,c.first_name,c.last_name,COUNT(DISTINCT oi.product_id) AS different_products FROM customers c JOIN orders o USING(customer_id) JOIN order_items oi USING(order_id) GROUP BY c.customer_id HAVING COUNT(DISTINCT oi.product_id)>5;


-- Query 109: Products ordered by more than ten customers
SELECT p.product_id,p.product_name,COUNT(DISTINCT o.customer_id) AS customer_count FROM products p JOIN order_items oi USING(product_id) JOIN orders o USING(order_id) GROUP BY p.product_id HAVING COUNT(DISTINCT o.customer_id)>10;


-- Query 110: Customers buying from at least three categories
SELECT c.customer_id,c.first_name,c.last_name,COUNT(DISTINCT p.category_id) AS categories_bought FROM customers c JOIN orders o USING(customer_id) JOIN order_items oi USING(order_id) JOIN products p USING(product_id) GROUP BY c.customer_id HAVING COUNT(DISTINCT p.category_id)>=3;


-- Query 111: Most popular product in every category
SELECT category_id,product_id,product_name,quantity_sold FROM (SELECT p.category_id,p.product_id,p.product_name,SUM(oi.quantity) AS quantity_sold,RANK() OVER(PARTITION BY p.category_id ORDER BY SUM(oi.quantity) DESC) AS rnk FROM products p JOIN order_items oi USING(product_id) GROUP BY p.category_id,p.product_id,p.product_name) x WHERE rnk=1;


-- Query 112: Customers purchasing same product more than once
SELECT o.customer_id,p.product_id,p.product_name,SUM(oi.quantity) AS units_purchased,COUNT(DISTINCT o.order_id) AS separate_orders FROM orders o JOIN order_items oi USING(order_id) JOIN products p USING(product_id) GROUP BY o.customer_id,p.product_id,p.product_name HAVING COUNT(DISTINCT o.order_id)>1;


-- Query 113: Customer spending above average
WITH spend AS (SELECT c.customer_id,c.first_name,c.last_name,COALESCE(SUM(o.total_amount) FILTER(WHERE o.order_status<>'Cancelled'),0) AS total_spent FROM customers c LEFT JOIN orders o USING(customer_id) GROUP BY c.customer_id) SELECT * FROM spend WHERE total_spent>(SELECT AVG(total_spent) FROM spend);


-- Query 114: Second-highest distinct product price: subquery and window
SELECT MAX(price) AS second_highest_price FROM products WHERE price<(SELECT MAX(price) FROM products);
SELECT product_id,product_name,price FROM (SELECT p.*,DENSE_RANK() OVER(ORDER BY price DESC) AS price_rank FROM products p) x WHERE price_rank=2;


-- Query 115: Third-highest spending customer
SELECT customer_id,customer_name,total_spent FROM (SELECT c.customer_id,c.first_name||' '||c.last_name AS customer_name,SUM(o.total_amount) FILTER(WHERE o.order_status<>'Cancelled') AS total_spent,DENSE_RANK() OVER(ORDER BY SUM(o.total_amount) FILTER(WHERE o.order_status<>'Cancelled') DESC) AS rnk FROM customers c LEFT JOIN orders o USING(customer_id) GROUP BY c.customer_id) x WHERE rnk=3;


-- Query 116: Month with highest revenue
SELECT date_trunc('month',o.order_date)::date AS sales_month,SUM(oi.quantity*oi.unit_price*(1-oi.discount/100)) AS revenue FROM orders o JOIN order_items oi USING(order_id) WHERE o.order_status<>'Cancelled' GROUP BY 1 ORDER BY revenue DESC LIMIT 1;


-- Query 117: Highest average rating with at least three reviews
SELECT p.product_id,p.product_name,AVG(r.rating) AS average_rating,COUNT(*) AS review_count FROM products p JOIN reviews r USING(product_id) GROUP BY p.product_id,p.product_name HAVING COUNT(*)>=3 ORDER BY average_rating DESC LIMIT 1;


-- Query 118: Customers with orders but no reviews
SELECT c.* FROM customers c WHERE EXISTS(SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id) AND NOT EXISTS(SELECT 1 FROM reviews r WHERE r.customer_id=c.customer_id);


-- Query 119: Low stock but high sales
SELECT p.product_id,p.product_name,p.stock_quantity,SUM(oi.quantity) AS units_sold FROM products p JOIN order_items oi USING(product_id) JOIN orders o USING(order_id) WHERE p.stock_quantity<10 AND o.order_status<>'Cancelled' GROUP BY p.product_id HAVING SUM(oi.quantity)>20;


-- Query 120: Customers whose latest order was cancelled
SELECT c.customer_id,c.first_name,c.last_name,o.order_id,o.order_date,o.order_status FROM customers c JOIN LATERAL (SELECT * FROM orders x WHERE x.customer_id=c.customer_id ORDER BY order_date DESC,order_id DESC LIMIT 1) o ON TRUE WHERE o.order_status='Cancelled';
