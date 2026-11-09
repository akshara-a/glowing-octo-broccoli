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
