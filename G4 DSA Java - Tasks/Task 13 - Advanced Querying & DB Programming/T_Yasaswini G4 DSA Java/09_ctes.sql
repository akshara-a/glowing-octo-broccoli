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
