# AdventureWorks Sales and Customer Performance Analysis

## Project Overview

This project analyses the Microsoft AdventureWorks2025 sample database to evaluate sales performance, customer behaviour, product demand, territory performance, salesperson contribution and order fulfilment.

The project follows a complete business analysis process:

- reviewing the database structure
- validating data quality
- defining business KPIs
- writing SQL queries
- interpreting the results
- developing business recommendations
- preparing the analysis for Power BI reporting

AdventureWorks is a fictional Microsoft sample business. This project was completed for learning and portfolio purposes.

---

## Project Objectives

The main objectives were to:

- measure overall sales performance
- analyse monthly and annual revenue trends
- identify leading products and product categories
- evaluate customer value and purchasing behaviour
- assess territory and salesperson performance
- identify inactive and never-purchased customers
- examine order value concentration
- assess basic order fulfilment performance
- translate SQL results into practical business recommendations

---

## Dataset

The analysis uses the Microsoft AdventureWorks2025 OLTP sample database.

### Data coverage

- Earliest order date: 30 May 2022
- Latest order date: 29 June 2025
- Total sales orders: 31,465
- Total sales order lines: 121,317
- Total units sold: 274,914

The 2022 and 2025 results represent partial calendar years and should not be directly compared with complete years.

---

## Tools Used

- SQL Server
- SQL Server Management Studio
- Power BI
- GitHub
- Markdown

---

## Data Quality Checks

Before calculating KPIs, the data was checked for:

- duplicate sales order identifiers
- invalid or negative order quantities
- negative revenue values
- invalid discounts
- missing important fields
- unmatched order detail records
- unmatched products
- unmatched customers
- invalid shipping and due-date sequences
- dataset coverage and record counts

No major data-quality problems were identified in the tested areas.

Detailed results are available in:

[View data-quality summary](./Findings/data_quality_summary.md)

---

## Analysis Performed

The SQL analysis is organised into six files.

### 1. Data Quality Checks

Validates the reliability and completeness of the main sales data.

[View SQL file](./SQL/01_data_quality_checks.sql)

### 2. Overall Sales Analysis

Includes:

- total revenue
- total orders
- total units sold
- average order value
- monthly sales performance
- month-over-month revenue change
- annual performance
- order-value segmentation

[View SQL file](./SQL/02_overall_sales_analysis.sql)

### 3. Product Analysis

Includes:

- top products by revenue
- product units sold
- subcategory performance
- category performance
- category revenue contribution
- products with no recorded sales

[View SQL file](./SQL/03_product_analysis.sql)

### 4. Customer Analysis

Includes:

- top customers by revenue
- customer order frequency
- customer value segmentation
- inactive customers
- never-purchased customers
- top 10 customer revenue concentration

[View SQL file](./SQL/04_customer_analysis.sql)

### 5. Territory and Salesperson Analysis

Includes:

- revenue by territory
- orders by territory
- average order value by territory
- salesperson revenue
- salesperson order volume
- salesperson average order value

[View SQL file](./SQL/05_territory_salesperson_analysis.sql)

### 6. Operational Analysis

Includes:

- average shipping time by territory
- monthly fulfilment trend
- validation of late shipments

The operational analysis identified limited variation because the sample data records a highly standardised seven-day shipping pattern.

[View SQL file](./SQL/06_operational_analysis.sql)

---

## Core KPIs

| KPI | Result |
|---|---:|
| Total Revenue | 109,846,381.40 |
| Total Orders | 31,465 |
| Total Units Sold | 274,914 |
| Average Order Value | 3,491.07 |

---

## Key Business Findings

### Revenue growth

Revenue increased from 31.60 million in 2023 to 43.67 million in 2024, representing growth of approximately 38.18%.

The increase was mainly driven by higher order volume and units sold, while average order value decreased.

### Product concentration

The Bikes category generated 86.17% of total company revenue.

Road Bikes and Mountain Bikes were the strongest product subcategories, while Mountain-200 variants dominated the highest-revenue product positions.

### Customer concentration

Only 244 high-value customers generated 65.09% of total revenue.

However, the top 10 customers generated only 7.21% of total revenue. This indicates that revenue was concentrated across the wider high-value customer group rather than being dependent on only a few individual accounts.

### Order-value concentration

Medium-value orders represented approximately 11.4% of all orders but generated 48.04% of revenue.

High-value orders represented approximately 1.3% of all orders but generated 28.88% of revenue.

### Territory performance

Southwest generated the highest territory revenue.

Australia had high order volume but a relatively low average order value, while Central and Southeast had lower order volumes but much higher average order values.

### Salesperson performance

Linda Mitchell generated the highest salesperson revenue.

Jillian Carson processed more orders, while some salespeople achieved high average order values from fewer transactions.

### Operational performance

All analysed territories had an average shipping time of seven days.

No completed orders were found where the shipment date was later than the due date.

Detailed findings are available in:

[View key business findings](./Findings/key_business_findings.md)

---

## Business Recommendations

The main recommendations are to:

1. Protect the wider high-value customer portfolio.
2. Monitor medium and high-value orders separately.
3. Maintain availability of leading bike products.
4. Develop selected low-value customers.
5. Diversify revenue through related product categories.
6. Apply territory-specific commercial strategies.
7. Assess salespeople using balanced performance measures.
8. Investigate monthly volatility and the shift toward higher order volume.
9. Separate never-purchased customers from lapsed customers.
10. Continue monitoring fulfilment consistency.

Detailed recommendations are available in:

[View business recommendations](./Findings/recommendations.md)

---

## Power BI Dashboard

**Status:** In development

The dashboard will contain three pages.

### Executive Overview

- Total revenue
- Total orders
- Total units sold
- Average order value
- Monthly revenue trend
- Annual sales performance
- Month-over-month change
- Revenue by territory
- Order-value segment contribution

### Product Performance

- Revenue by category
- Revenue by subcategory
- Top products by revenue
- Units sold
- Products with no recorded sales

### Customer and Sales Performance

- Customer segment contribution
- Top customers
- Top 10 customer revenue contribution
- Customer order frequency
- Territory performance
- Salesperson performance
- Inactive customers

Dashboard screenshots will be added after the Power BI report is complete.

---

## Repository Structure

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
└── Images/
