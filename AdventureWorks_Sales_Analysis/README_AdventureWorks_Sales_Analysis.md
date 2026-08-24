# AdventureWorks Sales and Customer Performance Analysis

## Project Overview

This project analyses the Microsoft **AdventureWorks2025 OLTP sample database** to evaluate sales performance, customer behaviour, product demand, territory performance, salesperson contribution and order fulfilment.

The project follows a complete business analysis process:

- reviewing the database structure
- validating data quality
- defining business KPIs
- writing SQL queries
- interpreting business results
- developing business recommendations
- building an interactive Power BI report
- validating Power BI outputs against SQL results

AdventureWorks is a fictional Microsoft sample business. This project was completed for learning and portfolio purposes.

---

## Project Objectives

The main objectives were to:

- measure overall sales performance
- analyse monthly and annual revenue trends
- identify leading products and product categories
- evaluate customer value and purchasing behaviour
- assess territory and salesperson performance
- identify customers with no purchase history
- examine customer and order-value revenue concentration
- assess basic order fulfilment performance
- translate analytical results into practical business recommendations
- present the findings through interactive Power BI reporting

---

## Dataset

The analysis uses the Microsoft **AdventureWorks2025 OLTP sample database**.

### Data Coverage

- **Earliest order date:** 30 May 2022
- **Latest order date:** 29 June 2025
- **Complete sales orders:** 31,465
- **Sales order lines:** 121,317
- **Units sold:** 274,914
- **Customer records:** 19,820
- **Purchasing customers:** 19,119
- **Customer records with no linked purchase history:** 701

The 2022 and 2025 results represent partial calendar years and should not be directly compared with complete years.

---

## Tools Used

- **SQL Server 2025 Express**
- **SQL Server Management Studio**
- **SQL**
- **Power BI Desktop**
- **DAX**
- **Power Query**
- **GitHub**
- **Markdown**

---

# Data Quality Validation

Before calculating KPIs and completing the business analysis, SQL data quality checks were performed across the main sales tables.

The data was checked for:

- duplicate sales order identifiers
- invalid or negative order quantities
- negative sales values
- invalid discounts
- missing important analytical fields
- unmatched sales order detail records
- unmatched products
- unmatched customers
- invalid shipping and due-date sequences
- dataset coverage
- record counts

No major data-quality problems were identified in the tested areas.

The data was therefore considered suitable for the planned sales and customer analysis.

### Supporting Files

[View Data Quality Summary](./Findings/data_quality_summary.md)

[View Data Quality SQL](./SQL/01_data_quality_checks.sql)

---

# Core Business KPIs

| KPI | Result |
|---|---:|
| Total Revenue | $109,846,381.40 |
| Total Orders | 31,465 |
| Units Sold | 274,914 |
| Average Order Value | $3,491.07 |
| Purchasing Customers | 19,119 |
| Customer Records | 19,820 |
| Estimated Gross Profit | $9.37M |
| Estimated Gross Margin | 8.53% |

---

# SQL Analysis

The SQL analysis is organised into six files covering data quality, overall sales, products, customers, territories, salespeople and operational performance.

---

## 1. Data Quality Checks

The data-quality analysis validates the reliability and completeness of the main sales data.

It includes checks for:

- duplicate records
- invalid quantities
- negative values
- missing data
- unmatched relationships
- invalid shipping dates
- invalid discount values

[View SQL File](./SQL/01_data_quality_checks.sql)

[View Data Quality Summary](./Findings/data_quality_summary.md)

---

## 2. Overall Sales Analysis

The overall sales analysis includes:

- total revenue
- total orders
- total units sold
- average order value
- monthly sales performance
- month-over-month revenue change
- annual performance
- order-value segmentation

[View SQL File](./SQL/02_overall_sales_analysis.sql)

---

## 3. Product Analysis

The product analysis includes:

- top products by revenue
- product units sold
- subcategory performance
- category performance
- category revenue contribution
- products with no recorded sales

[View SQL File](./SQL/03_product_analysis.sql)

---

## 4. Customer Analysis

The customer analysis includes:

- top customers by revenue
- customer purchase frequency
- customer value segmentation
- customers with no purchase history
- inactive customer analysis
- top 10 customer revenue contribution

[View SQL File](./SQL/04_customer_analysis.sql)

---

## 5. Territory and Salesperson Analysis

The territory and salesperson analysis includes:

- revenue by territory
- orders by territory
- average order value by territory
- salesperson revenue
- salesperson order volume
- salesperson average order value

[View SQL File](./SQL/05_territory_salesperson_analysis.sql)

---

## 6. Operational Analysis

The operational analysis includes:

- average shipping time by territory
- fulfilment performance
- validation of late shipments

The analysis identified limited shipping variation because the sample data records a highly standardised seven-day shipping pattern.

[View SQL File](./SQL/06_operational_analysis.sql)

---

# Key Business Findings

## Overall Sales Performance

AdventureWorks generated approximately **$109.85 million** in total revenue from **31,465 orders** and **274,914 units sold**.

The average order value was **$3,491.07**.

---

## Monthly Revenue Was Volatile

Monthly revenue showed substantial fluctuations throughout the available reporting period.

Examples included:

- **286.54% increase** in June 2022
- **16.63% decrease** in July 2022
- **20.52% decrease** in August 2022
- **113.88% increase** in September 2022
- **36.67% decrease** in November 2022
- **74.22% increase** in December 2022

The variation indicates that individual monthly results should be interpreted within the wider sales trend rather than in isolation.

---

## Annual Performance Strengthened in 2024

Among the complete calendar years available, revenue increased from:

- **$31.60M in 2023**
- to **$43.67M in 2024**

This represented growth of approximately **38.18%**.

During the same period:

- orders increased from **3,830 to 14,244**
- units sold increased from **66,441 to 131,936**
- average order value decreased from approximately **$8,252 to $3,066**

The increase in revenue was therefore driven primarily by higher transaction and unit volumes rather than larger individual orders.

---

## Medium and High-Value Orders Generated Most Revenue

| Order Segment | Orders | Revenue | Revenue Contribution |
|---|---:|---:|---:|
| High Value Order | 407 | $31,733,946.80 | 28.89% |
| Medium Value Order | 3,600 | $52,777,326.94 | 48.05% |
| Low Value Order | 27,458 | $25,335,107.65 | 23.06% |

Medium and high-value orders represented a relatively small proportion of total transactions but generated more than three-quarters of company revenue.

---

## Bikes Dominated Company Revenue

| Product Category | Revenue | Revenue Contribution |
|---|---:|---:|
| Bikes | $94,651,172.70 | 86.17% |
| Components | $11,802,593.29 | 10.74% |
| Clothing | $2,120,542.52 | 1.93% |
| Accessories | $1,272,072.88 | 1.16% |

The **Bikes** category generated **86.17% of total company revenue**, demonstrating strong dependence on the company's core bike business.

---

## Road Bikes Were the Strongest Product Subcategory

The strongest product subcategories included:

| Product Subcategory | Units Sold | Revenue |
|---|---:|---:|
| Road Bikes | 47,196 | $43,909,437.51 |
| Mountain Bikes | 28,321 | $36,445,443.94 |
| Touring Bikes | 14,751 | $14,296,291.26 |
| Mountain Frames | 11,621 | $4,713,930.23 |
| Road Frames | 11,753 | $3,851,350.60 |

Road Bikes generated the highest revenue and unit sales among the leading subcategories.

---

## Mountain-200 Products Led Individual Product Revenue

The highest-revenue product was:

**Mountain-200 Black, 38**

- **Units sold:** 2,977
- **Revenue:** $4,400,592.80

Mountain-200 Black and Silver variants occupied several of the highest positions in the individual product revenue ranking.

---

## Some Products Recorded No Sales

Several products recorded zero units sold and zero revenue during the analysis period.

These products may represent:

- internal components
- discontinued products
- obsolete items
- products not intended for direct customer sale
- products with no recorded demand during the available period

Products with no recorded sales were therefore not automatically classified as underperforming commercial products.

---

## A Small High-Value Customer Segment Generated Most Revenue

| Customer Segment | Customers | Revenue | Revenue Contribution |
|---|---:|---:|---:|
| High Value Customer | 244 | $71,509,740.18 | 65.10% |
| Medium Value Customer | 233 | $8,619,787.69 | 7.85% |
| Low Value Customer | 18,642 | $29,716,853.53 | 27.05% |
| No Purchases | 701 | $0 | 0.00% |

Only **244 high-value customers** generated approximately **65.10% of total company revenue**.

This demonstrates strong revenue concentration within the wider high-value customer segment.

---

## Highest-Revenue Customers Were Business Accounts

The highest-revenue customer was:

**Brakes and Gears**

- **Revenue:** $877,107.19
- **Orders:** 12

Other leading customers included:

- Excellent Riding Supplies
- Vigorous Exercise Company
- Totes & Baskets Company
- Retail Mall
- Corner Bicycle Supply

The highest-revenue customers were predominantly store or business accounts placing relatively few but high-value orders.

---

## Frequent Customers Did Not Necessarily Generate High Revenue

Some individual customers placed a high number of orders but generated relatively low total revenue.

Examples included:

- **Mason Roberts:** 28 orders, $1,320.01 revenue
- **Dalton Perez:** 28 orders, $1,189.33 revenue

This demonstrates that customer value should not be assessed using order frequency alone.

Revenue, order volume and average order value should be considered together.

---

## 701 Customer Records Had No Linked Purchase History

AdventureWorks contained:

- **19,820 customer records**
- **19,119 purchasing customers**
- **701 customer records with no linked purchase history**

These records were kept separate from customers who had purchased previously but later became inactive.

---

## Top 10 Customers Generated 7.21% of Revenue

The top 10 customers generated:

- **$7,922,046.38 combined revenue**
- **7.21% of total company revenue**

This indicates that although revenue is concentrated within the wider high-value customer segment, it is not dominated by only the ten largest customer accounts.

---

## Southwest Generated the Highest Territory Revenue

| Territory | Orders | Revenue | Average Order Value |
|---|---:|---:|---:|
| Southwest | 6,224 | $24,184,609.60 | $3,885.70 |
| Canada | 4,067 | $16,355,770.46 | $4,021.58 |
| Northwest | 4,594 | $16,084,942.55 | $3,501.29 |
| Australia | 6,843 | $10,655,335.96 | $1,557.11 |
| Central | 385 | $7,909,009.01 | $20,542.88 |

Territories displayed different purchasing patterns.

Australia generated high order volume with a relatively low average order value, while Central generated significant revenue from a much smaller number of high-value orders.

---

## Linda Mitchell Generated the Highest Salesperson Revenue

| Salesperson | Revenue | Orders | Average Order Value |
|---|---:|---:|---:|
| Linda Mitchell | $10,367,007.43 | 418 | $24,801.45 |
| Jillian Carson | $10,065,803.54 | 473 | $21,280.77 |
| Michael Blythe | $9,293,903.00 | 450 | $20,653.12 |
| Jae Pak | $8,503,338.65 | 348 | $24,434.88 |

Linda Mitchell generated the highest revenue without processing the highest number of orders.

This demonstrates the importance of assessing salesperson performance using multiple measures rather than revenue or transaction volume alone.

---

## Shipping Performance Was Consistent

All analysed territories recorded an average shipping time of approximately **7 days**.

No completed orders were identified where shipment occurred after the due date.

The identical average across territories may partly reflect the design of the fictional AdventureWorks sample database.

### Full Findings

[View Key Business Findings](./Findings/key_business_findings.md)

---

# Business Recommendations

The main recommendations from the analysis are to:

1. Protect the wider high-value customer portfolio.
2. Monitor medium and high-value orders separately.
3. Maintain availability of leading bike products.
4. Develop selected low-value customers.
5. Diversify revenue through complementary product categories.
6. Apply territory-specific commercial strategies.
7. Assess salespeople using balanced performance measures.
8. Investigate monthly revenue volatility.
9. Investigate the shift towards higher order volume.
10. Separate never-purchased customers from lapsed customers.
11. Continue monitoring fulfilment consistency.

### Full Recommendations

[View Business Recommendations](./Findings/recommendations.md)

---

# Power BI Dashboard

The Power BI report was developed to translate the SQL analysis into interactive executive, customer, product and geographic reporting.

The report contains:

- **Executive Dashboard**
- **Customer Detail**
- **Product Detail**
- **Geographic Analysis**
- **Category Tooltip**

[View Power BI Folder](./PowerBI/)

---

## Executive Dashboard

The Executive Dashboard provides a high-level view of business performance.

It includes:

- total revenue
- estimated gross profit
- total orders
- average order value
- revenue trend by year, quarter and month
- monthly revenue performance
- month-over-month order performance
- average order value movement
- units sold by product category
- top product category by units sold
- top five stores by revenue

---

## Customer Detail

The Customer Detail page provides a deeper view of customer behaviour and value.

It includes:

- purchasing customer count
- total orders
- total revenue
- average revenue per customer
- purchasing customer trend
- top 10 purchasing customers
- customer revenue contribution
- units purchased
- average order value
- year-based filtering
- overall top-customer performance

Business customers are displayed using their **store name**, while individual customers are displayed using their **person name**.

The Top 10 customer group contributes **7.21% of total company revenue**.

---

## Product Detail

The Product Detail page provides product-level analysis through an interactive product slicer.

It includes:

- **Order Gap vs 10% Growth Target**
- **Revenue Gap vs 10% Growth Target**
- **Estimated Profit Gap vs 10% Growth Target**
- units sold trend
- total orders trend
- year, quarter and month drill-down

The growth targets are based on the previous month's performance with a **10% growth target** applied.

---

## Geographic Analysis

The geographic page displays total orders across:

- Europe
- North America
- Pacific

The map compares order activity across:

- United States
- Canada
- United Kingdom
- France
- Germany
- Australia

---

## Power BI Supporting Analysis

A separate Power BI analysis file was also developed to validate and present supporting analytical outputs, including:

- core KPI measures
- product line revenue validation
- estimated product cost
- estimated gross profit
- estimated gross margin
- customer segment revenue
- customer segment revenue contribution
- order-value segment contribution
- customer revenue by customer
- top 10 customer contribution
- category revenue contribution
- revenue excluding Bikes
- top 10 products by revenue

---

## Report Interactivity

The Power BI report demonstrates:

- slicers
- Top N filtering
- drill-down hierarchies
- visual interactions
- report page tooltips
- KPI cards
- month-over-month analysis
- target-based gauge visuals
- geographic filtering

---

# Limitations

## Partial-Year Data

The dataset covers **30 May 2022 to 29 June 2025**.

Therefore:

- **2022 is a partial year**
- **2025 is a partial year**

Direct annual comparisons should focus primarily on complete calendar years such as **2023 and 2024**.

---

## Estimated Gross Profit

Estimated gross profit is calculated using the product **StandardCost** available in the Product table.

The calculation does not apply historical values from `ProductCostHistory` to each transaction based on the original order date.

As a result, gross profit and gross margin should be interpreted as **estimated analytical measures rather than exact historical accounting profit**.

---

## Shipping Data

Shipping duration was calculated using whole-number day differences.

Smaller variations measured in hours are therefore not visible.

The identical average shipping duration of approximately seven days across territories may also reflect the structure of the fictional AdventureWorks sample database rather than genuine operational performance.

---

## Fictional Dataset

AdventureWorks is a Microsoft sample database.

The business findings and recommendations demonstrate analytical methods and business interpretation for portfolio purposes and should not be interpreted as advice provided to a real organisation.

---

# SQL Skills Demonstrated

- aggregate functions
- window functions
- `INNER JOIN`
- `LEFT JOIN`
- multiple-table joins
- common table expressions
- subqueries
- `CASE` statements
- `LAG()`
- ranking functions
- percentage calculations
- customer segmentation
- order-value segmentation
- date functions
- `NULL` handling
- data-quality validation
- business KPI development

---

# Power BI and DAX Skills Demonstrated

- relational data modelling
- Power Query
- DAX measures
- calculated columns
- `CALCULATE`
- `DIVIDE`
- `DATEADD`
- `SWITCH`
- `LOOKUPVALUE`
- filter context
- Top N analysis
- time intelligence
- KPI development
- interactive dashboards
- drill-down hierarchies
- report page tooltips
- gauge visuals
- geographic analysis
- dashboard design

---

# Business Analysis Skills Demonstrated

- KPI definition
- sales performance analysis
- trend interpretation
- customer value analysis
- customer segmentation
- revenue concentration analysis
- product performance analysis
- territory comparison
- salesperson performance analysis
- operational analysis
- translating analytical findings into business recommendations

---

# Repository Structure

```text
AdventureWorks_Sales_Analysis/
│
├── README.md
│
├── SQL/
│   ├── 01_data_quality_checks.sql
│   ├── 02_overall_sales_analysis.sql
│   ├── 03_product_analysis.sql
│   ├── 04_customer_analysis.sql
│   ├── 05_territory_salesperson_analysis.sql
│   └── 06_operational_analysis.sql
│
├── Findings/
│   ├── data_quality_summary.md
│   ├── key_business_findings.md
│   └── recommendations.md
│
├── PowerBI/
│
└── Images/
```

---

# Project Files

### SQL

[Data Quality Checks](./SQL/01_data_quality_checks.sql)

[Overall Sales Analysis](./SQL/02_overall_sales_analysis.sql)

[Product Analysis](./SQL/03_product_analysis.sql)

[Customer Analysis](./SQL/04_customer_analysis.sql)

[Territory and Salesperson Analysis](./SQL/05_territory_salesperson_analysis.sql)

[Operational Analysis](./SQL/06_operational_analysis.sql)

### Findings

[Data Quality Summary](./Findings/data_quality_summary.md)

[Key Business Findings](./Findings/key_business_findings.md)

[Business Recommendations](./Findings/recommendations.md)

### Power BI

[View Power BI Files](./PowerBI/)

### Dashboard Images

[View Dashboard Images](./Images/)

---

# Conclusion

AdventureWorks generated approximately **$109.85 million** in revenue from **31,465 orders** during the available reporting period.

The analysis found that revenue was strongly concentrated in the **Bikes category** and the wider **high-value customer segment**.

However, the top 10 customers contributed only **7.21% of total revenue**, indicating that customer concentration was spread across the wider high-value group rather than being dependent on only a few individual accounts.

The strongest complete-year growth occurred between **2023 and 2024**, when revenue increased by approximately **38.18%**.

This growth was driven primarily by increased order and unit volumes while average order value declined, indicating a shift towards a higher-volume sales pattern.

The project demonstrates an end-to-end analytical workflow combining:

**data validation → SQL analysis → business interpretation → DAX development → Power BI reporting → business recommendations**

---

## Author

**Dr Mahreen Kiran**

**Business Data Analyst and BI Analyst**

[View Main Portfolio](../README.md)

[LinkedIn](https://linkedin.com/in/mahreen-kiran)
