/* Using this dataset (https://www.db-fiddle.com/f/fufVxMKne1xMNHCbFoANMo/0), show the SQL query to find the rolling 3 day average transaction amount for each day in January 2021. */

WITH transactions_by_day
AS (
	SELECT CAST(transaction_time AS DATE) AS DATE
		,SUM(transaction_amount) AS total_transaction_amount
	FROM transactions
	GROUP BY CAST(transaction_time AS DATE)
	ORDER BY CAST(transaction_time AS DATE)
	)
SELECT DATE
	,AVG(total_transaction_amount) OVER (
		ORDER BY DATE ROWS BETWEEN 2 PRECEDING
				AND CURRENT ROW
		) AS moving_average
FROM transactions_by_day
WHERE DATE = '2021-01-31';
