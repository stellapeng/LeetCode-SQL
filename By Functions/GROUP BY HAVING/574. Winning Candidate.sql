# we can use LIMIT here, because the test cases are generated so that exactly one candidate wins the elections.
# method 1: efficient
SELECT name
FROM Candidate
WHERE id = (
    SELECT candidateId 
    FROM Vote
    GROUP BY candidateId
    ORDER BY COUNT(candidateId) DESC
    LIMIT 1)

# method 2: slower
SELECT name 
FROM Vote v
INNER JOIN Candidate c
ON c.id = v.candidateId
GROUP BY v.candidateId
ORDER BY COUNT(v.candidateId) DESC
LIMIT 1