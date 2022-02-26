-- Solution 1
-- RANK() or DENSERANK() OVER Window function

ELECT project_id, employee_id
FROM (
    SELECT *, RANK() OVER (PARTITION BY project_id ORDER BY experience_years DESC) AS rk
    FROM Project
    JOIN Employee
    USING (employee_id)) AS tbl
WHERE rk = 1


-- Solution 2
-- WHERE with multiple row operator

SELECT project_id, employee_id
FROM Project
INNER JOIN Employee
USING (employee_id)
WHERE (project_id, experience_years) IN (
    SELECT project_id, MAX(experience_years)
    FROM Project
    INNER JOIN Employee
    USING (employee_id)
    GROUP BY project_id)


-- Solution 3
-- Two Joins

SELECT project_id, employee_id
FROM Project
INNER JOIN Employee
USING(employee_id)
INNER JOIN 
    (SELECT project_id, MAX(experience_years) AS max_years
    FROM Project
    INNER JOIN Employee
    USING(employee_id)
    GROUP BY project_id) as tbl
USING(project_id)
WHERE experience_years = max_years