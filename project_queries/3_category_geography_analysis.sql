WITH country_sales AS (
    SELECT
        categoryname,
        COALESCE(SUM(CASE WHEN country = 'Online' THEN revenue_2022 END), 0) AS online_2022,
        COALESCE(SUM(CASE WHEN country = 'Online' THEN revenue_2023 END), 0) AS online_2023,

        COALESCE(SUM(CASE WHEN country = 'United States' THEN revenue_2022 END), 0) AS usa_2022,
        COALESCE(SUM(CASE WHEN country = 'United States' THEN revenue_2023 END), 0) AS usa_2023,
        
        COALESCE(SUM(CASE WHEN country = 'Canada' THEN revenue_2022 END), 0) AS canada_2022,
        COALESCE(SUM(CASE WHEN country = 'Canada' THEN revenue_2023 END), 0) AS canada_2023
    FROM (
        SELECT
            categoryname,
            country,
            SUM(CASE WHEN orderdate::DATE BETWEEN '2022-01-01' AND '2022-12-31' THEN transaction_revenue ELSE 0 END) AS revenue_2022,
            SUM(CASE WHEN orderdate::DATE BETWEEN '2023-01-01' AND '2023-12-31' THEN transaction_revenue ELSE 0 END) AS revenue_2023
        FROM product_transaction_data
        WHERE country IN ('Online', 'United States', 'Canada')
        GROUP BY categoryname, country
    )
    GROUP BY categoryname
)

SELECT
    categoryname,

    online_2022,
    online_2023,
    ROUND(((online_2023 - online_2022) / (online_2022 * 100))::NUMERIC, 2) AS pct_change_online,

    usa_2022,
    usa_2023,
    ROUND(((usa_2023 - usa_2022) / usa_2022, 0 * 100)::NUMERIC, 2) AS pct_change_usa,

    canada_2022,
    canada_2023,
    ROUND(((canada_2023 - canada_2022) / canada_2022 * 100)::NUMERIC, 2) AS pct_change_canada
FROM country_sales
ORDER BY categoryname;