# method 1:
# when count(numbers) % 2 == 0, two nums will be returned, e.g. 12 numbers in total, the 6th and 7th will be returned
# when count(numbers) % 2 == 1, one num from the second condition will be returns, e.g. 11 numbers in total, the 6th is the median
WITH cte AS(
    SELECT *, SUM(frequency) OVER (ORDER BY num)AS cumsum
    FROM Numbers
)

SELECT ROUND(AVG(num), 1) AS median
FROM cte
WHERE num = (SELECT MIN(num) 
             FROM cte 
             WHERE cumsum = (
                             SELECT SUM(frequency)/2 
                             FROM cte))
 OR  num = (SELECT MIN(num) 
             FROM cte 
             WHERE cumsum > (
                             SELECT SUM(frequency)/2 
                             FROM cte))    


# method 2:
# cum_sum: cumulative count of numbers until current row
# cum_sum - frequency: cumulative count of numbers before current row
SELECT ROUND(AVG(num), 1) AS median
FROM (
    SELECT *,
        SUM(frequency) OVER (ORDER BY num) AS cum_sum,
        SUM(frequency) OVER () AS s
    FROM Numbers
    ) AS tbl
WHERE s/2.0 BETWEEN cum_sum - frequency AND cum_sum;
    