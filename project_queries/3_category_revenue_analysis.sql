WITH median_values AS (
  SELECT
    ptd.categoryname,
    EXTRACT(YEAR FROM ptd.orderdate) AS order_year,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ptd.transaction_revenue) AS median_rev
  FROM product_transaction_data ptd
  WHERE ptd.orderdate::DATE BETWEEN '2021-01-01' AND '2023-12-31'
  GROUP BY ptd.categoryname, EXTRACT(YEAR FROM ptd.orderdate)
)

SELECT
  ptd.categoryname AS category,
  
  SUM(CASE
      WHEN EXTRACT(YEAR FROM ptd.orderdate) = 2021
           AND ptd.transaction_revenue > mv.median_rev
      THEN ptd.transaction_revenue
  END) AS upper_rev_2021,

  SUM(CASE
      WHEN EXTRACT(YEAR FROM ptd.orderdate) = 2021
           AND ptd.transaction_revenue <= mv.median_rev
      THEN ptd.transaction_revenue
  END) AS lower_rev_2021,

  SUM(CASE
      WHEN EXTRACT(YEAR FROM ptd.orderdate) = 2022
           AND ptd.transaction_revenue > mv.median_rev
      THEN ptd.transaction_revenue
  END) AS upper_rev_2022,

  SUM(CASE
      WHEN EXTRACT(YEAR FROM ptd.orderdate) = 2022
           AND ptd.transaction_revenue <= mv.median_rev
      THEN ptd.transaction_revenue
  END) AS lower_rev_2022,

  SUM(CASE
      WHEN EXTRACT(YEAR FROM ptd.orderdate) = 2023
           AND ptd.transaction_revenue > mv.median_rev
      THEN ptd.transaction_revenue
  END) AS upper_rev_2023,

  SUM(CASE
      WHEN EXTRACT(YEAR FROM ptd.orderdate) = 2023
           AND ptd.transaction_revenue <= mv.median_rev
      THEN ptd.transaction_revenue
  END) AS lower_rev_2023

FROM product_transaction_data ptd
INNER JOIN median_values mv
  ON mv.categoryname = ptd.categoryname AND mv.order_year = EXTRACT(YEAR FROM ptd.orderdate)
GROUP BY ptd.categoryname
ORDER BY ptd.categoryname;