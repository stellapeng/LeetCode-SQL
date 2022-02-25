-- Solution 1
-- RANK() or DENSERANK() OVER Window function

SELECT Department, Employee, Salary
FROM(
SELECT d.name AS Department, 
        e.name AS Employee, 
        e.salary AS Salary,
        RANK() OVER (PARTITION BY d.id ORDER BY salary DESC) AS rk
FROM Department d
INNER JOIN Employee e
ON d.id = e.departmentId) AS tbl
WHERE rk = 1



-- Solution 2
-- WHERE with multiple row operator

SELECT d.name AS Department, 
       e.name AS Employee, 
       e.salary AS Salary 
FROM Employee e
JOIN Department d
ON e.departmentId = d.id
WHERE (d.id, e.salary) IN (
    SELECT departmentID, MAX(e.salary)
    FROM Employee e
    GROUP BY departmentID)


