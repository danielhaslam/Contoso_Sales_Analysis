--- Creates view combining key data on sales records and insightful demographic ---
--- data, alongside extracted data such as their date of first purchase. ---

CREATE VIEW public.order_customer_data
AS WITH customer_rev AS (
         SELECT 
            s.customerkey,
            s.orderdate,
            MAX(c.givenname),
            MAX(c.surname),
            MAX(c.age),
            MAX(c.countryfull),
            MAX(c.continent),
            sum(s.quantity::double precision * s.netprice * s.exchangerate) AS total_net_revenue,
            count(s.orderkey) AS num_orders
           FROM sales s
             INNER JOIN customer c ON s.customerkey = c.customerkey
          GROUP BY s.customerkey, s.orderdate
        )
 SELECT
   customerkey,
 	orderdate,
 	total_net_revenue,
    CONCAT(TRIM(givenname), ' ', TRIM(surname)) AS full_name,
    age,
    countryfull,
    continent,
    num_orders,
    min(orderdate) OVER (PARTITION BY customerkey) AS first_purchase_date
   FROM customer_rev cr;