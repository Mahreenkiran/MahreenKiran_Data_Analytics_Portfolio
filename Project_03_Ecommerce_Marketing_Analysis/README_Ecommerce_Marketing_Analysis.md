# E-Commerce Marketing, Conversion and Customer Journey Analysis

## Project Overview

This project analyses approximately three years of e-commerce website activity to understand how users discover the website, interact with content, progress through the purchase journey and convert into customers.

The analysis combines **SQL Server** for data validation, transformation and business analysis with **Power BI** for interactive reporting and visualisation.

The project focuses on several business questions:

- How did website traffic, orders and revenue change over time?
- Which marketing channels and campaigns generated the strongest commercial performance?
- How did desktop and mobile users differ in conversion behaviour?
- Which landing pages performed most effectively?
- Where did users drop out of the conversion funnel?
- Did repeat visitors convert more successfully than first-time visitors?
- How did basket size affect revenue and profitability?
- Which products generated the most revenue and refunds?
- How did refund activity affect realised revenue?

---

## Dataset

The analysis uses the **Maven Analytics Toy Store E-Commerce / Fuzzy Factory dataset**.

The dataset is synthetic and represents website traffic, customer sessions, orders, products and refund activity for a fictional e-commerce business.

The core dataset contains:

| Table | Rows |
|---|---:|
| `website_sessions` | 472,871 |
| `website_pageviews` | 1,188,124 |
| `orders` | 32,313 |
| `order_items` | 40,025 |
| `order_item_refunds` | 1,731 |
| `products` | 4 |

Website activity covers approximately **March 2012 to March 2015**, while refund activity extends into **April 2015** because refunds may occur after the original purchase.

---

## Tools and Technologies

- **SQL Server**
- **T-SQL**
- **Power BI**
- **DAX**
- **Power Query**
- **Excel**
- **Git & GitHub**

---

## Analytical Workflow

The project was completed in five main stages.

### 1. Relational Database Structure

Primary and foreign key relationships were established between website sessions, pageviews, orders, order items, products and refunds.

The relational structure was used as the foundation for subsequent validation and analysis.

[View Primary and Foreign Key Constraints SQL](SQL/01_primary_foreign_key_constraints.sql)

---

### 2. Data Quality Validation

The dataset was checked for:

- duplicate primary keys
- NULL primary keys
- orphan foreign-key relationships
- missing analytical fields
- invalid financial values
- order-item reconciliation issues
- order-level revenue and cost inconsistencies
- refund inconsistencies
- potential duplicate business records

No material structural, relational or financial issues were identified in the tested areas.

[View Data Quality Summary](Findings/data_quality_summary.md)

[View Data Quality Validation SQL](SQL/02_data_quality_validation.sql)

---

### 3. Date and Logical Validation

Chronological and behavioural checks were performed to ensure that:

- pageviews did not occur before session creation
- orders did not occur before sessions
- order items did not occur before orders
- refunds did not occur before purchase activity
- products were not referenced before creation
- repeat-session flags were logically consistent
- pageviews followed valid chronological sequences

No chronological or behavioural anomalies were identified.

[View Date and Logical Validation SQL](SQL/03_date_logical_validation.sql)

---

### 4. Feature Engineering

Additional analytical fields were created in SQL to support business analysis and dashboard development.

Derived fields included:

- session year, month and year-month
- order year, month and year-month
- gross profit
- gross margin percentage
- converted-session flag
- pages viewed per session
- session duration
- landing page
- exit page
- time to order
- refund flag
- total refund amount
- net revenue
- multi-item order flag
- session sequence
- repeat-user flag
- marketing channel
- order value band

[View Derived Fields SQL](SQL/04_derived_fields.sql)

---

### 5. Business Analysis

The final SQL analysis explored:

- monthly website performance
- marketing channel performance
- device performance
- campaign performance
- landing and exit behaviour
- session engagement
- time to purchase
- repeat-user behaviour
- session sequence performance
- order value bands
- multi-item orders
- refund performance
- product performance
- product revenue ranking
- month-on-month growth
- rolling performance
- customer journey funnel performance
- monthly performance ranking

Advanced SQL techniques included:

- Common Table Expressions (`CTEs`)
- conditional aggregation
- `CASE` expressions
- `PERCENTILE_CONT`
- `LAG`
- `RANK`
- `DENSE_RANK`
- rolling window calculations

[View Business Analysis SQL](SQL/05_business_analysis.sql)

---

# Data Models

## SQL Relational Model

The SQL model connects website activity with transactional and product-level information.

![SQL Data Model](Images/SQL_DataModel_Ecommerce_Marketing_Analysis.png)

---

## Power BI Data Model

The Power BI model was structured to support website, order, product and refund analysis while avoiding ambiguous filter paths.

A dedicated Date table was used for time-based reporting and month-on-month calculations.

![Power BI Data Model](Images/PowerBI_DataModel_Ecommerce_Marketing_Analysis.png)

---

# Power BI Dashboard

Two Power BI dashboard pages were created to separate **commercial performance** from **marketing and website behaviour**.

---

## Dashboard 1 — Order Performance & Conversion Funnel

This dashboard provides an executive view of order and revenue performance.

It includes:

- Total Orders
- Net Revenue
- Average Order Value
- Gross Profit
- Total Refund Amount
- Refund Rate
- Customer Conversion Funnel
- Sessions, Orders & Conversion Rate Over Time
- Order Value Band Performance
- Refund Amount Over Time

![Order Performance and Conversion Funnel](Images/01_OrderPerformance_&_ConversionFunnel.png)

The dashboard allows users to explore performance by:

- Year Month
- Order Value Band
- Device Type

---

## Dashboard 2 — Marketing Traffic Overview

This dashboard focuses on website acquisition and engagement.

It includes:

- Total Sessions
- Total Users
- Average Session Duration
- Conversion Rate
- Repeat Sessions
- Repeat User Session %
- Monthly Website Sessions
- Sessions by Marketing Channel
- Sessions by Device Type
- Most Viewed Pages

![Marketing Traffic Overview](Images/02_Marketing_Traffic_Overview.png)

The dashboard helps identify how users discover the website, how traffic changes over time and how different acquisition sources contribute to website activity.

---

# Key Business Findings

## 1. Desktop Users Converted Much More Successfully

Desktop users achieved a conversion rate of approximately **8.50%**, compared with **3.09% for mobile users**.

Desktop traffic also generated approximately **$1.59M in net revenue**, compared with around **$260K from mobile**.

This represents one of the clearest performance gaps identified in the analysis.

---

## 2. Paid Search Was the Main Commercial Acquisition Channel

Paid Search generated approximately **$1.48M in net revenue**, making it the strongest marketing channel by commercial contribution.

Paid Social converted considerably less effectively, with a conversion rate of approximately **3.21%**.

---

## 3. Landing Page Performance Varied Considerably

`/lander-5` achieved the strongest observed landing-page conversion rate at approximately **10.17%**.

This showed that the landing page receiving the greatest traffic was not necessarily the page producing the strongest conversion efficiency.

---

## 4. Product View to Cart Was the Largest Funnel Opportunity

The customer journey included approximately:

- **472,871 total sessions**
- **261,231 product-view sessions**
- **94,953 cart sessions**
- **64,484 shipping sessions**
- **32,313 completed orders**

Approximately **63.7% of sessions reaching the product stage did not progress to the cart**, making this the largest major funnel drop.

---

## 5. Converted Visitors Were Much More Engaged

Converted sessions lasted approximately **14.95 minutes on average**, compared with around **3.15 minutes for non-converted sessions**.

This indicates a strong association between deeper website engagement and purchase completion.

---

## 6. Returning Users Were More Likely to Convert

Repeat-user sessions converted at approximately **7.40%**, compared with **6.62% for non-repeat users**.

Later sessions also converted more effectively than first sessions, indicating stronger purchase intent among returning visitors.

---

## 7. Multi-Item Orders Generated Greater Value

Multi-item orders represented approximately **23.87% of all orders**.

However, average order revenue increased from approximately:

- **$50.82 for single-item orders**
- to **$89.25 for multi-item orders**

Average gross profit also increased substantially.

This highlights basket expansion and cross-selling as important commercial opportunities.

---

## 8. Product Revenue Was Concentrated

**The Original Mr. Fuzzy** generated approximately **62.5% of total item revenue**, making it the dominant product in the portfolio.

The analysis also identified differences in refund behaviour between products, with the **Birthday Sugar Panda** recording the highest observed refund rate at approximately **6.04%**.

---

## 9. Refunds Reduced Revenue but Remained Relatively Controlled

Approximately **5.33% of orders** were associated with refunds.

Total refunds amounted to approximately **$85.3K**, while total net revenue was approximately **$1.85M**.

---

## 10. Commercial Performance Strengthened Over Time

**December 2014** generated the highest monthly net revenue at approximately **$139.5K**, with **2,314 orders**.

**February 2015** recorded the highest monthly conversion rate at approximately **8.69%**.

The results also showed that the strongest revenue month was not necessarily the strongest conversion month, reinforcing the importance of monitoring traffic, conversion and revenue together.

---

## Explore the Full Findings

[View Key Business Findings](Findings/key_business_findings.md)

[View Business Recommendations](Findings/recommendations.md)

[View Data Quality Summary](Findings/data_quality_summary.md)

---

# Business Recommendations

Based on the analysis, the main recommended priorities are:

1. **Improve the mobile purchase journey** to address the large desktop-mobile conversion gap.
2. **Reduce Product View → Cart drop-off** through stronger product pages and clearer calls to action.
3. **Protect and optimise Paid Search investment** while reviewing weaker Paid Social performance.
4. **Encourage multi-item purchases** through cross-selling, bundles and complementary product recommendations.
5. **Strengthen repeat-customer engagement** through remarketing and targeted return-visit strategies.
6. **Monitor product-level refund patterns** and investigate products with comparatively high refund rates.

[View Full Business Recommendations](Findings/recommendations.md)

---

# Project Structure

```text
Project_03_Ecommerce_Marketing_Conversion_Analysis/
│
├── README.md
│
├── SQL/
│   ├── 01_primary_foreign_key_constraints.sql
│   ├── 02_data_quality_validation.sql
│   ├── 03_date_logical_validation.sql
│   ├── 04_derived_fields.sql
│   └── 05_business_analysis.sql
│
├── Findings/
│   ├── data_quality_summary.md
│   ├── key_business_findings.md
│   └── recommendations.md
│
├── POWERBI/
│   └── Ecommerce_Marketing_Conversion_Analysis.pbix
│
├── Images/
│   ├── 01_OrderPerformance_&_ConversionFunnel.png
│   ├── 02_Marketing_Traffic_Overview.png
│   ├── PowerBI_DataModel_Ecommerce_Marketing_Analysis.png
│   └── SQL_DataModel_Ecommerce_Marketing_Analysis.png
│
└── Documentation/
