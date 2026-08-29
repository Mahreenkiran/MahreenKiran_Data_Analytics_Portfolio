# Key Business Findings

## Project Overview

The AdventureWorks Sales and Customer Performance Analysis examined sales activity between **30 May 2022 and 29 June 2025**.

The analysis covered:

- **31,465 complete sales orders**
- **121,317 sales order lines**
- **274,914 units sold**
- product and category performance
- customer value and purchasing behaviour
- territory and salesperson performance
- order fulfilment
- data quality

The findings below are based on validated SQL analysis and cross-checked Power BI results.

---

## 1. Overall Sales Performance

### Finding

AdventureWorks generated total sales revenue of **109,846,381.40** from **31,465 orders**.

A total of **274,914 units** were sold, and the average order value was **3,491.07**.

### Business meaning

The average order value provides a useful benchmark for comparing customer, territory and transaction behaviour.

Orders substantially above this value are more likely to represent larger commercial purchases, while lower-value orders are more typical of smaller transactions.

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

Monthly sales performance showed substantial variation throughout the available period.

Examples from the month-over-month analysis included:

- revenue increased by **286.54%** in June 2022 compared with May 2022
- revenue decreased by **16.63%** in July 2022
- revenue decreased by a further **20.52%** in August 2022
- revenue increased by **113.88%** in September 2022
- revenue decreased by **36.67%** in November 2022
- revenue increased by **74.22%** in December 2022

### Business meaning

Sales did not follow a steady month-to-month pattern.

The size of the fluctuations suggests that performance may be influenced by factors such as customer mix, large commercial orders, product demand or seasonal purchasing patterns.

Individual months should therefore be interpreted within the wider sales trend rather than in isolation.

### Evidence

The month-over-month analysis compared each month's revenue with the immediately preceding month using SQL window functions.

---

## 3. Medium and High-Value Orders Generated Most Revenue

### Finding

Most orders were classified as low-value transactions, but they generated a relatively small proportion of company revenue.

| Order segment | Number of orders | Revenue | Revenue contribution |
|---|---:|---:|---:|
| Medium Value Order | 3,600 | 52,777,326.95 | 48.05% |
| High Value Order | 407 | 31,733,946.80 | 28.89% |
| Low Value Order | 27,458 | 25,335,107.65 | 23.06% |

High-value orders represented only approximately **1.3% of all orders**, but generated **28.89% of total revenue**.

Medium-value orders represented approximately **11.4% of orders** and generated almost half of company revenue.

### Business meaning

Revenue is strongly influenced by a relatively small proportion of medium and high-value transactions.

Together, these two segments generated more than three-quarters of total company revenue despite representing a minority of total orders.

### Evidence

The order-value segmentation used the following analyst-defined thresholds:

- **Low value:** 3,491 or below
- **Medium value:** above 3,491 and up to 55,000
- **High value:** above 55,000

---

## 4. Bikes Dominated Company Revenue

### Finding

The **Bikes** category generated **94,651,172.70**, representing **86.17% of total company revenue**.

| Category | Revenue | Revenue contribution |
|---|---:|---:|
| Bikes | 94,651,172.70 | 86.17% |
| Components | 11,802,593.29 | 10.74% |
| Clothing | 2,120,542.52 | 1.93% |
| Accessories | 1,272,072.88 | 1.16% |

### Business meaning

AdventureWorks revenue was heavily concentrated in bike sales.

Components provided the second-largest contribution, while Clothing and Accessories represented only a small share of company revenue.

This concentration highlights the commercial importance of the Bikes category while also demonstrating limited revenue diversification across other product groups.

---

## 5. Road Bikes Were the Strongest Product Subcategory

### Finding

Road Bikes generated the highest product-subcategory revenue at approximately **43.91 million**, followed by Mountain Bikes at approximately **36.45 million**.

| Subcategory | Units sold | Revenue |
|---|---:|---:|
| Road Bikes | 47,196 | 43,909,437.51 |
| Mountain Bikes | 28,321 | 36,445,443.94 |
| Touring Bikes | 14,751 | 14,296,291.26 |
| Mountain Frames | 11,621 | 4,713,930.23 |
| Road Frames | 11,753 | 3,851,350.60 |

### Business meaning

Road Bikes combined the highest revenue with the strongest unit sales among the leading subcategories.

Mountain Bikes also made a major financial contribution despite selling fewer units.

Together, these results reinforce the importance of the core bike product range to overall company performance.

---

## 6. Mountain-200 Products Led Individual Product Revenue

### Finding

Mountain-200 variants occupied the highest positions in the individual product revenue ranking.

The leading product was:

- **Mountain-200 Black, 38**
- Units sold: **2,977**
- Revenue: **4,400,592.80**

Other leading products included Mountain-200 Black and Silver variants in different sizes, followed by Road-250 products.

### Business meaning

Revenue concentration exists not only at category and subcategory level but also within a specific high-performing product family.

The Mountain-200 range appears to be commercially important across several colours and sizes.

---

## 7. Some Products Recorded No Sales

### Finding

Several products recorded:

- zero units sold
- zero revenue
- no sales activity during the analysis period

Visible examples included External Lock Washer products, Adjustable Race and BB Ball Bearing.

### Business meaning

Products with no recorded sales should not automatically be interpreted as commercially unsuccessful.

These records may represent:

- internal components
- discontinued products
- obsolete items
- products not intended for direct customer sale
- products with no recorded demand during the available period

The business purpose and lifecycle status of these products should therefore be considered before drawing performance conclusions.

---

## 8. A Small High-Value Customer Segment Generated Most Revenue

### Finding

Only **244 high-value customers** generated **65.10% of total company revenue**.

| Customer segment | Number of customers | Segment revenue | Revenue contribution |
|---|---:|---:|---:|
| High Value Customer | 244 | 71,509,740.18 | 65.10% |
| Medium Value Customer | 233 | 8,619,787.69 | 7.85% |
| Low Value Customer | 18,642 | 29,716,853.53 | 27.05% |

High-value customers represented approximately **1.3% of purchasing customers** but generated almost two-thirds of total revenue.

### Business meaning

Customer value was highly concentrated within a relatively small high-value segment.

The medium-value customer group was comparatively small, while the large low-value customer population generated just over one-quarter of total revenue.

This highlights the importance of considering customer value alongside customer count.

---

## 9. The Highest-Revenue Customers Were Business Accounts

### Finding

The highest-revenue customer was **Brakes and Gears**, which generated **877,107.19** from **12 orders**.

Other leading customer accounts included:

- **Excellent Riding Supplies:** 853,849.18
- **Vigorous Exercise Company:** 841,908.77
- **Totes & Baskets Company:** 816,755.58
- **Retail Mall:** 799,277.90
- **Corner Bicycle Supply:** 787,773.04

### Business meaning

The largest customer accounts were predominantly store or business customers rather than individual consumers.

Their high revenue was generated through relatively few but high-value orders, indicating a different purchasing pattern from frequent individual customers.

---

## 10. Frequent Customers Did Not Necessarily Generate High Revenue

### Finding

Some of the most frequent individual customers placed between **27 and 28 orders**, but their total revenue and average order values remained low.

For example:

- **Mason Roberts** placed 28 orders but generated only **1,320.01**
- **Dalton Perez** placed 28 orders and generated **1,189.33**
- their average order values were **47.14** and **42.48** respectively

### Business meaning

Order frequency alone is not a sufficient measure of customer value.

Some individuals purchased frequently but made small transactions, while business customers placed fewer orders but generated substantially higher revenue.

Customer value is therefore better understood by considering:

- order frequency
- total revenue
- average order value

together.

---

## 11. 701 Customer Records Had No Linked Purchase History

### Finding

AdventureWorks contained **19,820 customer records**, of which **19,119 had placed at least one order**.

The remaining **701 customer records had no linked purchase history**.

### Business meaning

Customers with no purchase history represent a different population from customers who purchased previously but later became inactive.

Separating these groups provides a clearer view of the active customer base and prevents never-purchased records from being incorrectly interpreted as low-value purchasing customers or lapsed customers.

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

Southwest combined high order volume with a comparatively strong average order value.

Australia recorded a greater number of orders but a substantially lower average order value, which limited its total revenue.

Central produced significant revenue from only 385 orders because its average order value was exceptionally high.

---

## 13. Territory Performance Reflected Different Purchasing Patterns

### Finding

Territories displayed very different combinations of order volume and average order value.

Examples included:

- **Australia:** 6,843 orders with an average order value of **1,557.11**
- **Central:** 385 orders with an average order value of **20,542.88**
- **Southeast:** 486 orders with an average order value of **16,213.28**

### Business meaning

Territory performance cannot be understood using revenue alone.

Some markets generated performance through a large number of lower-value transactions, while others depended on a much smaller number of high-value commercial orders.

These differences indicate distinct customer and transaction profiles across territories.

---

## 14. Linda Mitchell Generated the Highest Salesperson Revenue

### Finding

**Linda Mitchell** generated the highest salesperson revenue at **10,367,007.43** from **418 orders**.

**Jillian Carson** generated **10,065,803.54** and processed **473 orders**.

| Salesperson | Revenue | Orders | Average order value |
|---|---:|---:|---:|
| Linda Mitchell | 10,367,007.43 | 418 | 24,801.45 |
| Jillian Carson | 10,065,803.54 | 473 | 21,280.77 |
| Michael Blythe | 9,293,903.00 | 450 | 20,653.12 |
| Jae Pak | 8,503,338.65 | 348 | 24,434.88 |

### Business meaning

Linda Mitchell generated the highest revenue without processing the highest number of orders, indicating a stronger average order value.

Jillian Carson achieved a similar revenue level through a greater number of transactions.

This demonstrates that salesperson performance is better understood using multiple measures rather than revenue or order volume alone.

---

## 15. Shipping Performance Was Highly Consistent Across Territories

### Finding

Every analysed territory recorded an average shipping time of approximately **7 days**.

A separate validation check found no completed orders where the shipment date occurred after the due date.

### Business meaning

The available data suggests a highly standardised fulfilment pattern across territories.

No territory showed a longer average shipping duration than another at the whole-day level.

### Limitation

Shipping duration was calculated using whole-number day differences, so smaller variations measured in hours are not visible.

The identical seven-day result across all territories may also reflect the design of the fictional AdventureWorks sample database rather than genuine operational variation.

---

## 16. Annual Sales Performance Strengthened in 2024

### Finding

Among the complete calendar years available, revenue increased from **31,604,921.95 in 2023** to **43,671,889.50 in 2024**, representing growth of approximately **38.18%**.

Order volume increased from **3,830 orders in 2023** to **14,244 orders in 2024**, while units sold increased from **66,441** to **131,936**.

Average order value decreased from **8,251.94** to **3,065.98**.

### Business meaning

The increase in 2024 revenue was driven primarily by substantially higher transaction and unit volumes rather than larger individual orders.

This indicates a shift towards a higher-volume sales pattern during 2024.

### Limitation

The **2022 and 2025 results represent partial years**.

The dataset begins on **30 May 2022** and ends on **29 June 2025**, so those years should not be compared directly with complete calendar years.

---

## 17. Top 10 Customers Accounted for 7.21% of Revenue

### Finding

The top 10 customers generated combined revenue of **7,922,046.38**, representing **7.21% of total company revenue**.

### Business meaning

Although the broader high-value customer segment contributes a large share of company revenue, the ten largest customer accounts generated only **7.21% of total revenue**.

This indicates that customer revenue concentration is distributed across the wider high-value customer segment rather than being dominated by only a few individual accounts.

The wider group of **244 high-value customers**, which generated **65.10% of total revenue**, therefore represents the more significant concentration of customer value.

### Evidence

| Measure | Result |
|---|---:|
| Top 10 customer revenue | 7,922,046.38 |
| Total company revenue | 109,846,381.40 |
| Top 10 revenue contribution | 7.21% |

---

## Overall Business Conclusion

AdventureWorks generated total revenue of approximately **109.85 million** from **31,465 orders** and **274,914 units sold** during the available analysis period.

Business performance was concentrated in several important areas:

- the **Bikes** category generated **86.17% of total revenue**
- Road Bikes and Mountain Bikes were the strongest product subcategories
- Mountain-200 variants dominated the highest-revenue individual products
- **244 high-value customers generated 65.10% of total revenue**
- medium and high-value orders generated the majority of company revenue despite representing a relatively small proportion of total orders
- Southwest generated the highest territory revenue
- territory performance varied substantially in terms of order volume and average order value

The analysis also identified two distinct purchasing patterns:

1. **High-volume, lower-value consumer purchasing**
2. **Lower-volume, high-value business purchasing**

Annual performance strengthened substantially between the complete calendar years of **2023 and 2024**, with revenue increasing by approximately **38.18%**.

This growth was accompanied by significantly higher order and unit volumes alongside a lower average order value, indicating a shift towards a higher-volume sales model.

Overall, the results demonstrate the importance of evaluating **revenue, customer value, order size, product mix, territory performance and transaction volume together** rather than relying on a single performance measure.
