# Key Business Findings

## Project Overview

The AdventureWorks Sales and Customer Performance Analysis examined sales activity between **30 May 2022 and 29 June 2025**.

The analysis covered:

- 31,465 complete sales orders
- 121,317 sales order lines
- 274,914 units sold
- product and category performance
- customer value and purchasing behaviour
- territory and salesperson performance
- order fulfilment
- data quality

The findings below are based on validated results from the SQL analysis.

---

## 1. Overall Sales Performance

### Finding

AdventureWorks generated total sales revenue of **109,846,381.40** from **31,465 orders**.

A total of **274,914 units** were sold, and the average order value was **3,491.07**.

### Business meaning

The average order value provides a useful benchmark for comparing customers, territories and order segments.

Orders significantly above this value may represent business customers or large commercial purchases, while orders below it are likely to represent smaller or individual transactions.

### Evidence

| KPI | Result |
|---|---:|
| Total revenue | 109,846,381.40 |
| Total orders | 31,465 |
| Total units sold | 274,914 |
| Average order value | 3,491.07 |

---

## 2. Monthly Revenue Was Volatile

### Finding

Monthly sales performance showed considerable variation.

Examples from the available monthly results include:

- Revenue increased by **286.54%** in June 2022 compared with May 2022.
- Revenue decreased by **16.63%** in July 2022.
- Revenue decreased by a further **20.52%** in August 2022.
- Revenue increased by **113.88%** in September 2022.
- Revenue decreased by **36.67%** in November 2022.
- Revenue increased by **74.22%** in December 2022.

### Business meaning

Sales did not follow a steady monthly pattern. Large increases were frequently followed by declines, suggesting that sales may be influenced by seasonality, major commercial orders or changing product demand.

The business should avoid relying on a single month when assessing performance.

### Evidence

The month-over-month analysis compared each month’s revenue with the immediately preceding month using `LAG()`.

---

## 3. A Small Number of Larger Orders Generated a Disproportionate Share of Revenue

### Finding

Most orders were classified as low-value orders, but these generated a relatively small share of total revenue.

| Order segment | Number of orders | Revenue | Revenue contribution |
|---|---:|---:|---:|
| Medium Value Order | 3,600 | 52,777,326.95 | 48.04% |
| High Value Order | 407 | 31,733,946.80 | 28.88% |
| Low Value Order | 27,458 | 25,335,107.65 | 23.06% |

High-value orders represented only about **1.3% of all orders**, but generated **28.88% of total revenue**.

Medium-value orders represented about **11.4% of orders** and generated nearly half of company revenue.

### Business meaning

Revenue is strongly influenced by a relatively small number of medium and high-value transactions.

Maintaining these larger orders is commercially important, even though they represent a minority of total order volume.

### Evidence

The order-value segmentation used the following analyst-defined thresholds:

- Low value: 3,491 or below
- Medium value: above 3,491 and up to 55,000
- High value: above 55,000

---

## 4. Bikes Dominated Company Revenue

### Finding

The Bikes category generated **94,651,172.70**, representing **86.17%** of total company revenue.

| Category | Revenue | Revenue contribution |
|---|---:|---:|
| Bikes | 94,651,172.70 | 86.17% |
| Components | 11,802,593.29 | 10.74% |
| Clothing | 2,120,542.52 | 1.93% |
| Accessories | 1,272,072.88 | 1.16% |

### Business meaning

AdventureWorks is highly dependent on bike sales.

This concentration creates strong commercial focus, but it also creates risk. A decline in bike demand could have a significant effect on overall company revenue.

Components provide the second-largest contribution, while Clothing and Accessories contribute only a small proportion.

---

## 5. Road Bikes Were the Strongest Product Subcategory

### Finding

Road Bikes generated the highest subcategory revenue at approximately **43.91 million**, followed by Mountain Bikes at approximately **36.45 million**.

| Subcategory | Units sold | Revenue |
|---|---:|---:|
| Road Bikes | 47,196 | 43,909,437.51 |
| Mountain Bikes | 28,321 | 36,445,443.94 |
| Touring Bikes | 14,751 | 14,296,291.26 |
| Mountain Frames | 11,621 | 4,713,930.23 |
| Road Frames | 11,753 | 3,851,350.60 |

### Business meaning

Road Bikes delivered the highest combination of revenue and sales volume.

Mountain Bikes also made a major financial contribution, despite selling fewer units than Road Bikes.

This suggests that both subcategories should remain central to sales planning, inventory management and marketing.

---

## 6. Mountain-200 Products Led Individual Product Revenue

### Finding

Mountain-200 product variants occupied the highest positions in the product revenue ranking.

The leading visible product was:

- **Mountain-200 Black, 38**
- Units sold: **2,977**
- Revenue: **4,400,592.80**

Other leading products included Mountain-200 Black and Silver variants in different sizes.

### Business meaning

Revenue is concentrated not only at category level but also within a specific product family.

The Mountain-200 range appears to be commercially important across multiple colours and sizes.

### Evidence

The visible top-product results were dominated by Mountain-200 variants, followed by Road-250 products.

---

## 7. Some Products Recorded No Sales

### Finding

Several products had:

- zero units sold
- zero revenue
- a status of `No Revenue Generated`

Visible examples included several External Lock Washer products, Adjustable Race and BB Ball Bearing.

### Business meaning

Zero-sales products may represent:

- components not sold directly to customers
- obsolete or discontinued products
- internally used items
- products with no demand during the period
- products included in the catalogue but not intended for commercial sale

These products should not automatically be labelled as failures without reviewing their product status and intended business purpose.

---

## 8. Revenue Was Concentrated Among a Small Customer Group

### Finding

Only **244 high-value customers** generated **65.09%** of total company revenue.

| Customer segment | Number of customers | Segment revenue | Revenue contribution |
|---|---:|---:|---:|
| High Value Customer | 244 | 71,509,740.18 | 65.09% |
| Medium Value Customer | 233 | 8,619,787.69 | 7.84% |
| Low Value Customer | 18,642 | 29,716,853.53 | 27.05% |

High-value customers represented approximately **1.3% of customers**, but generated almost two-thirds of total revenue.

### Business meaning

AdventureWorks depends heavily on a relatively small group of high-value customers.

Losing even a small number of these customers could materially affect revenue.

The medium-value segment is small in both customer count and contribution, which may indicate an opportunity to develop selected low-value customers into more valuable accounts.

---

## 9. The Highest-Revenue Customers Were Business Accounts

### Finding

The highest-revenue visible customer was **Brakes and Gears**, generating **877,107.19** from 12 orders.

Other major customers included:

- Excellent Riding Supplies: 853,849.18
- Vigorous Exercise Company: 841,908.77
- Totes & Baskets Company: 816,755.58
- Retail Mall: 799,277.90
- Corner Bicycle Supply: 787,773.04

### Business meaning

The largest customer accounts appear to be store or business customers rather than individual consumers.

Their high revenue is generated through relatively few, high-value orders.

These accounts should be treated differently from frequent individual customers.

---

## 10. Frequent Customers Did Not Necessarily Generate High Revenue

### Finding

The most frequent visible individual customers placed between **27 and 28 orders**, but their total revenue and average order values were low.

For example:

- Mason Roberts placed 28 orders but generated only 1,320.01.
- Dalton Perez placed 28 orders and generated 1,189.33.
- Their average order values were 47.14 and 42.48 respectively.

### Business meaning

Order frequency alone is not a sufficient measure of customer value.

Some individual customers purchase frequently but make small transactions, while business accounts purchase less frequently but generate much greater revenue.

Customer management should therefore consider:

- order frequency
- total revenue
- average order value

together rather than relying on only one measure.

---

## 11. Some Customer Records Had No Linked Order History

### Finding

The analysis identified <b> 701 customer records with no linked purchase history </b>.

AdventureWorks contained <b> 19,820 customer records </b>, of which <b> 19,119 had placed at least one order</b>. The remaining 701 records had no linked sales orders and should be distinguished from customers who purchased previously but later became inactive.

### Business meaning

These records may represent:

- prospective customers who never purchased
- inactive accounts
- customer records created for testing or administration
- incomplete historical activity

They should be separated from customers who purchased previously but have since become inactive.

---

## 12. Southwest Generated the Highest Territory Revenue

### Finding

Southwest generated the highest territory revenue at **24,184,609.60** from **6,224 orders**.

| Territory | Orders | Revenue | Average order value |
|---|---:|---:|---:|
| Southwest | 6,224 | 24,184,609.60 | 3,885.70 |
| Canada | 4,067 | 16,355,770.46 | 4,021.58 |
| Northwest | 4,594 | 16,084,942.55 | 3,501.29 |
| Australia | 6,843 | 10,655,335.96 | 1,557.11 |
| Central | 385 | 7,909,009.01 | 20,542.88 |

### Business meaning

Southwest combined strong order volume with a healthy average order value.

Australia placed the highest visible number of orders, but its lower average order value limited its total revenue.

Central generated high revenue from only 385 orders because its average order value was exceptionally high.

---

## 13. Territory Performance Was Driven by Different Business Models

### Finding

Territories showed very different combinations of order volume and order value.

Examples:

- Australia had **6,843 orders** but an average order value of only **1,557.11**.
- Central had only **385 orders** but an average order value of **20,542.88**.
- Southeast had **486 orders** and an average order value of **16,213.28**.

### Business meaning

Territories should not be compared using revenue alone.

Some markets depend on high transaction volumes, while others depend on a small number of large commercial orders.

Sales strategies should reflect these differences.

---

## 14. Linda Mitchell Generated the Highest Salesperson Revenue

### Finding

Linda Mitchell generated the highest visible salesperson revenue at **10,367,007.43** from 418 orders.

Jillian Carson generated **10,065,803.54** and handled the highest visible number of orders at 473.

| Salesperson | Revenue | Orders | Average order value |
|---|---:|---:|---:|
| Linda Mitchell | 10,367,007.43 | 418 | 24,801.45 |
| Jillian Carson | 10,065,803.54 | 473 | 21,280.77 |
| Michael Blythe | 9,293,903.00 | 450 | 20,653.12 |
| Jae Pak | 8,503,338.65 | 348 | 24,434.88 |

### Business meaning

Linda Mitchell achieved the highest revenue without processing the highest number of orders, indicating strong average order value.

Jillian Carson achieved a similar revenue level through a larger number of orders.

This demonstrates that salesperson performance should be assessed using both revenue and order volume.

---

## 15. Shipping Performance Was Consistent Across Territories

### Finding

Every analysed territory had an average shipping time of **7 days**.

### Business meaning

The available data suggests a highly standardised fulfilment process across territories.

No territory appeared to experience a longer average shipping time than another.

A separate validation check also found no orders where the shipping date was later than the due date.

### Limitation

Because the result was calculated using a whole-number day difference, smaller differences measured in hours are not visible.

The identical seven-day result across all territories may also reflect how the fictional sample database was designed rather than actual operational performance.

---

## 16. Annual Sales Performance Strengthened in 2024

### Finding

Among the complete calendar years available, revenue increased from **31,604,921.95 in 2023** to **43,671,889.50 in 2024**, representing growth of approximately **38.18%**.

Order volume increased from **3,830 orders in 2023** to **14,244 orders in 2024**, while units sold increased from **66,441** to **131,936**.

Average order value decreased from **8,251.94** to **3,065.98**.

### Business meaning

The 2024 growth was driven primarily by a much larger number of orders and units sold rather than larger individual orders.

This suggests that the business expanded through higher transaction volume, possibly through increased consumer activity or a change in customer and territory mix.

### Limitation

The 2022 and 2025 results represent partial years. The dataset begins on 30 May 2022 and ends on 29 June 2025, so those years should not be compared directly with complete calendar years.

## 17. The Top 10 Customers Did Not Create Excessive Account Concentration

### Finding

The top 10 customers generated combined revenue of **7,922,046.38**, representing **7.21%** of total company revenue.

### Business meaning

Revenue is concentrated within the broader high-value customer segment, but it is not dependent on only a very small number of individual accounts.

This reduces the immediate risk associated with losing one or two top customers, although the wider group of 244 high-value customers remains commercially important.

### Evidence

| Measure | Result |
|---|---:|
| Top 10 customer revenue | 7,922,046.38 |
| Total company revenue | 109,846,381.40 |
| Top 10 revenue contribution | 7.21% |

## Overall Business Conclusion

AdventureWorks generated strong revenue, but that revenue was highly concentrated in:

- the Bikes category
- selected bike product families
- a small group of high-value customers
- medium and high-value orders
- a limited number of high-performing territories and salespeople

The company also appears to serve two different customer and market patterns:

1. High-volume, lower-value consumer purchasing
2. Lower-volume, high-value business purchasing

This distinction should guide customer segmentation, territory strategy, product planning and dashboard design.
