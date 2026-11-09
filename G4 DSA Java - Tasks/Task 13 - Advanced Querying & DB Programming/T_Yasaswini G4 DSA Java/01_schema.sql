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
