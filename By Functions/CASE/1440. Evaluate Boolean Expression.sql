SELECT e.*, 
    CASE 
        WHEN operator = '>' AND v1.value > v2.value OR
             operator = '<' AND v1.value < v2.value OR
             operator = '=' AND v1.value = v2.value THEN 'true'
        ELSE 'false'
    END AS value
FROM Expressions e
LEFT JOIN Variables v1 
ON e.left_operand = v1.name
LEFT JOIN Variables v2
ON e.right_operand = v2.name



SELECT e.*, 
    CASE 
        WHEN operator = '>' AND v1.value > v2.value THEN 'true'
        WHEN operator = '<' AND v1.value < v2.value THEN 'true'
        WHEN operator = '=' AND v1.value = v2.value THEN 'true'
        ELSE 'false'
    END AS value
FROM Expressions e
LEFT JOIN Variables v1 
ON e.left_operand = v1.name
LEFT JOIN Variables v2
ON e.right_operand = v2.name