-- Solution 1
-- RANK() or DENSERANK() OVER Window function

SELECT player_id, device_id
FROM(
SELECT *, RANK() OVER (PARTITION BY  player_id ORDER BY event_date) AS rk
FROM Activity) AS tbl
WHERE rk = 1



-- Solution 2
-- WHERE with multiple row operator

SELECT DISTINCT player_id, device_id
FROM Activity
WHERE (player_id, event_date) IN (
    SELECT player_id, MIN(event_date)
    FROM Activity
    GROUP BY player_id)
