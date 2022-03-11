# method 1.1:
# use window functions
# integer division: DIV
SELECT DISTINCT id, company, salary
FROM(
SELECT *,
       COUNT(id) OVER (PARTITION BY company) AS cnt,
       ROW_NUMBER() OVER (PARTITION BY company ORDER BY salary) AS rn  
FROM Employee) AS tbl
WHERE rn BETWEEN (cnt + 1) DIV 2 AND (cnt + 2) DIV 2

# method 1.2:
SELECT DISTINCT id, company, salary
FROM(
SELECT *,
       COUNT(id) OVER (PARTITION BY company) AS cnt,
       RANK() OVER (PARTITION BY company ORDER BY salary, id) AS rk
FROM Employee) AS tbl
WHERE rk BETWEEN (cnt + 1) DIV 2 AND (cnt + 2) DIV 2



# method 2:
# Follow up: Could you solve it without using any built-in or window functions?
# use LEFT JOIN to rank the salaries per company
SELECT B.id, B.company, B.salary
FROM (SELECT company, 
             (COUNT(*) + 1) DIV 2 AS s, 
             (COUNT(*) + 1) DIV 2 + if(COUNT(*) % 2=1,0,1) AS e
    FROM Employee
    GROUP BY company) A
JOIN (SELECT e1.id, e1.company, e1.salary, COUNT(e2.id) AS rn
     FROM Employee e1
     LEFT JOIN Employee e2
     ON e1.company = e2.company 
      AND (e1.id >= e2.id AND e1.salary = e2.salary OR e1.salary > e2.salary)
     GROUP BY e1.id, e1.company, e1.salary) B
ON A.company = B.company
AND rn BETWEEN s AND e

