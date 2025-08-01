WITH customer_ltv_rankings AS (
WITH customer_ltv_data AS (
	SELECT
		o.customerkey,
		o.full_name,
		o.continent,
		SUM(o.total_net_revenue) AS lifetime_value
	FROM
		order_customer_data o
	GROUP BY
		customerkey,
		full_name,
		continent
),

ltv_quartiles AS (
	SELECT
		PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY lifetime_value) AS LQ_lifetime_value,
		PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY lifetime_value) AS UQ_lifetime_value
	FROM customer_ltv_data 
)

SELECT 
	c.*,
	CASE 
		WHEN c.lifetime_value < l.LQ_lifetime_value THEN 'Low'
		WHEN c.lifetime_value < l.UQ_lifetime_value THEN 'Mid'
		ELSE 'High'
	END AS lifetime_value_rank
FROM customer_ltv_data c, ltv_quartiles l
)

SELECT 
	lifetime_value_rank, 
	SUM(lifetime_value) AS total_lifetime_value, 
	SUM(lifetime_value) / COUNT(DISTINCT customerkey) AS avg_lifetime_value
FROM	
	customer_ltv_rankings
GROUP BY
	lifetime_value_rank;