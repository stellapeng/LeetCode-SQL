-- method 1:
-- firstly need to confirm if there could be a tie in the max count, 
-- practically, it's possible. so we need a subquery.
-- otherwise can use LIMIT without subquery

SELECT project_id
FROM Project
GROUP BY project_id
HAVING COUNT(employee_id) = (SELECT COUNT(employee_id) AS em_num
                            FROM Project
                            GROUP BY project_id
                            ORDER BY em_num DESC
                            LIMIT 1)



-- method 2:
-- GROUP BY + RANK() OR DENSE_RANK()

SELECT DISTINCT project_id
FROM(
    SELECT project_id, RANK() OVER (ORDER BY COUNT(employee_id) DESC) AS rk
    FROM Project
    GROUP BY project_id) AS tbl
WHERE rk = 1


-- method 3:
-- with cte

WITH cte AS (
    SELECT project_id, COUNT(employee_id) AS cnt
    FROM Project
    GROUP BY project_id
)

SELECT project_id 
FROM cte
WHERE cnt = (SELECT MAX(cnt) FROM cte)

