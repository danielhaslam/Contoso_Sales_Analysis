WITH median_values AS
(
  SELECT
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY (CASE
                                                 WHEN ptd.orderdate::DATE BETWEEN '2021-01-01' AND '2021-12-31' THEN ptd.transaction_revenue END)) AS median_2021,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY (CASE
                                                 WHEN ptd.orderdate::DATE BETWEEN '2022-01-01' AND '2022-12-31' THEN ptd.transaction_revenue END)) AS median_2022,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY (CASE
                                                 WHEN ptd.orderdate::DATE BETWEEN '2023-01-01' AND '2023-12-31' THEN ptd.transaction_revenue END)) AS median_2023
  FROM
    product_transaction_data ptd
)

SELECT
  ptd.categoryname AS category,

  SUM(CASE
      WHEN (ptd.orderdate::DATE BETWEEN '2021-01-01' AND '2021-12-31')
      	  AND ptd.transaction_revenue > mv.median_2021
      THEN ptd.transaction_revenue
  END) AS upper_rev_2021,

  SUM(CASE
      WHEN (ptd.orderdate::DATE BETWEEN '2021-01-01' AND '2021-12-31')
          AND ptd.transaction_revenue <= mv.median_2021
      THEN ptd.transaction_revenue
  END) AS lower_rev_2021,

  SUM(CASE
      WHEN (ptd.orderdate::DATE BETWEEN '2022-01-01' AND '2022-12-31')
          AND ptd.transaction_revenue > mv.median_2022
      THEN ptd.transaction_revenue
  END) AS upper_rev_2022,

  SUM(CASE
      WHEN (ptd.orderdate::DATE BETWEEN '2022-01-01' AND '2022-12-31')
          AND ptd.transaction_revenue <= mv.median_2022
      THEN ptd.transaction_revenue
  END) AS lower_rev_2022,

  SUM(CASE
      WHEN (ptd.orderdate::DATE BETWEEN '2023-01-01' AND '2023-12-31')
          AND ptd.transaction_revenue > mv.median_2023
      THEN ptd.transaction_revenue
  END) AS upper_rev_2023,

  SUM(CASE
      WHEN (ptd.orderdate::DATE BETWEEN '2023-01-01' AND '2023-12-31')
          AND ptd.transaction_revenue < mv.median_2023
      THEN ptd.transaction_revenue
  END) AS lower_rev_2023

FROM
  product_transaction_data ptd, 
  median_values mv
GROUP BY
  ptd.categoryname