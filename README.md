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

Here, the general distribution of LTVs were considered. Firstly, it was desired to see how customers contributed to the company revenue as a function of their status as a low spender and a high spender. Lower (LQ) and upper (UQ) quartile LTV values came at $2,693 and $10,946 respectively, and customers were segmented according to these values: 
- Low: LTV less than the LQ. 
- Medium: LTV greater than the LQ, less than the UQ. 
- High: LTV greater than the UQ.

The contribution of each segment to company revenue is visualised in the following piechart.

![](result_plots/1_ltv_piechart.png)

Providing an analysis of both net company revenue, it is shown that high spenders contribute to the majority (65.2% at $135.4m) of historical company revenue. While this is expected, an eye-opening observation follows that Low spenders only provide 2.1% of revenue ($4.34m). 

### 2. How does the company perform at customer retention rates?

### 3. Which products contribute most to these customer retention and revenue figures? 



##

##





