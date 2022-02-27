-- method 1:
-- inner WINDOW COUNT function: count each product frequency per customer
-- middle layer WINDOW RANK function: rank the product frequency per customer

SELECT DISTINCT customer_id, product_id, product_name
FROM(
    SELECT customer_id, product_id,
           RANK() OVER (PARTITION BY customer_id ORDER BY freq DESC) AS freq_rk
    FROM (
          SELECT customer_id, product_id,
                 COUNT(*) OVER (PARTITION BY customer_id, product_id) AS freq
          FROM Orders
          ) AS tbl
) AS tbl2
INNER JOIN Products
USING (product_id)
WHERE freq_rk = 1


-- method 2:
-- RANK() + GROUP BY 
-- RANK the order count GROUP BY customer, product
SELECT DISTINCT customer_id, product_id, product_name
FROM(
    SELECT customer_id, product_id, 
           RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(*) DESC) AS rk
    FROM Orders
    GROUP BY customer_id, product_id
) AS tbl
INNER JOIN Products
USING (product_id)
WHERE rk = 1

