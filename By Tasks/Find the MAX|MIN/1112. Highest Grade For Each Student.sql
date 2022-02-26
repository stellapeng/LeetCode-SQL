-- Variant: SELECT the MAX by two fields

-- Solution 1
-- RANK() or DENSERANK() OVER Window function with two PARTITION KEYS

SELECT student_id, course_id, grade
FROM (SELECT *, RANK() OVER (PARTITION BY student_id ORDER BY grade DESC, course_id) AS rk
      FROM Enrollments) as tbl
WHERE rk = 1
ORDER BY student_id


-- Solution 2
-- WHERE with multiple row operator

SELECT student_id, MIN(course_id) AS course_id, grade
FROM Enrollments
WHERE (student_id, grade) IN (
    SELECT student_id, MAX(grade)
    FROM Enrollments
    GROUP BY student_id)
GROUP BY student_id
ORDER BY student_id


-- Solution 3
-- Two Joins, Two Group By

SELECT student_id, MIN(course_id) AS course_id, grade
FROM Enrollments
INNER JOIN (SELECT student_id, MAX(grade) AS grade
FROM Enrollments
GROUP BY student_id) as tbl
USING(student_id, grade)
GROUP BY(student_id)
ORDER BY student_id, course_id

