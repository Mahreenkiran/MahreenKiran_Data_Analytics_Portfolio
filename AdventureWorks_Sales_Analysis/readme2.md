# SQL Analysis

The SQL analysis is organised into six files covering data quality, overall sales, products, customers, territories, salespeople and operational performance.

---

## 1. Data Quality Checks

Includes validation for:

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

Includes:

- total revenue
- total orders
- total units sold
- average order value
- monthly sales performance
- month-over-month revenue change
- annual performance
- order-value segmentation

[View SQL File](./SQL/02_overall_sales_analysis.sql)

[View Supporting Power BI Analysis](./POWERBI/AdventureWorks2025%2002-Analytical%20Outputs.pbix)

[View Interactive Power BI Dashboard](./POWERBI/AdventureWorks2025%2001-Dashboards.pbix)

---

## 3. Product Analysis

Includes:

- top products by revenue
- product units sold
- subcategory performance
- category performance
- category revenue contribution
- products with no recorded sales

[View SQL File](./SQL/03_product_analysis.sql)

[View Supporting Power BI Analysis](./POWERBI/AdventureWorks2025%2002-Analytical%20Outputs.pbix)

[View Interactive Power BI Dashboard](./POWERBI/AdventureWorks2025%2001-Dashboards.pbix)

---

## 4. Customer Analysis

Includes:

- top customers by revenue
- customer purchase frequency
- customer value segmentation
- customers with no purchase history
- inactive customer analysis
- top 10 customer revenue contribution

[View SQL File](./SQL/04_customer_analysis.sql)

[View Supporting Power BI Analysis](./POWERBI/AdventureWorks2025%2002-Analytical%20Outputs.pbix)

[View Interactive Power BI Dashboard](./POWERBI/AdventureWorks2025%2001-Dashboards.pbix)

---

## 5. Territory and Salesperson Analysis

Includes:

- revenue by territory
- orders by territory
- average order value by territory
- salesperson revenue
- salesperson order volume
- salesperson average order value

[View SQL File](./SQL/05_territory_salesperson_analysis.sql)

[View Interactive Power BI Dashboard](./POWERBI/AdventureWorks2025%2001-Dashboards.pbix)

---

## 6. Operational Analysis

Includes:

- average shipping time by territory
- fulfilment performance
- validation of late shipments

The operational analysis identified limited variation because the sample data records a highly standardised seven-day shipping pattern.

[View SQL File](./SQL/06_operational_analysis.sql)

---

# Power BI Analysis and Dashboard

The Power BI stage translates the SQL analysis into interactive reporting and supporting analytical outputs.

Two Power BI files were developed for the project.

---

## Power BI Files

### 1. Interactive Dashboard

[Download AdventureWorks2025 01-Dashboards.pbix](./POWERBI/AdventureWorks2025%2001-Dashboards.pbix)

This file contains the main interactive report pages:

- Executive Dashboard
- Customer Detail
- Product Detail
- Geographic Analysis
- Category Tooltip

---

### 2. Supporting Analytical Outputs

[Download AdventureWorks2025 02-Analytical Outputs.pbix](./POWERBI/AdventureWorks2025%2002-Analytical%20Outputs.pbix)

This file contains supporting analytical tables and validation outputs, including:

- overall sales KPIs
- product revenue validation
- estimated product cost
- estimated gross profit
- estimated gross margin
- customer segment revenue
- customer segment revenue contribution
- order-value segment contribution
- customer revenue by customer
- top 10 customer revenue contribution
- category revenue contribution
- revenue excluding Bikes
- top products by revenue

---

# Power BI Dashboard Preview

The screenshots below provide a direct preview of the interactive report without requiring the `.pbix` file to be downloaded.

---

## Executive Dashboard

The Executive Dashboard provides a high-level view of overall business performance.

It includes:

- total revenue
- estimated gross profit
- total orders
- average order value
- revenue trend by year, quarter and month
- month-over-month performance
- units sold by product category
- top product category by units sold
- top five stores by revenue

![Executive Dashboard](./Images/01_executive_dashboard.png)

[Download Interactive Dashboard](./POWERBI/AdventureWorks2025%2001-Dashboards.pbix)

---

## Customer Detail

The Customer Detail page focuses on customer value and purchasing behaviour.

It includes:

- purchasing customer count
- total orders
- total revenue
- average revenue per customer
- purchasing customer trend
- top 10 customers
- customer revenue contribution
- units purchased
- average order value
- year-based filtering
- overall top-customer performance

Business customers are displayed using their **store name**, while individual customers are displayed using their **person name**.

The Top 10 customer group contributes **7.21% of total company revenue**.

![Customer Detail](./Images/02_customer_detail.png)

[Download Interactive Dashboard](./POWERBI/AdventureWorks2025%2001-Dashboards.pbix)

---

## Product Detail

The Product Detail page provides product-level performance analysis using an interactive product slicer.

It includes:

- **Order Gap vs 10% Growth Target**
- **Revenue Gap vs 10% Growth Target**
- **Estimated Profit Gap vs 10% Growth Target**
- units sold trend
- total orders trend
- year, quarter and month drill-down

The target measures are based on previous-month performance with a **10% growth target** applied.

![Product Detail](./Images/03_product_detail.png)

[Download Interactive Dashboard](./POWERBI/AdventureWorks2025%2001-Dashboards.pbix)

---

## Geographic Analysis

The geographic analysis page displays order activity across:

- Europe
- North America
- Pacific

The map compares order activity across countries including:

- United States
- Canada
- United Kingdom
- France
- Germany
- Australia

![Geographic Analysis](./Images/04_geographic_analysis.png)

[Download Interactive Dashboard](./POWERBI/AdventureWorks2025%2001-Dashboards.pbix)

---

# Supporting Power BI Analysis

The supporting Power BI file was developed to present and validate analytical outputs that are not all shown on the main dashboard.

Examples include:

- top 10 products by revenue
- product revenue validation against `LineTotal`
- estimated product cost based on `StandardCost`
- estimated gross profit
- estimated gross margin
- customer segment revenue
- customer segment revenue contribution
- order-value segment contribution
- customer revenue by customer
- top 10 customer revenue contribution
- category revenue contribution
- revenue excluding the Bikes category

[Download Supporting Analytical Outputs](./POWERBI/AdventureWorks2025%2002-Analytical%20Outputs.pbix)

---

# Power BI Skills Demonstrated

This project demonstrates practical Power BI experience in:

- relational data modelling
- Power Query
- DAX measures
- calculated columns
- filter context
- `CALCULATE`
- `DIVIDE`
- `DATEADD`
- `SWITCH`
- `LOOKUPVALUE`
- Top N filtering
- time intelligence
- KPI development
- month-over-month analysis
- slicers
- drill-down hierarchies
- visual interactions
- report page tooltips
- target-based gauge visuals
- geographic analysis
- interactive dashboard design

---

# Power BI Calculation Limitation

## Estimated Gross Profit

Estimated gross profit is calculated using the product **StandardCost** available in the Product table.

The calculation does not apply historical values from `ProductCostHistory` to each transaction based on its original order date.

As a result, gross profit and gross margin should be interpreted as **estimated analytical measures rather than exact historical accounting profit**.

---

# Power BI Project Files

[Download AdventureWorks2025 01-Dashboards.pbix](./POWERBI/AdventureWorks2025%2001-Dashboards.pbix)

[Download AdventureWorks2025 02-Analytical Outputs.pbix](./POWERBI/AdventureWorks2025%2002-Analytical%20Outputs.pbix)

---

# Dashboard Images

[View Executive Dashboard](./Images/01_executive_dashboard.png)

[View Customer Detail](./Images/02_customer_detail.png)

[View Product Detail](./Images/03_product_detail.png)

[View Geographic Analysis](./Images/04_geographic_analysis.png)
