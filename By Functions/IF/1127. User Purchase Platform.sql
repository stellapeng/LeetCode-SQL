# the key part is to union a full left table to join with
# IF can be substituded with CASE WHEN
SELECT spend_date, platform,
       IFNULL(SUM(amount), 0) AS total_amount,
       IFNULL(COUNT(DISTINCT user_id),0)  AS total_users
FROM(
    SELECT DISTINCT(spend_date), 'desktop' platform FROM Spending
    UNION
    SELECT DISTINCT(spend_date), 'mobile' platform FROM Spending
    UNION
    SELECT DISTINCT(spend_date), 'both' platform FROM Spending
   ) AS t1
LEFT JOIN (
    SELECT  spend_date,user_id, amount,
    IF(COUNT(platform) OVER (PARTITION BY spend_date, user_id)=2, 'both', platform) AS platform
    FROM Spending) AS t2
USING(spend_date, platform)
GROUP BY spend_date, platform

