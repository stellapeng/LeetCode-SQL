-- We can use two approaches to rank the salaries per department, and find the top 3
-- The first approach is to use DENSE_RANK()
-- The second approach is to use SELF JOIN, in details, firtly self join using non-equal 
-- on the feild we want to rank along with the associtive filed, then count the distinct
-- higher or equal salary per parimary key, with HAVING clause returning the rank we need

-- method 1: 
-- DENSE_RANK()
SELECT customer_name, customer_id, order_id, order_date
FROM (
    SELECT name AS customer_name,
           customer_id,
           order_id,
           order_date,
           RANK() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rk
    FROM Orders
    INNER JOIN Customers
    USING (customer_id)
    ) AS tbl
WHERE rk <= 3
ORDER BY customer_name, customer_id, order_date DESC


-- method 2:
-- rank by SELF JOIN
SELECT c.name AS customer_name, A.customer_id, A.order_id, A.order_date
FROM Orders A
LEFT JOIN Orders B
ON A.order_date <= B.order_date and A.customer_id = B.customer_id
INNER JOIN Customers c
ON A.customer_id = c.Customer_id
GROUP BY c.name, A.customer_id, A.order_id  -- dont forget to group by all feilds not in the agg funciton
ORDER BY customer_name, customer_id, order_date DESC