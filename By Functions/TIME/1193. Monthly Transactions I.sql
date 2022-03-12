# method 1
    
SELECT 
        DATE_FORMAT(trans_date, "%Y-%m") AS month,
        country,
        COUNT(*) AS trans_count,
        SUM(state = "approved") AS approved_count,
        SUM(amount) AS trans_total_amount,
        SUM(IF(state = "approved", amount, 0)) AS approved_total_amount
FROM Transactions
GROUP BY DATE_FORMAT(trans_date, "%Y-%m"), country


# method 2
SELECT 
    DISTINCT month, country,
    COUNT(id) OVER (PARTITION BY month, country) AS trans_count,
    SUM(CASE WHEN state = "approved" THEN 1 ELSE 0 END) OVER (PARTITION BY month, country) AS approved_count, # or use IF
    SUM(amount) OVER (PARTITION BY month, country) AS trans_total_amount,
    SUM(CASE WHEN state = "approved" THEN amount ELSE 0 END) OVER (PARTITION BY month, country) AS approved_total_amount
FROM (
    SELECT *, DATE_FORMAT(trans_date,'%Y-%m') AS month
    FROM Transactions) AS tbl