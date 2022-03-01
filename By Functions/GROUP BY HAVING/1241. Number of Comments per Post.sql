
-- method 1: subquery
SELECT s1.sub_id AS post_id, 
       IFNULL(COUNT(DISTINCT s2.sub_id), 0) AS number_of_comments
FROM (SELECT * FROM Submissions WHERE parent_id IS NULL) AS s1
LEFT JOIN Submissions s2
ON s1.sub_id = s2.parent_id
GROUP BY s1.sub_id
ORDER BY s1.sub_id

-- method 2: ON + WHERE
SELECT s1.sub_id AS post_id, 
       IFNULL(COUNT(DISTINCT s2.sub_id), 0) AS number_of_comments
FROM Submissions s1
LEFT JOIN Submissions s2
ON s1.sub_id = s2.parent_id 
WHERE s1.parent_id IS NULL
GROUP BY s1.sub_id
ORDER BY s1.sub_id