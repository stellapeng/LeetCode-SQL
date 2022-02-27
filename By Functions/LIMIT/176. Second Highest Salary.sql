
-- method 1: LIMIT
-- Only need to return the distinct sencond max salary, we can use LIMIT [OFFSET, ] ROW_COUNT

SELECT IFNULL((SELECT DISTINCT salary    -- must have DISTINCT here
                FROM Employee
                ORDER BY salary DESC
                LIMIT 1, 1),
              NULL) AS  SecondHighestSalary



-- method 2: DENSE_RANK()

SELECT IFNULL((SELECT DISTINCT salary 
                FROM(
                    SELECT *, DENSE_RANK() OVER (ORDER BY salary DESC) AS rk
                    FROM Employee) AS tbl
                WHERE rk = 2),
              NULL) AS  SecondHighestSalary



-- method 3: SELF JOIN

SELECT IFNULL((SELECT DISTINCT salary 
                FROM(
                    SELECT e1.salary, COUNT(DISTINCT e2.salary) AS cnt
                    FROM Employee e1
                    LEFT JOIN Employee e2
                    ON e1.salary <= e2.salary
                    GROUP BY e1.salary) AS tbl
                WHERE cnt = 2),
              NULL) AS  SecondHighestSalary


