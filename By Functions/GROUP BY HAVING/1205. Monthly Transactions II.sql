# UNION transaction table and chargeback table is the key in this question
# UNION ALL keeps all of the records from each of the original data sets, UNION removes any duplicate records.
# both UNION ALL and UNION work for this question cause duplicated rows will never occur
# UNION ALL should be preferred cause it's faster

SELECT month, country,
    SUM(IF(state = "approved", 1, 0)) AS approved_count,
    SUM(IF(state="approved", amount, 0)) AS approved_amount,
    SUM(IF(state = 'chargeback', 1, 0)) AS chargeback_count,
    SUM(IF(state="chargeback", amount, 0)) AS chargeback_amount
FROM (
		SELECT id, 
	         country, 
	         state, 
	         amount, 
	         DATE_FORMAT(trans_date, "%Y-%m") AS month
		FROM Transactions
		UNION ALL
		(SELECT c.trans_id AS id, 
		         country, 
		         "chargeback" AS state,
		         amount, 
		         DATE_FORMAT(c.trans_date, "%Y-%m") AS month
		FROM Transactions t
		RIGHT JOIN Chargebacks c
		ON t.id = c.trans_id)
	) AS tbl
GROUP BY month, country
HAVING approved_amount > 0 or chargeback_amount > 0

