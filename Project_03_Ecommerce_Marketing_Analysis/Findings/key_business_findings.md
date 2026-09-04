# Key Business Findings

## Overview

The analysis examined approximately three years of e-commerce activity covering website traffic, marketing acquisition, customer behaviour, conversion, orders, product performance and refunds.

The dataset contained 472,871 website sessions, 1.19 million pageviews and 32,313 completed orders.

The findings below highlight the most commercially relevant patterns identified through SQL analysis.

---

## 1. Overall Website Conversion

Across 472,871 website sessions, 32,313 sessions resulted in completed orders.

This represents an overall session-to-order conversion rate of approximately **6.8%**.

The analysis also showed that conversion performance improved over time, with **February 2015 recording the highest monthly conversion rate at approximately 8.69%**.

This suggests that the website became increasingly effective at converting traffic during the later stages of the analysis period.

---

## 2. Desktop Significantly Outperformed Mobile

Device performance showed a substantial difference between desktop and mobile users.

- Desktop conversion rate: **8.50%**
- Mobile conversion rate: **3.09%**
- Desktop net revenue: approximately **$1.59M**
- Mobile net revenue: approximately **$260K**

Desktop therefore generated the large majority of commercial value and converted users at more than twice the rate of mobile.

The difference suggests that the mobile customer journey may have contained more friction or attracted lower-intent traffic.

---

## 3. Paid Search Was the Main Revenue-Generating Marketing Channel

Paid Search was the dominant acquisition channel and generated approximately **$1.48M in net revenue**.

It contributed substantially more traffic, orders and revenue than the other marketing channels.

Paid Social performed considerably less strongly, with a conversion rate of approximately **3.21%**.

This indicates that Paid Search was the primary commercial driver, while Paid Social traffic was less effective at progressing to purchase.

---

## 4. Landing Page Performance Varied Substantially

Landing-page analysis showed meaningful differences in conversion effectiveness.

`/lander-5` recorded the highest conversion rate at approximately **10.17%**, despite not receiving the largest volume of traffic.

This demonstrates that the landing page receiving the most visitors was not necessarily the page generating the strongest conversion performance.

The result suggests that landing-page design and message alignment had an important relationship with purchase behaviour.

---

## 5. The Largest Funnel Drop Occurred Between Product Views and Cart

The customer journey funnel contained:

- **472,871** total sessions
- **261,231** sessions reaching the products page
- **94,953** sessions reaching the cart
- **64,484** sessions reaching shipping
- **32,313** completed orders

The largest drop occurred between **Product Views and Cart**.

Approximately **63.7% of sessions that reached the products stage did not continue to the cart**.

This represents one of the clearest opportunities in the customer journey, as improving progression from product exploration to cart could have a substantial impact on overall conversion.

---

## 6. Converted Sessions Showed Much Higher Engagement

Users who completed an order spent substantially longer on the website than users who did not convert.

- Converted sessions: approximately **14.95 minutes**
- Non-converted sessions: approximately **3.15 minutes**

Converted sessions therefore lasted almost five times longer on average.

This suggests that deeper engagement with the website was strongly associated with purchase completion.

---

## 7. Repeat Users Converted More Successfully

Repeat-user sessions produced stronger conversion performance than non-repeat-user sessions.

- Repeat-user conversion rate: approximately **7.40%**
- Non-repeat-user conversion rate: approximately **6.62%**

Session-sequence analysis supported the same pattern.

First sessions converted at approximately **6.64%**, while second, third and later sessions converted at around **7.8%**.

This indicates that customers who returned to the website were more likely to complete a purchase than users visiting for the first time.

---

## 8. Multi-Item Orders Generated Greater Commercial Value

Multi-item orders represented approximately **23.87% of all orders**.

Although they were the minority of transactions, their average commercial value was substantially higher.

| Order Type | Average Revenue | Average Gross Profit |
|---|---:|---:|
| Single-item orders | $50.82 | $31.48 |
| Multi-item orders | $89.25 | $57.27 |

Multi-item orders therefore generated approximately **76% more average revenue** and substantially higher average gross profit than single-item orders.

This indicates that increasing basket size could be an important opportunity for revenue and profitability growth.

---

## 9. The Original Mr. Fuzzy Was the Dominant Product

Product analysis showed that **The Original Mr. Fuzzy** was the strongest product by revenue.

It contributed approximately **62.5% of total item revenue**, making the business relatively dependent on a single product for a large share of product sales.

Its item refund rate was approximately **5.11%**.

The **Birthday Sugar Panda** recorded the highest product refund rate at approximately **6.04%**, indicating that refund behaviour also varied across products.

---

## 10. Refunds Had a Measurable but Controlled Revenue Impact

Across 32,313 orders:

- approximately **5.33% of orders** were associated with a refund
- total refund value was approximately **$85.3K**
- total net revenue was approximately **$1.85M**

Refunds therefore reduced realised revenue but remained relatively small compared with total sales.

Monitoring refund patterns by product remains important because some products showed higher refund rates than others.

---

## 11. Revenue and Order Volume Grew Strongly Over Time

Monthly performance showed substantial growth across the analysis period.

**December 2014** was the strongest month by net revenue, generating approximately:

- **$139.5K net revenue**
- **2,314 orders**

One of the strongest month-on-month increases occurred in **November 2012**, when:

- net revenue increased by approximately **66.28%**
- orders increased by approximately **66.58%**

The longer-term trend therefore indicates significant growth in both customer acquisition and commercial activity.

---

## 12. Revenue Growth and Conversion Did Not Always Peak Together

Monthly ranking analysis showed that the months generating the highest revenue were not always the same months producing the highest conversion rates.

For example:

- **December 2014** ranked strongest for revenue
- **February 2015** produced the highest conversion rate

This distinction is important because high commercial performance can result from increased traffic and order volume even when conversion efficiency is not at its maximum.

Revenue and conversion should therefore be monitored as complementary rather than interchangeable performance measures.

---

## Key Takeaways

The analysis highlights several major themes:

- desktop users generated substantially stronger conversion and revenue performance than mobile users
- Paid Search was the principal source of revenue-generating traffic
- landing-page effectiveness differed considerably across pages
- the largest customer-journey drop occurred between product viewing and cart entry
- returning users were more likely to convert
- longer and more engaged sessions were strongly associated with purchase completion
- multi-item purchases generated considerably greater value and profit
- revenue was concentrated around the strongest-performing product
- refunds remained manageable overall but varied across products
- website traffic, orders, revenue and conversion performance generally strengthened over time

Together, these findings identify opportunities around mobile optimisation, product-to-cart progression, repeat-customer engagement, basket expansion and product-level refund monitoring.

---

## Explore the Business Analysis SQL

[View Business Analysis SQL](../SQL/05_business_analysis.sql)

[View Derived Fields SQL](../SQL/04_derived_fields.sql)
