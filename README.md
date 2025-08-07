# Contoso Sales Analysis

This project harnesses the Contoso sales relational database, which integrates detailed sales transaction records with rich datasets on customer demographics and product specifications. SQL queries are written to uncover temporal trends in sales, generating actionable insights on business performance for stakeholders. 

## Background

The project is made possible thanks to **Microsoft's Contoso** datasets, which provide ficticious demonstrations of real-world datasets for training purposes. 

A further thanks to **Luke Barousse**'s Intermediate SQL Course for Data Analytics, equipping me with the skillset necessary to tackle these datasets effectively. 

## Project Goals

By querying the relational database on sale, customer and product records, this project sought answers to considered questions which aimed to generate useful recommendations for the selling company. In particular, three key questions were considered: 

1. How does customer Lifetime Value (LTV) vary across the dataset?

2. How does the company perform at customer retention rates?

3. Which products contribute most to these customer retention and revenue figures? 

## Software Used

The following resources were employed to effectively manage these databases to build these queries: 

- **PostgreSQL** was used as the relational database management system, to store and manage the data.

- **pgAdmin 4** was used as the UI by which the PostgreSQL database was interacted with.

- **DBeaver 25** was the UI with which SQL scripts were written, and tables and views were generated.

- **Visual Studio Code** was used to manage the Git repository.
 
## Findings & Discussion

### 1. How does customer Lifetime Value (LTV) vary across the dataset?

For this and the next question, customer-associated trends are the main focus. For this purpose, the view `sales_customer_data` was produced to extract relevant customer details. The associated SQL query offers further detail on this view, and can be found [here](https://github.com/danielhaslam/Contoso_Sales_Analysis/blob/main/project_views/1_sales_customer_data.sql). 

Here, the general distribution of LTVs were considered. Firstly, it was desired to see how customers contributed to the company revenue as a function of their status as a low spender and a high spender. Lower (LQ) and upper (UQ) quartile LTV values came at $2,693 and $10,946 respectively, and customers were segmented according to these values: 
- Low: LTV less than the LQ. 
- Medium: LTV greater than the LQ, less than the UQ. 
- High: LTV greater than the UQ.

The contribution of each segment to company revenue is visualised in the following piechart.

![](result_plots/1_ltv_piechart.png)

An analysis of net company revenue reveals that high spenders account for the majority of historical revenue - 65.2% ($135.4M). While this aligns with expectations, a more surprising insight is that low spenders contribute just 2.1% ($4.34M). This suggests a significant underperformance in engaging lower-spending customers and may indicate an opportunity for more targeted marketing strategies aimed at this segment.

Seeing as the company spans sales from three continents (North America, Australia and Europe), I delved into this tendency by continent. The following figure shows a breakdown of the above piechart figures, this time by each continent.

![](result_plots/1_ltv_continent_barplot.png)

Low-spending customers show consistently low engagement across all three continents, suggesting that this trend is not driven by location-specific factors. However, Europe performs marginally better in this segment, with 3.1% of sales attributed to low spenders, compared to just 1.7% in both Australia and North America. Notably, Europe also demonstrates stronger engagement among median spenders, who contribute over 40% of the region’s revenue—significantly higher than the under 30% seen in Australia and North America.

Overall, it is recommendable to evaluate the fundamental business model, particularly in relation to customer segmentation and value proposition. Introducing tailored membership perks or loyalty incentives for low-spending customers could help improve retention and increase lifetime value within this underperforming segment. Pricing structures and marketing messaging may also be key features in this endeavour.

### 2. How does the company perform at customer retention rates?

For a study on customer retention, churn rates (i.e. the proportion of customers which haven't made a purchase for an extended period of time) are calculated and analysed. Specifically, since Contoso is an e-commerce business, this period of time is set at 6 months for purposes of this study.

Firstly, historical churn rates are analysed. The pie chart below depicts this.

![](result_plots/2_customer_retention_piechart.png)

A churned rate of over 90% suggests that customer retention in general is poor: in the e-commerce industry, average customer churn rates typically fall between 60% and 80% annually. For example, repeat purchase rates for first-time buyers are often as low as 20–30%, and retaining even 30–40% of customers year-over-year is considered solid performance. Therefore, a churn rate exceeding 90% is well above industry norms and likely points to gaps in customer experience, product-market fit, or general retention strategy.

Breaking this statistic down further based on cohort year provides a further insight.

![](result_plots/2_customer_cohort_barplot.png)

Customer churn has remained consistently high across all cohorts, hovering around 90% annually, with little improvement over time. This indicates a systemic retention issue, rather than a temporary/cohort-specific problem. The slight uptick in retention from the 2019 to 2023 cohorts (around 10% active) might suggest recent efforts to improve customer engagement, but the change is marginal.

Overall, the consistently high churn suggests an over-reliance on acquisition over retention—an unsustainable strategy in e-commerce. Modest improvements in customer retention through targeted strategies could yield massive improvements in long-term revenue.

### 3. Which products contribute most to these customer retention and revenue figures?

Now that some key insights into customer trends have been explored, we can perform similar analysis on how value is generated on a product-by-product basis. The queries here attempt to reveal what should be sold, rather than who should be sold to and how. As such, a view named `product_transaction_data` has been created to highlight sales by product - the SQL can be found [here](https://github.com/danielhaslam/Contoso_Sales_Analysis/blob/main/project_views/2_product_transation_data.sql).

Specifically, product categories are the main focus in this question. Querying distinct categories reveals that Contoso sells eight types of product: *Audio*; *Cameras and Camcorders*; *Cell phones*; *Computers*; *Games and Toys*; *Home Appliances*; *Music, Movies and Audio Books*; and *TV and Video*.

First of all, it is of interest to see which category of item contributes to the net revenue, and how this has changed in recent years. Furthermore, I wanted to see how this has developed in recent years, in case particular product categories see different performance changes. Finally, to get an idea of how each sale contributes to total revenue, sub-median and super-median sale contributions are evaluated separately.

Extracting all this data to visualise, the following table was produced, showing year-on-year revenue contributions by product category.

![](result_plots/3_category_revenue_barplot.png)
*Note: each bar is additive: the revenues from sub-median sales, in lighter colours, add onto the those from super-median sales, in darker colours. Sub-median sale revenues are typically much smaller than super-median sale revenues.*

##

##





