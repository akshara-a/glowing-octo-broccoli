# ShopSphere E-Commerce Database — SQL Assignment Solution

> **Database:** PostgreSQL  
> **Approach:** The queries below use the table structure and requirements given in the assignment.  
> **Note:** Sample data is assumed to have been inserted according to the required schema.

---

## 1. Database Schema

```sql
CREATE DATABASE shopsphere_db;
```

Connect to `shopsphere_db` before running the following:

```sql
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    phone VARCHAR(20),
    city VARCHAR(80),
    country VARCHAR(80),
    registration_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL
        CHECK (status IN ('Active', 'Inactive', 'Blocked'))
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    parent_category_id INT REFERENCES categories(category_id)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT REFERENCES categories(category_id),
    price NUMERIC(12,2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    supplier_name VARCHAR(120),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(20) NOT NULL
        CHECK (order_status IN
        ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    shipping_city VARCHAR(80),
    shipping_country VARCHAR(80),
    total_amount NUMERIC(12,2) DEFAULT 0
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(12,2) NOT NULL,
    discount NUMERIC(5,2) DEFAULT 0
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20),
    amount NUMERIC(12,2),
    transaction_reference VARCHAR(100)
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE DEFAULT CURRENT_DATE
);
```

---

# Part 3 — Basic SQL Queries

## Query 1 — Display all customers

```sql
SELECT *
FROM customers;
```

## Query 2 — Active customers

```sql
SELECT first_name, last_name, email, city
FROM customers
WHERE status = 'Active';
```

## Query 3 — Products costing more than 1000

```sql
SELECT *
FROM products
WHERE price > 1000;
```

## Query 4 — Products priced between 500 and 2000

```sql
SELECT *
FROM products
WHERE price BETWEEN 500 AND 2000;
```

## Query 5 — Customers from three selected cities

```sql
SELECT *
FROM customers
WHERE city IN ('Delhi', 'Mumbai', 'Prayagraj');
```

## Query 6 — First name starts with A

```sql
SELECT *
FROM customers
WHERE first_name ILIKE 'A%';
```

## Query 7 — Product name contains Phone

```sql
SELECT *
FROM products
WHERE product_name ILIKE '%Phone%';
```

## Query 8 — Newest orders first

```sql
SELECT *
FROM orders
ORDER BY order_date DESC;
```

## Query 9 — Five most expensive products

```sql
SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;
```

## Query 10 — Low-stock products

```sql
SELECT *
FROM products
WHERE stock_quantity < 10;
```

---

# Part 4 — Aggregate Functions

## Query 11

```sql
SELECT COUNT(*) AS total_customers
FROM customers;
```

## Query 12

```sql
SELECT COUNT(*) AS total_products
FROM products;
```

## Query 13

```sql
SELECT AVG(price) AS average_product_price
FROM products;
```

## Query 14

```sql
SELECT MIN(price) AS cheapest_product
FROM products;
```

## Query 15

```sql
SELECT MAX(price) AS most_expensive_product
FROM products;
```

## Query 16

```sql
SELECT SUM(total_amount) AS total_order_value
FROM orders;
```

## Query 17

```sql
SELECT AVG(total_amount) AS average_order_amount
FROM orders;
```

## Query 18

```sql
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
```

---

# Part 5 — GROUP BY and HAVING

## Query 19

```sql
SELECT category_id, COUNT(*) AS product_count
FROM products
GROUP BY category_id
ORDER BY category_id;
```

## Query 20

```sql
SELECT category_id, AVG(price) AS average_price
FROM products
GROUP BY category_id;
```

## Query 21

```sql
SELECT category_id, AVG(price) AS average_price
FROM products
GROUP BY category_id
HAVING AVG(price) > 1000;
```

## Query 22

```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
```

## Query 23

```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_amount) > 5000;
```

## Query 24

```sql
SELECT
    product_id,
    COUNT(*) AS times_ordered
FROM order_items
GROUP BY product_id
HAVING COUNT(*) > 5;
```

---

# Part 6 — SQL Joins

## Query 25 — INNER JOIN

```sql
SELECT
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_date,
    o.order_status,
    o.total_amount
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id;
```

## Query 26 — Multiple-table JOIN

```sql
SELECT
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id;
```

## Query 27 — Product category

```sql
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price
FROM products p
JOIN categories c
    ON p.category_id = c.category_id;
```

## Query 28 — All customers and their orders

```sql
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_id,
    o.order_date,
    o.order_status
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id;
```

## Query 29 — Customers with no orders

```sql
SELECT c.*
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

## Query 30 — Products never ordered

```sql
SELECT p.*
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;
```

## Query 31 — RIGHT JOIN

```sql
SELECT
    c.customer_id,
    c.first_name,
    o.order_id,
    o.order_status
FROM customers c
RIGHT JOIN orders o
    ON c.customer_id = o.customer_id;
```

A `RIGHT JOIN` keeps every row from the table on the right side. An `INNER JOIN` only keeps rows where the join condition matches on both sides.

## Query 32 — FULL OUTER JOIN

```sql
SELECT
    c.customer_id,
    c.first_name,
    o.order_id,
    o.order_status
FROM customers c
FULL OUTER JOIN orders o
    ON c.customer_id = o.customer_id;
```

This keeps unmatched rows from both tables as well as matching rows.

## Query 33 — SELF JOIN

```sql
SELECT
    child.category_name AS child_category,
    parent.category_name AS parent_category
FROM categories child
LEFT JOIN categories parent
    ON child.parent_category_id = parent.category_id
WHERE child.parent_category_id IS NOT NULL;
```

---

# Part 7 — Subqueries

## Query 34

```sql
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
```

## Query 35

```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_amount)
    FROM orders
);
```

## Query 36

```sql
SELECT p.*
FROM products p
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);
```

## Query 37 — EXISTS

```sql
SELECT c.*
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
```

## Query 38 — NOT EXISTS

```sql
SELECT c.*
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
```

## Query 39 — ALL

```sql
SELECT p.*
FROM products p
WHERE p.price > ALL (
    SELECT p2.price
    FROM products p2
    JOIN categories c
        ON p2.category_id = c.category_id
    WHERE c.category_name = 'Computers'
);
```

## Query 40 — ANY

```sql
SELECT p.*
FROM products p
WHERE p.price > ANY (
    SELECT p2.price
    FROM products p2
    WHERE p2.category_id <> p.category_id
);
```

---

# Part 8 — Correlated Subqueries

## Query 41

```sql
SELECT p.*
FROM products p
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
);
```

## Query 42

```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    SUM(o.total_amount) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city
HAVING SUM(o.total_amount) > (
    SELECT AVG(city_total)
    FROM (
        SELECT
            c2.customer_id,
            SUM(o2.total_amount) AS city_total
        FROM customers c2
        JOIN orders o2
            ON c2.customer_id = o2.customer_id
        WHERE c2.city = c.city
        GROUP BY c2.customer_id
    ) x
);
```

## Query 43

```sql
SELECT p.product_id, p.product_name
FROM products p
WHERE EXISTS (
    SELECT 1
    FROM reviews r
    WHERE r.product_id = p.product_id
      AND r.rating > (
          SELECT AVG(r2.rating)
          FROM reviews r2
          JOIN products p2
              ON r2.product_id = p2.product_id
          WHERE p2.category_id = p.category_id
      )
);
```

---

# Part 9 — CASE Expressions

## Query 44

```sql
SELECT
    product_name,
    price,
    CASE
        WHEN price < 500 THEN 'Budget'
        WHEN price <= 2000 THEN 'Mid Range'
        ELSE 'Premium'
    END AS price_category
FROM products;
```

## Query 45

```sql
SELECT
    product_name,
    stock_quantity,
    CASE
        WHEN stock_quantity = 0 THEN 'Out of Stock'
        WHEN stock_quantity <= 10 THEN 'Low Stock'
        WHEN stock_quantity <= 50 THEN 'Medium Stock'
        ELSE 'High Stock'
    END AS stock_level
FROM products;
```

## Query 46

```sql
SELECT
    order_id,
    order_status,
    CASE order_status
        WHEN 'Pending' THEN 'Awaiting Processing'
        WHEN 'Shipped' THEN 'On the Way'
        WHEN 'Delivered' THEN 'Completed'
        WHEN 'Cancelled' THEN 'Order Cancelled'
        ELSE 'Processing'
    END AS status_description
FROM orders;
```

---

# Part 10 — CTEs

## Query 47

```sql
WITH customer_spending AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COALESCE(SUM(o.total_amount), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *
FROM customer_spending
WHERE total_spent > 5000;
```

## Query 48

```sql
WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold
    FROM products p
    LEFT JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT *
FROM product_sales
ORDER BY total_quantity_sold DESC
LIMIT 10;
```

## Query 49

```sql
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
        SUM(quantity * unit_price) AS sales
    FROM order_items
    GROUP BY product_id
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    cos.total_orders,
    cos.total_spent
FROM customers c
LEFT JOIN customer_order_summary cos
    ON c.customer_id = cos.customer_id;
```

## Query 50

```sql
WITH customer_spending AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COALESCE(SUM(o.total_amount), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *
FROM customer_spending
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM customer_spending
);
```

---

# Part 11 — Recursive CTE

## Query 51 — Complete hierarchy

```sql
WITH RECURSIVE category_tree AS (
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS level
    FROM categories
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ct.level + 1
    FROM categories c
    JOIN category_tree ct
        ON c.parent_category_id = ct.category_id
)
SELECT
    ct.category_id,
    ct.category_name,
    p.category_name AS parent_category,
    ct.level
FROM category_tree ct
LEFT JOIN categories p
    ON ct.parent_category_id = p.category_id
ORDER BY ct.level, ct.category_id;
```

## Query 52 — Indented hierarchy

```sql
WITH RECURSIVE category_tree AS (
    SELECT
        category_id,
        category_name,
        parent_category_id,
        0 AS level
    FROM categories
    WHERE parent_category_id IS NULL

    UNION ALL

    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ct.level + 1
    FROM categories c
    JOIN category_tree ct
        ON c.parent_category_id = ct.category_id
)
SELECT
    REPEAT('    ', level) || category_name AS category_hierarchy
FROM category_tree
ORDER BY category_id;
```

---

# Part 12 — Views

## Task 53

```sql
CREATE OR REPLACE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    MAX(o.order_date) AS last_order_date
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
```

## Task 54

```sql
SELECT *
FROM customer_order_summary
ORDER BY total_spent DESC
LIMIT 5;
```

## Task 55

```sql
CREATE OR REPLACE VIEW product_sales_summary AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_sales
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, c.category_name;
```

## Task 56

```sql
SELECT *
FROM product_sales_summary
WHERE total_sales > 10000;
```

## Task 57

```sql
UPDATE customer_order_summary
SET total_spent = 10000
WHERE customer_id = 1;
```

This type of view is not directly updatable because it contains aggregate functions such as `COUNT`, `SUM`, and `MAX`, together with `GROUP BY`. A simple view based on one table without aggregation can often be updated, subject to PostgreSQL's rules.

---

# Part 13 — Materialized Views

## Task 58

```sql
CREATE MATERIALIZED VIEW monthly_sales_summary AS
SELECT
    EXTRACT(YEAR FROM o.order_date)::INT AS sales_year,
    EXTRACT(MONTH FROM o.order_date)::INT AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(oi.quantity), 0) AS total_products_sold,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    EXTRACT(YEAR FROM o.order_date),
    EXTRACT(MONTH FROM o.order_date);
```

## Task 59

```sql
SELECT *
FROM monthly_sales_summary
ORDER BY sales_year, sales_month;
```

## Task 60

After inserting new orders, the materialized view may still show the old results because it stores a physical snapshot of the query result.

## Task 61

```sql
REFRESH MATERIALIZED VIEW monthly_sales_summary;

SELECT *
FROM monthly_sales_summary
ORDER BY sales_year, sales_month;
```

## Task 62 — View vs Materialized View

| Feature | View | Materialized View |
|---|---|---|
| Storage | Stores the query definition | Stores query results |
| Query execution | Runs underlying query when accessed | Reads stored result |
| Performance | Can be slower for complex queries | Usually faster for repeated reports |
| Freshness | Reflects current base-table data | Can become stale |
| Refresh | Not normally required | Must be refreshed |

For a frequently accessed reporting query where slightly old data is acceptable, a materialized view can be a better choice.

---

# Part 14 — Indexes

## Task 63

```sql
CREATE UNIQUE INDEX idx_customers_email
ON customers(email);
```

## Task 64

```sql
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);
```

## Task 65

```sql
CREATE INDEX idx_orders_order_date
ON orders(order_date);
```

## Task 66

```sql
CREATE INDEX idx_orders_status_date
ON orders(order_status, order_date);
```

## Task 67

```sql
CREATE INDEX idx_products_category_price
ON products(category_id, price);
```

## Task 68

```sql
EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 10;
```

Before an appropriate index, PostgreSQL may choose a sequential scan. After creating a useful index, it may choose an index scan or bitmap index scan. The actual plan depends on table size and data distribution.

## Task 69

```sql
DROP INDEX IF EXISTS idx_orders_customer_id;
```

An index may be removed when it is unused, redundant, consumes too much storage, or causes unnecessary overhead during writes.

### Index discussion

**1. Why do indexes improve SELECT performance?**  
They provide a faster way to locate matching rows without checking every row.

**2. Why can indexes decrease INSERT performance?**  
Every inserted row may require the database to update the relevant indexes.

**3. What is a composite index?**  
An index built using two or more columns.

**4. Does column order matter?**  
Yes. PostgreSQL can use the leading columns of a composite index efficiently, so column order should match common filtering and sorting patterns.

**5. Unique vs normal index**  
A unique index also enforces uniqueness. A normal index does not.

**6. When should a column not be indexed?**  
Indexing may not be worthwhile for tiny tables, columns rarely used in filtering, or columns with very low selectivity where the index does not provide enough benefit.

---

# Part 15 — Stored Procedures

## Task 70 — Update stock

```sql
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
        RAISE EXCEPTION 'Stock cannot become negative';
    END IF;

    UPDATE products
    SET stock_quantity = stock_quantity + p_quantity_change
    WHERE product_id = p_product_id;
END;
$$;
```

Example:

```sql
CALL update_product_stock(1, -2);
```

## Task 71 — Cancel order

```sql
CREATE OR REPLACE PROCEDURE cancel_order(p_order_id INT)
LANGUAGE plpgsql
AS $$
DECLARE
    current_status VARCHAR(20);
BEGIN
    SELECT order_status
    INTO current_status
    FROM orders
    WHERE order_id = p_order_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order % does not exist', p_order_id;
    END IF;

    IF current_status = 'Delivered' THEN
        RAISE EXCEPTION 'A delivered order cannot be cancelled';
    END IF;

    IF current_status = 'Cancelled' THEN
        RAISE EXCEPTION 'Order is already cancelled';
    END IF;

    UPDATE orders
    SET order_status = 'Cancelled'
    WHERE order_id = p_order_id;

    UPDATE products p
    SET stock_quantity = p.stock_quantity + oi.quantity
    FROM order_items oi
    WHERE oi.order_id = p_order_id
      AND oi.product_id = p.product_id;
END;
$$;
```

## Task 72 — Process payment

```sql
CREATE OR REPLACE PROCEDURE process_payment(
    p_order_id INT,
    p_payment_method VARCHAR,
    p_payment_amount NUMERIC,
    p_transaction_reference VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM orders WHERE order_id = p_order_id
    ) THEN
        RAISE EXCEPTION 'Order does not exist';
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
```

## Task 73 — Mark old processing orders

```sql
CREATE OR REPLACE PROCEDURE mark_delayed_orders(p_days INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE orders
    SET order_status = 'Pending'
    WHERE order_status = 'Processing'
      AND order_date < CURRENT_TIMESTAMP - (p_days * INTERVAL '1 day');
END;
$$;
```

---

# Part 16 — User-Defined Functions

## Task 74

```sql
CREATE OR REPLACE FUNCTION calculate_order_total(p_order_id INT)
RETURNS NUMERIC
LANGUAGE SQL
AS $$
    SELECT COALESCE(
        SUM(
            quantity * unit_price *
            (1 - COALESCE(discount, 0) / 100)
        ), 0
    )
    FROM order_items
    WHERE order_id = p_order_id;
$$;
```

## Task 75

```sql
CREATE OR REPLACE FUNCTION customer_total_spending(p_customer_id INT)
RETURNS NUMERIC
LANGUAGE SQL
AS $$
    SELECT COALESCE(SUM(total_amount), 0)
    FROM orders
    WHERE customer_id = p_customer_id
      AND order_status <> 'Cancelled';
$$;
```

## Task 76

```sql
CREATE OR REPLACE FUNCTION get_customer_order_count(p_customer_id INT)
RETURNS INT
LANGUAGE SQL
AS $$
    SELECT COUNT(*)::INT
    FROM orders
    WHERE customer_id = p_customer_id;
$$;
```

## Task 77

```sql
CREATE OR REPLACE FUNCTION product_average_rating(p_product_id INT)
RETURNS NUMERIC
LANGUAGE SQL
AS $$
    SELECT COALESCE(AVG(rating), 0)
    FROM reviews
    WHERE product_id = p_product_id;
$$;
```

## Task 78

```sql
SELECT
    customer_id,
    first_name,
    customer_total_spending(customer_id) AS total_spending
FROM customers;
```

---

# Part 17 — Procedure vs Function

| Feature | Procedure | Function |
|---|---|---|
| Returns value | Not required | Yes |
| Called using | `CALL` | `SELECT` / expression |
| Can be used in SELECT | No | Yes |
| Transaction control | Can support transaction control in appropriate contexts | More restricted |
| Typical use | Performing an action | Calculating/returning a value |

A procedure is useful when the main purpose is to perform an operation such as cancelling an order or updating stock. A function is more suitable when a value needs to be calculated and returned.

---

# Part 18 — Window Functions

## Query 79

```sql
SELECT
    product_id,
    product_name,
    price,
    RANK() OVER (ORDER BY price DESC) AS price_rank
FROM products;
```

## Query 80

```sql
SELECT
    product_id,
    product_name,
    category_id,
    price,
    RANK() OVER (
        PARTITION BY category_id
        ORDER BY price DESC
    ) AS category_rank
FROM products;
```

## Query 81

```sql
WITH ranked_products AS (
    SELECT
        p.*,
        ROW_NUMBER() OVER (
            PARTITION BY category_id
            ORDER BY price DESC
        ) AS rn
    FROM products p
)
SELECT *
FROM ranked_products
WHERE rn <= 3;
```

## Query 82

```sql
WITH daily_sales AS (
    SELECT
        DATE(o.order_date) AS sales_date,
        SUM(oi.quantity * oi.unit_price) AS daily_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY DATE(o.order_date)
)
SELECT
    sales_date,
    daily_revenue,
    SUM(daily_revenue) OVER (
        ORDER BY sales_date
    ) AS running_total
FROM daily_sales
ORDER BY sales_date;
```

## Query 83

```sql
SELECT
    order_id,
    customer_id,
    order_date,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS order_number
FROM orders;
```

## Query 84

```sql
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
```

---

# Part 19 — Date and Time Queries

## Query 85

```sql
SELECT *
FROM orders
WHERE order_date::DATE = CURRENT_DATE;
```

## Query 86

```sql
SELECT *
FROM orders
WHERE DATE_TRUNC('month', order_date)
      = DATE_TRUNC('month', CURRENT_DATE);
```

## Query 87

```sql
SELECT
    DATE_TRUNC('month', order_date) AS sales_month,
    SUM(total_amount) AS monthly_revenue
FROM orders
WHERE order_status <> 'Cancelled'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;
```

## Query 88

```sql
SELECT c.*
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.order_date >= CURRENT_DATE - INTERVAL '6 months'
);
```

## Query 89

```sql
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.registration_date,
    MIN(o.order_date::DATE) AS first_order_date,
    MIN(o.order_date::DATE) - c.registration_date
        AS days_to_first_order
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.registration_date;
```

---

# Part 20 — String Functions

## Query 90

```sql
SELECT CONCAT(first_name, ' ', last_name) AS customer_name
FROM customers;
```

## Query 91

```sql
SELECT LOWER(email) AS email
FROM customers;
```

## Query 92

```sql
SELECT UPPER(product_name) AS product_name
FROM products;
```

## Query 93

```sql
SELECT
    product_name,
    LENGTH(product_name) AS name_length
FROM products;
```

## Query 94

```sql
SELECT
    email,
    SPLIT_PART(email, '@', 2) AS email_domain
FROM customers;
```

---

# Part 21 — NULL Handling

## Query 95

```sql
SELECT *
FROM customers
WHERE phone IS NULL;
```

## Query 96

```sql
SELECT
    first_name,
    last_name,
    COALESCE(phone, 'Not Available') AS phone
FROM customers;
```

## Query 97

```sql
SELECT p.*
FROM products p
LEFT JOIN reviews r
    ON p.product_id = r.product_id
WHERE r.review_id IS NULL;
```

---

# Part 22 — Set Operations

## Query 98 — UNION

```sql
SELECT city
FROM customers

UNION

SELECT shipping_city
FROM orders;
```

`UNION` removes duplicate rows.

## Query 99 — UNION ALL

```sql
SELECT city
FROM customers

UNION ALL

SELECT shipping_city
FROM orders;
```

`UNION ALL` keeps duplicates and therefore usually requires less work than `UNION`.

## Query 100 — INTERSECT

```sql
SELECT city
FROM customers

INTERSECT

SELECT shipping_city
FROM orders;
```

## Query 101 — EXCEPT

```sql
SELECT city
FROM customers

EXCEPT

SELECT shipping_city
FROM orders;
```

---

# Part 23 — Transactions

## Example transaction

```sql
BEGIN;

INSERT INTO orders (
    customer_id,
    order_date,
    order_status,
    shipping_city,
    shipping_country,
    total_amount
)
VALUES (
    1,
    CURRENT_TIMESTAMP,
    'Processing',
    'Prayagraj',
    'India',
    1500
);

-- Use the generated order id from the inserted order
-- before inserting its order items.

INSERT INTO order_items (
    order_id,
    product_id,
    quantity,
    unit_price,
    discount
)
VALUES (
    41,
    1,
    1,
    1500,
    0
);

UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 1
  AND stock_quantity >= 1;

INSERT INTO payments (
    order_id,
    payment_method,
    payment_status,
    amount,
    transaction_reference
)
VALUES (
    41,
    'UPI',
    'Completed',
    1500,
    'TXN-DEMO-001'
);

COMMIT;
```

For a real application, the order ID should be captured with `INSERT ... RETURNING order_id` rather than hard-coded.

## Task 103 — Failed transaction

```sql
BEGIN;

UPDATE products
SET stock_quantity = stock_quantity - 100000
WHERE product_id = 1
  AND stock_quantity >= 100000;

-- Suppose another operation fails here.

ROLLBACK;
```

Transactions are important because placing an order consists of multiple related operations. If one operation fails, the database should not be left with a partially completed order.

---

# Part 24 — Advanced Business Queries

## Query 104

```sql
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spending DESC
LIMIT 5;
```

## Query 105

```sql
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS quantity_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY quantity_sold DESC
LIMIT 5;
```

## Query 106

```sql
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 5;
```

## Query 107

```sql
SELECT
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.category_id, c.category_name
ORDER BY revenue DESC
LIMIT 1;
```

## Query 108

```sql
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT oi.product_id) AS different_products
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT oi.product_id) > 5;
```

## Query 109

```sql
SELECT
    p.product_id,
    p.product_name,
    COUNT(DISTINCT o.customer_id) AS customer_count
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(DISTINCT o.customer_id) > 10;
```

## Query 110

```sql
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT p.category_id) >= 3;
```

## Query 111

```sql
WITH product_counts AS (
    SELECT
        p.category_id,
        p.product_id,
        p.product_name,
        SUM(oi.quantity) AS quantity_sold
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.category_id, p.product_id, p.product_name
),
ranked AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY category_id
            ORDER BY quantity_sold DESC
        ) AS rnk
    FROM product_counts
)
SELECT *
FROM ranked
WHERE rnk = 1;
```

## Query 112

```sql
SELECT
    o.customer_id,
    oi.product_id,
    p.product_name,
    COUNT(DISTINCT o.order_id) AS number_of_orders
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY o.customer_id, oi.product_id, p.product_name
HAVING COUNT(DISTINCT o.order_id) > 1;
```

## Query 113

```sql
WITH spending AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COALESCE(SUM(o.total_amount), 0) AS total_spending
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *
FROM spending
WHERE total_spending > (
    SELECT AVG(total_spending)
    FROM spending
);
```

## Query 114 — Subquery

```sql
SELECT *
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
    WHERE price < (SELECT MAX(price) FROM products)
);
```

## Query 114 — Window function

```sql
WITH ranked AS (
    SELECT *,
        DENSE_RANK() OVER (ORDER BY price DESC) AS price_rank
    FROM products
)
SELECT *
FROM ranked
WHERE price_rank = 2;
```

## Query 115

```sql
WITH spending AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        COALESCE(SUM(o.total_amount), 0) AS total_spending
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (ORDER BY total_spending DESC) AS spending_rank
    FROM spending
)
SELECT *
FROM ranked
WHERE spending_rank = 3;
```

## Query 116

```sql
SELECT
    DATE_TRUNC('month', o.order_date) AS sales_month,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY revenue DESC
LIMIT 1;
```

## Query 117

```sql
SELECT
    p.product_id,
    p.product_name,
    AVG(r.rating) AS average_rating
FROM products p
JOIN reviews r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(r.review_id) >= 3
ORDER BY average_rating DESC
LIMIT 1;
```

## Query 118

```sql
SELECT DISTINCT c.*
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE NOT EXISTS (
    SELECT 1
    FROM reviews r
    WHERE r.customer_id = c.customer_id
);
```

## Query 119

```sql
SELECT
    p.product_id,
    p.product_name,
    p.stock_quantity,
    SUM(oi.quantity) AS quantity_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.stock_quantity
HAVING p.stock_quantity < 10
   AND SUM(oi.quantity) > 20;
```

## Query 120

```sql
WITH latest_orders AS (
    SELECT
        o.*,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC
        ) AS rn
    FROM orders o
)
SELECT *
FROM latest_orders
WHERE rn = 1
  AND order_status = 'Cancelled';
```

---

# Part 25 — Performance Optimization

For the frequently executed query:

```sql
SELECT *
FROM orders
WHERE customer_id = 500
  AND order_status = 'Delivered'
  AND order_date >= '2026-01-01';
```

A composite index is appropriate:

```sql
CREATE INDEX idx_orders_customer_status_date
ON orders(customer_id, order_status, order_date);
```

The equality conditions are placed before the date range condition. This gives PostgreSQL a useful index path for the three predicates.

To check the actual execution plan:

```sql
EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 500
  AND order_status = 'Delivered'
  AND order_date >= '2026-01-01';
```

The index can reduce the amount of data PostgreSQL has to inspect. However, indexes consume storage and have maintenance costs when rows are inserted, updated, or deleted.

---

# Part 26 — View vs Materialized View Case Study

For a dashboard opened hundreds of times per hour where the data only needs to be updated once an hour, a **materialized view** is a sensible choice.

The dashboard can store:

- Monthly revenue
- Total orders
- Total customers
- Total products sold
- Average order value

Example:

```sql
CREATE MATERIALIZED VIEW executive_sales_dashboard AS
SELECT
    DATE_TRUNC('month', o.order_date) AS sales_month,
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    SUM(oi.quantity) AS total_products_sold,
    AVG(o.total_amount) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY DATE_TRUNC('month', o.order_date);
```

Refresh it hourly:

```sql
REFRESH MATERIALIZED VIEW executive_sales_dashboard;
```

An index can be added for month-based filtering:

```sql
CREATE INDEX idx_executive_sales_month
ON executive_sales_dashboard(sales_month);
```

The main advantage is that dashboard queries read precomputed results instead of repeatedly calculating the same aggregates.

The trade-off is that the materialized view is not automatically current until it is refreshed.

---

# Part 27 — Customer Performance Report

```sql
WITH customer_stats AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        c.city,
        c.registration_date,

        COUNT(o.order_id) AS total_orders,

        COUNT(o.order_id) FILTER (
            WHERE o.order_status = 'Delivered'
        ) AS completed_orders,

        COUNT(o.order_id) FILTER (
            WHERE o.order_status = 'Cancelled'
        ) AS cancelled_orders,

        COALESCE(SUM(oi.quantity), 0) AS total_products_purchased,

        COALESCE(
            SUM(
                CASE
                    WHEN o.order_status <> 'Cancelled'
                    THEN o.total_amount
                    ELSE 0
                END
            ), 0
        ) AS total_spent,

        AVG(
            CASE
                WHEN o.order_status <> 'Cancelled'
                THEN o.total_amount
            END
        ) AS average_order_value,

        MAX(o.order_date) AS last_order_date

    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name,
        c.city,
        c.registration_date
),
ranked AS (
    SELECT *,
        RANK() OVER (
            ORDER BY total_spent DESC
        ) AS customer_rank
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
ORDER BY customer_rank;
```

## Customer Performance Report as a view

```sql
CREATE OR REPLACE VIEW customer_performance_report AS
WITH customer_stats AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        c.city,
        c.registration_date,
        COUNT(DISTINCT o.order_id) AS total_orders,
        COUNT(DISTINCT o.order_id) FILTER (
            WHERE o.order_status = 'Delivered'
        ) AS completed_orders,
        COUNT(DISTINCT o.order_id) FILTER (
            WHERE o.order_status = 'Cancelled'
        ) AS cancelled_orders,
        COALESCE(SUM(oi.quantity), 0) AS total_products_purchased,
        COALESCE(
            SUM(
                CASE
                    WHEN o.order_status <> 'Cancelled'
                    THEN o.total_amount
                    ELSE 0
                END
            ), 0
        ) AS total_spent,
        AVG(
            CASE
                WHEN o.order_status <> 'Cancelled'
                THEN o.total_amount
            END
        ) AS average_order_value,
        MAX(o.order_date) AS last_order_date
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name,
        c.city,
        c.registration_date
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
FROM ranked;
```

---

# Part 28 — Executive Sales Dashboard

```sql
CREATE MATERIALIZED VIEW executive_sales_dashboard AS
SELECT
    DATE_TRUNC('month', o.order_date) AS sales_month,
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    SUM(oi.quantity) AS total_products_sold,
    AVG(o.total_amount) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY DATE_TRUNC('month', o.order_date);

CREATE INDEX idx_dashboard_sales_month
ON executive_sales_dashboard(sales_month);

REFRESH MATERIALIZED VIEW executive_sales_dashboard;
```

---

# Part 29 — Documentation Questions

## 1. What is a primary key?

A primary key uniquely identifies each row in a table. It cannot contain duplicate values.

## 2. What is a foreign key?

A foreign key connects one table to another by referencing a key in the related table.

## 3. What is normalization?

Normalization is the process of organizing data into related tables to reduce unnecessary duplication and improve consistency.

## 4. WHERE vs HAVING

`WHERE` filters rows before grouping. `HAVING` filters groups after `GROUP BY`.

## 5. DELETE vs TRUNCATE vs DROP

`DELETE` removes selected rows and can use a `WHERE` condition. `TRUNCATE` quickly removes all rows from a table. `DROP` removes the database object itself.

## 6. INNER JOIN vs LEFT JOIN

`INNER JOIN` returns only matching rows. `LEFT JOIN` returns all rows from the left table and matching rows from the right table.

## 7. What is a self join?

A self join joins a table to itself. It is useful for hierarchical relationships such as parent and child categories.

## 8. What is a subquery?

A subquery is a query nested inside another SQL query.

## 9. What is a correlated subquery?

A correlated subquery refers to a column from the outer query, so it is evaluated in relation to the current outer row.

## 10. What is a CTE?

A Common Table Expression is a temporary named result created with `WITH` and used by the main query.

## 11. What is a recursive CTE?

A recursive CTE repeatedly executes a query against its previous result. It is useful for hierarchical data.

## 12. What is a view?

A view is a stored SQL query that behaves like a virtual table.

## 13. What is a materialized view?

A materialized view stores the result of its query physically.

## 14. What is an index?

An index is a database structure designed to make data lookup more efficient.

## 15. Advantages and disadvantages of indexes

Indexes can make reads faster, but they consume storage and add work to data modifications.

## 16. What is a stored procedure?

A stored procedure is database-side code designed mainly to perform an operation or series of operations.

## 17. What is a function?

A function performs a calculation or operation and returns a value.

## 18. Procedure vs function

Procedures are normally called with `CALL`, while functions can be used inside SQL expressions and return values.

## 19. What is a transaction?

A transaction groups related database operations into one logical unit of work.

## 20. COMMIT and ROLLBACK

`COMMIT` permanently applies the transaction. `ROLLBACK` undoes changes made during the transaction.

## 21. What is a window function?

A window function performs calculations across related rows without collapsing them into a single row.

## 22. RANK vs DENSE_RANK vs ROW_NUMBER

`RANK()` gives equal values the same rank and leaves gaps after ties. `DENSE_RANK()` also gives equal values the same rank but does not leave gaps. `ROW_NUMBER()` gives every row a unique sequential number.

## 23. Why are materialized views useful for reporting?

They can make repeated reporting queries much faster because expensive calculations are performed when the materialized view is refreshed rather than every time the dashboard is opened.

## 24. When should materialized views be refreshed?

They should be refreshed according to how fresh the report needs to be. In the assignment's dashboard scenario, hourly refreshes are appropriate.

## 25. How does EXPLAIN ANALYZE help?

`EXPLAIN ANALYZE` executes a query and displays its execution plan along with actual execution statistics. It helps identify expensive operations and determine whether indexes are being used.

---

# Bonus Challenges

## Bonus 1 — Trigger to reduce stock

```sql
CREATE OR REPLACE FUNCTION reduce_stock_after_order_item()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id
      AND stock_quantity >= NEW.quantity;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Insufficient stock for product %', NEW.product_id;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION reduce_stock_after_order_item();
```

## Bonus 2 — Price history

```sql
CREATE TABLE product_price_history (
    product_id INT REFERENCES products(product_id),
    old_price NUMERIC(12,2),
    new_price NUMERIC(12,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

```sql
CREATE OR REPLACE FUNCTION record_price_change()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF OLD.price IS DISTINCT FROM NEW.price THEN
        INSERT INTO product_price_history (
            product_id,
            old_price,
            new_price,
            changed_at
        )
        VALUES (
            OLD.product_id,
            OLD.price,
            NEW.price,
            CURRENT_TIMESTAMP
        );
    END IF;

    RETURN NEW;
END;
$$;
```

```sql
CREATE TRIGGER trg_product_price_history
AFTER UPDATE OF price ON products
FOR EACH ROW
EXECUTE FUNCTION record_price_change();
```

## Bonus 3 — Automatic modification timestamp

A suitable `updated_at` column can be added:

```sql
ALTER TABLE products
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
```

Then a trigger can update it whenever the product changes.

## Bonus 4 — Partial index

```sql
CREATE INDEX idx_active_products
ON products(category_id, price)
WHERE is_active = TRUE;
```

A partial index contains only rows satisfying the condition, so it can use less storage and be cheaper to maintain than a full index when only a subset of rows is frequently queried.

## Bonus 5 — Unique composite index

```sql
CREATE UNIQUE INDEX idx_unique_customer_product_review
ON reviews(customer_id, product_id);
```

This prevents the same customer from reviewing the same product more than once.

## Bonus 6 — Concurrent materialized view refresh

```sql
REFRESH MATERIALIZED VIEW CONCURRENTLY executive_sales_dashboard;
```

A concurrent refresh allows normal reads of the materialized view while it is being refreshed. PostgreSQL requires a suitable unique index on the materialized view for this operation.

---

# Conclusion

This project demonstrates a small but realistic e-commerce database using PostgreSQL. The database design connects customers, orders, products, categories, payments, reviews, and order items.

The assignment also demonstrates how SQL moves beyond simple `SELECT` statements. Joins combine related data, subqueries solve nested problems, CTEs make complex queries easier to organize, recursive CTEs handle category hierarchies, views provide reusable queries, materialized views improve reporting performance, and indexes help optimize frequently executed queries.

The final procedures, functions, and transactions show how database logic can be placed closer to the data itself. Together, these techniques provide a practical foundation for building and optimizing relational database systems.
