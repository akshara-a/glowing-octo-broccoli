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
