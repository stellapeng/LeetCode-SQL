
-- GROUP BY
SELECT dept_name, IFNULL(COUNT(student_id), 0) AS student_number
FROM Department
LEFT JOIN Student
USING (dept_id)
GROUP BY dept_name
ORDER BY student_number DESC, dept_name


-- DISTINCT + WINDOW()
SELECT DISTINCT dept_name, IFNULL(COUNT(student_id) OVER (PARTITION BY dept_name), 0) AS student_number
FROM Department
LEFT JOIN Student
USING (dept_id)
ORDER BY student_number DESC, dept_name


-- Similar problems:
-- 511. Game Play Analysis I
-- 1113. Reported Posts
-- 1141. User Activity for the Past
-- 1069. Product Sales Analysis II
-- 1075. Project Employees I
