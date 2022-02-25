-- Variant: 
-- The first step to identify the tables need to be joined
-- Two out of the three given tables are used

-- Solution 1
-- RANK() or DENSERANK() OVER Window function 
-- To find the most recent date per partition, don't forget the order the date desencendingly

SELECT product_name, product_id, order_id, order_date
FROM (SELECT product_name, product_id, order_id, order_date, 
             RANK() OVER (PARTITION BY product_id ORDER BY order_date DESC) AS rk
      FROM Orders
      JOIN Products
      USING (product_id)) AS tbl
WHERE rk = 1
ORDER BY product_name, product_id, order_id


-- Solution 2
-- WHERE with multiple row operator

SELECT product_name, product_id, order_id, order_date
FROM Orders
JOIN Products
USING (product_id)
WHERE (product_id, order_date) IN (
    SELECT product_id, MAX(order_date)
    FROM Orders
    JOIN Products
    USING (product_id)
    GROUP BY product_id)
ORDER BY product_name, product_id, order_id


-- Solution 3
-- Two Joins

SELECT product_name, product_id, order_id, order_date
FROM Orders
JOIN Products
USING (product_id)
JOIN (
    SELECT product_id, MAX(order_date) AS MR_date
    FROM Orders
    JOIN Products
    USING (product_id)
    GROUP BY product_id) AS tbl
USING (product_id)
WHERE order_date = MR_date
ORDER BY product_name, product_id, order_id