# Data Quality Summary

## Overview

Before conducting the business analysis, the dataset was validated to confirm that the core tables, relationships, financial fields and chronological logic were reliable enough for downstream analysis.

The validation covered six core tables:

- `website_sessions`
- `website_pageviews`
- `orders`
- `order_items`
- `order_item_refunds`
- `products`

The dataset contained:

| Table | Row Count |
|---|---:|
| website_sessions | 472,871 |
| website_pageviews | 1,188,124 |
| orders | 32,313 |
| order_items | 40,025 |
| order_item_refunds | 1,731 |
| products | 4 |

---

## Structural Validation

Primary and foreign key relationships were established across the core transactional tables.

The following checks were completed:

- duplicate primary keys
- NULL primary keys
- orphan foreign-key records
- missing important analytical fields
- duplicate business records

No issues were identified in these checks.

The relationship structure confirmed that website sessions linked correctly to pageviews and orders, orders linked correctly to order items, products linked to the relevant order records, and refunds linked back to valid order items and orders.

---

## Financial Validation

Financial fields were checked for invalid or inconsistent values.

The analysis included:

- negative order revenue or cost values
- negative item prices or costs
- zero or negative refund values
- orders where cost exceeded revenue
- order items where cost exceeded selling price
- reconciliation between order revenue and summed item prices
- reconciliation between order cost and summed item costs
- refund amounts exceeding original item selling prices

No financial inconsistencies were identified.

Recorded order-level revenue and cost values reconciled successfully with the corresponding order-item totals.

---

## Order and Refund Consistency

Order and refund logic was also validated.

The following checks were completed:

- orders with zero or negative item counts
- recorded `items_purchased` compared with actual order-item rows
- refund order IDs compared with the order IDs associated with the refunded items
- refunds occurring before order or order-item creation

No inconsistencies were identified.

---

## Chronological and Behavioural Validation

Date and behavioural logic was checked across sessions, pageviews, orders, products and refunds.

The following scenarios were tested:

- pageviews occurring before session creation
- orders occurring before session creation
- order items occurring before order creation
- refunds occurring before purchase activity
- products referenced before product creation
- inconsistent repeat-session flags
- multiple sessions for the same user at the same timestamp
- pageview timestamps appearing out of sequence within a session

No chronological or behavioural anomalies were identified.

---

## Date Coverage

The dataset spans approximately three years of website and order activity.

| Dataset Area | Earliest Record | Latest Record |
|---|---|---|
| Website Sessions | 19 Mar 2012 | 19 Mar 2015 |
| Website Pageviews | 19 Mar 2012 | 19 Mar 2015 |
| Orders | 19 Mar 2012 | 19 Mar 2015 |
| Order Items | 19 Mar 2012 | 19 Mar 2015 |
| Refunds | 06 Apr 2012 | 01 Apr 2015 |
| Products | 19 Mar 2012 | 05 Feb 2014 |

Refund activity extends beyond the final recorded order date because refunds can occur after the original purchase. This was treated as valid post-purchase activity rather than a data-quality issue.

---

## Final Assessment

The validation identified no structural, relationship, financial, reconciliation, chronological or behavioural issues in the tested areas.

The dataset was therefore considered suitable for customer journey, marketing, conversion, order, revenue, refund and product performance analysis.

---

## Explore the Validation SQL

[View Primary and Foreign Key Constraints SQL](../SQL/01_primary_foreign_key_constraints.sql)

[View Data Quality Validation SQL](../SQL/02_data_quality_validation.sql)

[View Date and Logical Validation SQL](../SQL/03_date_logical_validation.sql)

[View Derived Fields SQL](../SQL/04_derived_fields.sql)
