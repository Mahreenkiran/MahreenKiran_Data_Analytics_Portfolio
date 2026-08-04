# Data Quality Summary

## Overview

Before completing the sales, customer, product, territory and operational analysis, the AdventureWorks2025 data was reviewed for common quality issues that could affect KPI accuracy.

The checks covered duplicate identifiers, invalid quantities, negative sales values, date inconsistencies, unmatched records, missing business fields, invalid discounts and overall dataset coverage.

No data-quality issues were identified in the checks performed.

## Validation Results

| Data-quality check | Result | Business impact |
|---|---|---|
| Duplicate sales orders | No issues found | Each sales order appears once in the order header data, supporting reliable order counts and order-level revenue calculations. |
| Duplicate sales order lines | No issues found | Each sales order detail identifier is unique, reducing the risk of duplicated product-level sales calculations. |
| Invalid order quantities | No issues found | No zero or negative quantities were identified, so total units sold can be calculated reliably. |
| Negative sales values | No issues found | No negative unit prices, discounts or line totals were identified, supporting reliable revenue calculations. |
| Invalid shipping dates | No issues found | No orders were recorded as shipped before the order date, so fulfilment-duration calculations use valid date sequences. |
| Unmatched order details | No issues found | Every sales order detail record links to a valid sales order header. |
| Unmatched products | No issues found | Every sold product links to a valid product record. |
| Missing or unmatched important order values | No issues found | Key order fields were complete, and all customer identifiers linked to valid customer records. |
| Invalid due dates | No issues found | No due dates were earlier than their related order dates, supporting reliable fulfilment analysis. |
| Invalid discounts | No issues found | All discounts were within the valid range of 0% to 100%. |
| Dataset coverage | 30 May 2022 to 29 June 2025 | The analysis covers 31,465 complete sales orders and 121,317 order-line records across just over three years. |

## Dataset Coverage

- **Earliest order date:** 30 May 2022
- **Latest order date:** 29 June 2025
- **Complete sales orders:** 31,465
- **Sales order lines:** 121,317
- **Approximate analysis period:** 3 years and 1 month

## Overall Assessment

The validation results indicate that the core AdventureWorks sales data is suitable for business analysis.

No duplicate order identifiers, invalid quantities, negative sales values, broken product relationships, unmatched order records or significant date inconsistencies were identified.

This provides a reliable foundation for calculating:

- total revenue
- total orders
- total units sold
- average order value
- customer and product performance
- territory and salesperson performance
- month-over-month trends
- order fulfilment measures

## Limitation

These checks confirm the structural and logical quality of the selected fields. They do not prove that every recorded value reflects real-world commercial activity because AdventureWorks is a fictional Microsoft sample database created for learning and demonstration purposes.
