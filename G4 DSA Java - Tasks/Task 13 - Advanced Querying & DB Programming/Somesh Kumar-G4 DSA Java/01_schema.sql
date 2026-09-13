-- =========================================================
-- TASK 13 - ADVANCED QUERYING & DB PROGRAMMING
-- ShopSphere Database Schema
-- =========================================================

-- =========================================================
-- CLEAN EXISTING TABLES
-- =========================================================

DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS customers CASCADE;


-- =========================================================
-- 1. CUSTOMERS
-- =========================================================

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'Active'
        CHECK (status IN ('Active', 'Inactive', 'Blocked'))
);


-- =========================================================
-- 2. CATEGORIES
-- =========================================================

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    parent_category_id INT
        REFERENCES categories(category_id)
);


-- =========================================================
-- 3. PRODUCTS
-- =========================================================

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT
        REFERENCES categories(category_id),
    price DECIMAL(10,2) NOT NULL
        CHECK (price > 0),
    stock_quantity INT NOT NULL
        CHECK (stock_quantity >= 0),
    supplier_name VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);


-- =========================================================
-- 4. ORDERS
-- =========================================================

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL
        REFERENCES customers(customer_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(20) NOT NULL
        CHECK (
            order_status IN (
                'Pending',
                'Processing',
                'Shipped',
                'Delivered',
                'Cancelled'
            )
        ),
    shipping_city VARCHAR(100),
    shipping_country VARCHAR(100),
    total_amount DECIMAL(10,2) NOT NULL
        CHECK (total_amount >= 0)
);


-- =========================================================
-- 5. ORDER ITEMS
-- =========================================================

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL
        REFERENCES orders(order_id)
        ON DELETE CASCADE,
    product_id INT NOT NULL
        REFERENCES products(product_id),
    quantity INT NOT NULL
        CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL
        CHECK (unit_price >= 0),
    discount DECIMAL(10,2) NOT NULL DEFAULT 0
        CHECK (discount >= 0)
);


-- =========================================================
-- 6. PAYMENTS
-- =========================================================

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE
        REFERENCES orders(order_id)
        ON DELETE CASCADE,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(30) NOT NULL
        CHECK (
            payment_method IN (
                'Credit Card',
                'Debit Card',
                'UPI',
                'PayPal',
                'Cash on Delivery'
            )
        ),
    payment_status VARCHAR(20) NOT NULL
        CHECK (
            payment_status IN (
                'Pending',
                'Completed',
                'Failed',
                'Refunded'
            )
        ),
    amount DECIMAL(10,2) NOT NULL
        CHECK (amount >= 0),
    transaction_reference VARCHAR(100)
);


-- =========================================================
-- 7. REVIEWS
-- =========================================================

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    customer_id INT
        REFERENCES customers(customer_id)
        ON DELETE CASCADE,
    product_id INT
        REFERENCES products(product_id)
        ON DELETE CASCADE,
    rating INT NOT NULL
        CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- =========================================================
-- SCHEMA COMPLETE
-- =========================================================