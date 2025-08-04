--- Creates view combining transaction-level sales data with product details ---
--- and a seasonality adjustment factor for revenue analysis. ---


CREATE VIEW public.product_transaction_data
AS SELECT s.orderkey,
    s.orderdate,
    s.customerkey,
    s.productkey,
    s.netprice * s.quantity::double precision * s.exchangerate AS transaction_revenue,
    p.productname,
    p.categoryname,
    p.manufacturer,
    p.brand,
    s.storekey,
    st.countryname AS country,
        CASE
            WHEN EXTRACT(month FROM s.orderdate) = ANY (ARRAY[11::numeric, 12::numeric, 1::numeric]) THEN 1.2
            ELSE 1.0
        END AS seasonality_factor
   FROM sales s
     LEFT JOIN product p ON s.productkey = p.productkey
     LEFT JOIN store st ON s.storekey = st.storekey;