-- ============================================================
-- SHOPSPHERE E-COMMERCE DATABASE
-- FILE: 01_schema.sql
-- DATABASE: shopsphere_db
-- ============================================================


-- ============================================================
-- 1. CUSTOMERS
-- ============================================================

CREATE TABLE customers (
    customer_id      SERIAL PRIMARY KEY,
    first_name       VARCHAR(50) NOT NULL,
    last_name        VARCHAR(50) NOT NULL,
    email            VARCHAR(150) NOT NULL UNIQUE,
    phone            VARCHAR(20),
    city             VARCHAR(100) NOT NULL,
    country          VARCHAR(100) NOT NULL,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status            VARCHAR(20) NOT NULL DEFAULT 'Active',

    CONSTRAINT chk_customer_status
        CHECK (status IN ('Active', 'Inactive', 'Blocked'))
);


-- ============================================================
-- 2. CATEGORIES
-- ============================================================

CREATE TABLE categories (
    category_id        SERIAL PRIMARY KEY,
    category_name      VARCHAR(100) NOT NULL UNIQUE,
    description        TEXT,
    parent_category_id INTEGER,

    CONSTRAINT fk_category_parent
        FOREIGN KEY (parent_category_id)
        REFERENCES categories(category_id)
        ON DELETE SET NULL
);


-- ============================================================
-- 3. PRODUCTS
-- ============================================================

CREATE TABLE products (
    product_id      SERIAL PRIMARY KEY,
    product_name    VARCHAR(150) NOT NULL,
    category_id     INTEGER NOT NULL,
    price           NUMERIC(12,2) NOT NULL,
    stock_quantity   INTEGER NOT NULL DEFAULT 0,
    supplier_name   VARCHAR(100),
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id),

    CONSTRAINT chk_product_price
        CHECK (price > 0),

    CONSTRAINT chk_product_stock
        CHECK (stock_quantity >= 0)
);


-- ============================================================
-- 4. ORDERS
-- ============================================================

CREATE TABLE orders (
    order_id         SERIAL PRIMARY KEY,
    customer_id      INTEGER NOT NULL,
    order_date       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    order_status     VARCHAR(20) NOT NULL DEFAULT 'Pending',
    shipping_city    VARCHAR(100) NOT NULL,
    shipping_country VARCHAR(100) NOT NULL,
    total_amount     NUMERIC(12,2) NOT NULL DEFAULT 0,

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT chk_order_status
        CHECK (
            order_status IN (
                'Pending',
                'Processing',
                'Shipped',
                'Delivered',
                'Cancelled'
            )
        ),

    CONSTRAINT chk_order_total
        CHECK (total_amount >= 0)
);


-- ============================================================
-- 5. ORDER ITEMS
-- ============================================================

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id      INTEGER NOT NULL,
    product_id    INTEGER NOT NULL,
    quantity      INTEGER NOT NULL,
    unit_price    NUMERIC(12,2) NOT NULL,
    discount      NUMERIC(5,2) NOT NULL DEFAULT 0,

    CONSTRAINT fk_order_item_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_order_item_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT chk_order_item_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_order_item_price
        CHECK (unit_price > 0),

    CONSTRAINT chk_order_item_discount
        CHECK (discount >= 0 AND discount <= 100)
);


-- ============================================================
-- 6. PAYMENTS
-- ============================================================

CREATE TABLE payments (
    payment_id          SERIAL PRIMARY KEY,
    order_id            INTEGER NOT NULL,
    payment_date        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_method      VARCHAR(30) NOT NULL,
    payment_status      VARCHAR(20) NOT NULL DEFAULT 'Pending',
    amount              NUMERIC(12,2) NOT NULL,
    transaction_reference VARCHAR(100) UNIQUE,

    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_payment_method
        CHECK (
            payment_method IN (
                'Credit Card',
                'Debit Card',
                'UPI',
                'PayPal',
                'Cash on Delivery'
            )
        ),

    CONSTRAINT chk_payment_status
        CHECK (
            payment_status IN (
                'Pending',
                'Completed',
                'Failed',
                'Refunded'
            )
        ),

    CONSTRAINT chk_payment_amount
        CHECK (amount >= 0)
);


-- ============================================================
-- 7. REVIEWS
-- ============================================================

CREATE TABLE reviews (
    review_id    SERIAL PRIMARY KEY,
    customer_id  INTEGER NOT NULL,
    product_id   INTEGER NOT NULL,
    rating       INTEGER NOT NULL,
    review_text  TEXT,
    review_date  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_review_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_review_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_review_rating
        CHECK (rating BETWEEN 1 AND 5)
);


-- ============================================================
-- VERIFY TABLES
-- ============================================================

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;