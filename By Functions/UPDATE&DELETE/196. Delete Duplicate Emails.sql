-- DELETE FROM table_name WHERE condition;

-- method 1:
-- when use NOT IN, make sure the subquery never returns NULL
DELETE FROM Person
WHERE id NOT IN (
    SELECT min_id
        FROM(
        SELECT MIN(id) AS min_id
        FROM Person
        GROUP BY email) AS tbl
    )
    

-- method 2:    
DELETE p1
FROM Person p1, Person p2 -- SELF CROSS JOIN
WHERE p1.Email = p2.Email AND p1.id > p2.id

