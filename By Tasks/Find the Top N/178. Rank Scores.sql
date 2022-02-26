-- Need to put single quote around rank since it's a funciton keyword

-- method 1:
-- DENSE_RANK
SELECT score, DENSE_RANK() OVER (ORDER BY score DESC) AS 'rank'
FROM Scores
ORDER BY score DESC

-- method 2.1:
-- CROSS JOIN + WHERE
SELECT A.score, COUNT(DISTINCT B.score) AS 'rank'
FROM Scores A
CROSS JOIN Scores B 
WHERE A.score <= B.score 
GROUP BY A.id
ORDER BY A.score DESC

-- method 2.2:
-- SELF JOIN
SELECT A.score, COUNT(DISTINCT B.score) AS 'rank'
FROM Scores A
LEFT JOIN Scores B 
ON A.score <= B.score 
GROUP BY A.id
ORDER BY A.score DESC

-- method 3:
-- subquery can be used in SELECT clause
SELECT A.Score, (SELECT COUNT(DISTINCT(Score)) 
                 FROM Scores B 
                 WHERE A.Score <= B.Score) as `rank`
FROM Scores A
ORDER BY A.Score DESC