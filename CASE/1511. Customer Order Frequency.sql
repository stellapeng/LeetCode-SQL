-- Solution 1
-- There are two subqueries, first subquery is to agg value per customer per month in june and july
-- the second subquery is to count the count of months with value >= 100

SELECT DISTINCT customer_id, name
FROM(
    SELECT customer_id, 
        COUNT(month) OVER (PARTITION BY customer_id) AS cnt
    FROM (
        SELECT MONTH(order_date) AS month, 
               customer_id, 
               SUM(quantity * price) AS order_value
        FROM orders
        INNER JOIN Product
        USING (product_id)
        WHERE order_date BETWEEN '2020-06-01' AND '2020-07-31'
        GROUP BY MONTH(order_date), customer_id) AS tbl
    WHERE order_value >= 100) AS tbl2
INNER JOIN Customers
USING (customer_id)
WHERE cnt = 2


-- Solution 2
-- To recuduce the nested queries, we should come up with a better way to identify the "spend over 100 in each month", which gives us the solution 2 as below:
-- AGGREGATION ON CASE WHEN

SELECT customer_id, name
FROM (
    SELECT customer_id, name,
           SUM(CASE WHEN LEFT(order_date, 7)='2020-06' THEN quantity * price END) AS june_spend,
           SUM(CASE WHEN LEFT(order_date, 7)='2020-07' THEN quantity * price END) AS july_spend
    FROM orders o
    INNER JOIN Product p
    USING (product_id)
    INNER JOIN Customers
    USING (customer_id)
    GROUP BY customer_id
    HAVING june_spend >= 100 AND july_spend >= 100
    ) AS tbl
-- WHERE june_spend >= 100 AND july_spend >= 100