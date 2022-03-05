# in order to reduce some rows and add some columns by group,
# we can use either CASE WHEN or IF functions,
# then aggregate (MAX, OR MIN for strings) to reduce the eliminate rows by group.
# in this question, the group id should be the row number

# method 1:
# CASE WHEN()
SELECT MAX(CASE WHEN continent = 'America' THEN name ELSE NULL END) AS America,
       MAX(CASE WHEN continent = 'Asia' THEN name ELSE NULL END) AS Asia,
       MAX(CASE WHEN continent = 'Europe' THEN name ELSE NULL END) AS Europe
FROM(
SELECT *,
       ROW_NUMBER() over(PARTITION BY continent ORDER BY name) as rn -- cannot use RANK() function here
FROM Student) AS tbl
GROUP BY rn



# method 2:
# IF()
SELECT MIN(IF(continent = 'America', name, NULL)) AS America,
       MIN(IF(continent = 'Asia', name, NULL)) AS Asia,
       MIN(IF(continent = 'Europe', name, NULL)) AS Europe
FROM(
SELECT *,
       ROW_NUMBER() over(PARTITION BY continent ORDER BY name) as rn
FROM Student) AS tbl
GROUP BY rn

