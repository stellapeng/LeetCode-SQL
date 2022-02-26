-- We can use two approaches to rank the salaries per department, and find the top 3
-- The first approach is to use DENSE_RANK()
-- The second approach is to use SELF JOIN, in details, firtly self join using non-equal 
-- on the feild we want to rank along with the associtive filed, then count the distinct
-- higher or equal salary per parimary key, with HAVING clause returning the rank we need

-- method 1: 
-- DENSE_RANK
SELECT d.name AS Department,
       tbl.name AS Employee,
       salary AS Salary
from Department d
INNER JOIN (SELECT *, 
                DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rk
          FROM Employee) as tbl
ON d.id = tbl.departmentId
WHERE rk <= 3

-- method 1.2:
-- still use DENSE_RANK(), join the tables inside the subquery will be faster
SELECT Department, Employee, Salary
FROM (SELECT d.name AS Department,
             e.name AS Employee,
             salary AS Salary,
             DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rk
      FROM Employee e
      INNER JOIN Department d
      ON d.id = e.departmentId) AS tbl
WHERE rk <= 3


-- method 2:
-- rank by SELF JOIN
SELECT D.name AS Department,
       A.name AS Employee,
       A.salary AS Salary
FROM Employee A
LEFT JOIN Employee B
ON A.salary <= B.salary AND A.departmentId = B.departmentId
INNER JOIN Department D
ON A.departmentId = D.id
GROUP BY A.Id
HAVING COUNT(DISTINCT B.salary) <= 3 -- put any rank need to be returned


