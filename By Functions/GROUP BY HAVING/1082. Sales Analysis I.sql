-- method 1:
-- firstly need to confirm if there could be a tie in the max count, 
-- practically, it's possible. so we need a subquery.
-- otherwise can use LIMIT without subquery

SELECT seller_id
FROM Sales
GROUP BY seller_id
HAVING SUM(price) = ( SELECT SUM(price) AS s
                      FROM Sales
                      GROUP BY seller_id 
                      ORDER BY s DESC
                      LIMIT 1)


-- method 2:
-- GROUP BY + RANK() OR DENSE_RANK() 
SELECT DISTINCT seller_id
FROM(
SELECT seller_id, 
    RANK() OVER (ORDER BY SUM(price) DESC) AS rk
FROM sales
GROUP BY seller_id) AS tbl
WHERE rk = 1


-- method 3:
-- with cte

WITH cte AS (
SELECT seller_id, SUM(price) AS s
FROM Sales
GROUP BY seller_id)

SELECT seller_id
FROM cte
WHERE s = (SELECT MAX(s) FROM cte)
