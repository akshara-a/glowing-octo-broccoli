-- 01_schema.sql
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
