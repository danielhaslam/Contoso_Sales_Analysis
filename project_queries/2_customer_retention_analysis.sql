WITH customer_status AS (
WITH customer_order_counter AS (
SELECT
	customerkey,
	full_name,
	orderdate AS prev_purchase_date,
	
	ROW_NUMBER() OVER (
		PARTITION BY customerkey
		ORDER BY orderdate DESC
	) AS order_count,
	
	first_purchase_date
FROM
	order_customer_data
)

SELECT
	customerkey,
	full_name,
	prev_purchase_date,
	CASE
		WHEN prev_purchase_date < (SELECT MAX(orderdate) FROM sales)  - INTERVAL '6 months' THEN 'Churned' 
		ELSE 'Active'
	END AS status
FROM
	customer_order_counter 
WHERE
	order_count = 1 AND
	first_purchase_date < (SELECT MAX(orderdate) FROM sales)  - INTERVAL '6 months'
ORDER BY first_purchase_date DESC
)

SELECT
	status,
	COUNT(*) AS num_customers,
	SUM(COUNT(*)) OVER () AS total_customers, 
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM
	customer_status
GROUP BY
	status