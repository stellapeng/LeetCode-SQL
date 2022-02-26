
-- Variant: Calcuate a ratio after selecting the group MAX|MIN
-- We can use CASE WHEN or SUM IF to calculate the ratio numerator

-- Solution 1
-- RANK() or DENSERANK() OVER Window function 

SELECT ROUND(SUM(CASE 
                    WHEN order_date = customer_pref_delivery_date THEN 1 
                    ELSE 0 
                 END)/COUNT(delivery_id) * 100, 2) AS immediate_percentage
FROM (
    SELECT *, RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS rk
    FROM Delivery) AS tbl
WHERE rk = 1 


-- Solution 2
-- WHERE with multiple row operator

SELECT ROUND(
            (SUM(IF(order_date = customer_pref_delivery_date, 1, 0))/COUNT(delivery_id)) * 100, 
            2) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date)
    FROM Delivery
    GROUP BY customer_id) 
    
 
-- Solution 3
-- Two Joins

SELECT ROUND(
            (SUM(IF(order_date = customer_pref_delivery_date, 1, 0))/COUNT(delivery_id)) * 100, 
            2) AS immediate_percentage
FROM Delivery
JOIN (
    SELECT customer_id, MIN(order_date) AS fo_date
    FROM Delivery
    GROUP BY customer_id) AS tbl
USING (customer_id)
WHERE order_date = fo_date