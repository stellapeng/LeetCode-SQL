SELECT s.product_id, ROUND(SUM(units*price)/SUM(units), 2) AS average_price
FROM UnitsSold s
JOIN Prices p
ON s.product_id = p.product_id 
AND s.purchase_date >= p.start_date 
AND s.purchase_date <= p.end_date
GROUP BY s.product_id



SELECT s.product_id, ROUND(SUM(units*price)/SUM(units), 2) AS average_price
FROM UnitsSold s
JOIN Prices p
ON s.product_id = p.product_id 
WHERE s.purchase_date >= p.start_date 
AND s.purchase_date <= p.end_date
GROUP BY s.product_id