# method 1:

SELECT DISTINCT 
    l1.Num AS ConsecutiveNums -- can select any tables, l1, l2 or l3
FROM Logs l1,
     Logs l2,
     Logs l3
WHERE l1.id = l2.id + 1 
  AND l2.id = l3.id + 1
  AND l1.num = l2.num
  AND l2.num = l3.num
-- OR WHERE l1.id = l2.id - 1 
--    AND l2.id = l3.id - 1



# method 2:
SELECT DISTINCT num AS ConsecutiveNums
FROM(
    SELECT *, 
        CAST(ROW_NUMBER() OVER (PARTITION BY num ORDER BY id) AS SIGNED) - id AS grp
    FROM Logs) AS tbl
GROUP BY num, grp
HAVING COUNT(num) >=3


