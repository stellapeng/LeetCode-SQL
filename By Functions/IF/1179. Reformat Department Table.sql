# in order to reduce some rows and add some columns by group,
# we can use either CASE WHEN or IF functions,
# then aggregate (SUM, MAX, OR MIN) to reduce the eliminate rows by group.

# method 1: 
# SUM() can be replaced by() MIN OR MAX(), they all can eliminate the redundent nulls
SELECT id,
      SUM(CASE WHEN month = 'Jan' THEN revenue ELSE NULL END) AS Jan_Revenue,
      SUM(CASE WHEN month = 'Feb' THEN revenue ELSE NULL END) AS Feb_Revenue,
      SUM(CASE WHEN month = 'Mar' THEN revenue ELSE NULL END) AS Mar_Revenue,
      SUM(CASE WHEN month = 'Apr' THEN revenue ELSE NULL END) AS Apr_Revenue,
      SUM(CASE WHEN month = 'May' THEN revenue ELSE NULL END) AS May_Revenue,
      SUM(CASE WHEN month = 'Jun' THEN revenue ELSE NULL END) AS Jun_Revenue,
      SUM(CASE WHEN month = 'Jul' THEN revenue ELSE NULL END) AS Jul_Revenue,
      SUM(CASE WHEN month = 'Aug' THEN revenue ELSE NULL END) AS Aug_Revenue,
      SUM(CASE WHEN month = 'Sep' THEN revenue ELSE NULL END) AS Sep_Revenue,
      SUM(CASE WHEN month = 'Oct' THEN revenue ELSE NULL END) AS Oct_Revenue,
      SUM(CASE WHEN month = 'Nov' THEN revenue ELSE NULL END) AS Nov_Revenue,
      SUM(CASE WHEN month = 'Dec' THEN revenue ELSE NULL END) AS Dec_Revenue
FROM Department
GROUP BY id


# method 2: 
# SUM() can be replaced by() MIN OR MAX(), they all can eliminate the redundent nulls
SELECT id,
      SUM(IF(month = 'Jan', revenue, NULL)) AS Jan_Revenue,
      SUM(IF(month = 'Feb', revenue, NULL)) AS Feb_Revenue,
      SUM(IF(month = 'Mar', revenue, NULL)) AS Mar_Revenue,
      SUM(IF(month = 'Apr', revenue, NULL)) AS Apr_Revenue,
      SUM(IF(month = 'May', revenue, NULL)) AS May_Revenue,
      SUM(IF(month = 'Jun', revenue, NULL)) AS Jun_Revenue,
      SUM(IF(month = 'Jul', revenue, NULL)) AS Jul_Revenue,
      SUM(IF(month = 'Aug', revenue, NULL)) AS Aug_Revenue,
      SUM(IF(month = 'Sep', revenue, NULL)) AS Sep_Revenue,
      SUM(IF(month = 'Oct', revenue, NULL)) AS Oct_Revenue,
      SUM(IF(month = 'Nov', revenue, NULL)) AS Nov_Revenue,
      SUM(IF(month = 'Dec', revenue, NULL)) AS Dec_Revenue
FROM Department
GROUP BY id