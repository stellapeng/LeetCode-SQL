-- UPDATE table_name
-- SET column1 = value1, column2 = value2, ...
-- WHERE condition;


UPDATE salary
SET sex = CASE
            WHEN sex = 'm' THEN 'f'
            ELSE 'm'
           END
           

UPDATE salary
SET sex = CASE sex
            WHEN  'm' THEN 'f'
            ELSE 'm'
           END;
    

UPDATE Salary
SET sex = IF(sex = 'm', 'f', 'm')

