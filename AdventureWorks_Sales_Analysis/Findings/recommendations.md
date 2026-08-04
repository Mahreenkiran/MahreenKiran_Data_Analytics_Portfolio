# Business Recommendations

## Overview

The following recommendations are based on the SQL analysis of AdventureWorks sales, customer, product, territory and operational performance.

These recommendations are analytical suggestions for a fictional Microsoft sample business. They are not recommendations made to a real employer.

---

## 1. Protect and Develop High-Value Customer Relationships

### Evidence

Only 244 high-value customers generated 65.09% of total revenue.

### Recommendation

Create a dedicated high-value customer retention programme.

This could include:

- named account ownership
- scheduled customer reviews
- early access to new products
- tailored commercial offers
- monitoring for declining order frequency
- prioritised service and support

### Expected business benefit

Reducing the loss of high-value customers would help protect a significant proportion of company revenue.

---

## 2. Develop Selected Low-Value Customers

### Evidence

18,642 low-value customers generated 27.05% of revenue, while only 233 customers fell into the medium-value segment.

### Recommendation

Identify low-value customers with signs of growth potential, such as:

- increasing order frequency
- rising average order value
- recent purchases from high-margin categories
- repeated purchases across several product groups

Target these customers with relevant cross-selling and upselling campaigns.

### Expected business benefit

Moving even a small proportion of low-value customers into the medium-value segment could broaden the revenue base and reduce dependence on the highest-value accounts.

---

## 3. Treat Business and Individual Customers Differently

### Evidence

The highest-revenue customers were business accounts making relatively few large orders.

The most frequent individual customers placed many orders but generated relatively low total revenue.

### Recommendation

Use separate customer strategies:

**Business customers**

- account management
- volume-based pricing
- contract renewal monitoring
- large-order forecasting
- tailored product bundles

**Individual customers**

- loyalty programmes
- automated recommendations
- repeat-purchase incentives
- accessory and clothing cross-selling

### Expected business benefit

Separating these customer types would make marketing and account-management activity more relevant and cost-effective.

---

## 4. Reduce Dependence on the Bikes Category

### Evidence

Bikes generated 86.17% of total company revenue.

### Recommendation

Continue protecting the Bikes category while exploring controlled growth in Components, Clothing and Accessories.

Potential actions include:

- creating bike and accessory bundles
- recommending clothing or accessories at checkout
- reviewing component demand by bike model
- measuring attachment rates for related products
- developing post-purchase campaigns

### Expected business benefit

Increasing related-product sales could improve revenue diversification without weakening the company’s core bike business.

---

## 5. Prioritise the Strongest Product Families

### Evidence

Mountain-200 variants dominated the highest product revenue positions.

Road Bikes and Mountain Bikes were the leading product subcategories.

### Recommendation

Maintain strong availability for leading bike families and investigate:

- stock availability by size and colour
- demand patterns by territory
- product substitution when a preferred size is unavailable
- pricing differences between variants
- promotional performance

### Expected business benefit

Protecting availability for proven high-revenue products can reduce lost sales and improve customer satisfaction.

---

## 6. Review Products With No Recorded Sales

### Evidence

Several products generated zero revenue and sold zero units.

### Recommendation

Classify zero-sales products before taking action.

Possible classifications include:

- internal component
- discontinued
- newly introduced
- not commercially available
- obsolete
- genuinely underperforming

Only products intended for customer sale should be considered for removal, promotion or pricing changes.

### Expected business benefit

This prevents valid internal products from being incorrectly classified as failures while highlighting genuine catalogue inefficiencies.

---

## 7. Protect Medium and High-Value Orders

### Evidence

Medium-value orders represented about 11.4% of orders but generated 48.04% of revenue.

High-value orders represented about 1.3% of orders but generated 28.88% of revenue.

### Recommendation

Monitor large-order activity separately from ordinary consumer transactions.

Management reporting should include:

- number of high-value orders
- pipeline of expected large orders
- customers responsible for large orders
- order cancellation risk
- territory concentration
- salesperson ownership

### Expected business benefit

This would improve visibility over the relatively small number of transactions that generate most revenue.

---

## 8. Use Territory-Specific Sales Strategies

### Evidence

Territories had very different combinations of volume and average order value.

Australia had high order volume but low average order value.

Central and Southeast had low order volume but very high average order values.

### Recommendation

Use different strategies by territory.

**High-volume, lower-value territories**

- improve repeat-purchase rates
- increase cross-selling
- raise average basket value
- promote product bundles

**Low-volume, high-value territories**

- focus on key accounts
- protect large commercial orders
- improve account forecasting
- identify similar high-potential customers

### Expected business benefit

Territory-specific strategies are more likely to improve performance than applying one national or global approach.

---

## 9. Assess Salespeople Using a Balanced Scorecard

### Evidence

Linda Mitchell generated the highest revenue, while Jillian Carson handled more orders.

Some salespeople achieved high average order values from fewer transactions.

### Recommendation

Evaluate salespeople using several measures:

- total revenue
- number of orders
- average order value
- territory potential
- customer retention
- revenue growth
- proportion of high-value orders

### Expected business benefit

A balanced scorecard avoids rewarding only order volume or only revenue and provides a fairer view of performance.

---

## 10. Investigate Monthly Revenue Volatility

### Evidence

The month-over-month analysis showed several large increases and decreases.

### Recommendation

Investigate whether monthly changes were caused by:

- seasonal demand
- large business orders
- territory mix
- product mix
- promotions
- changes in customer activity

Use a 3-month moving average alongside the monthly revenue line to make the underlying trend easier to interpret.

### Expected business benefit

Understanding the causes of volatility would improve forecasting and reduce overreaction to one unusually high or low month.

---

## 11. Separate Never-Purchased Customers From Lapsed Customers

### Evidence

Several customers had no linked order and therefore had a `NULL` last order date.

### Recommendation

Create two separate groups:

1. Customers who have never purchased
2. Customers who purchased previously but have not ordered recently

Use different actions:

**Never purchased**

- onboarding messages
- first-purchase incentives
- lead qualification

**Previously active but now inactive**

- reactivation campaigns
- account-manager outreach
- review of past products and order value

### Expected business benefit

This would create more relevant retention and acquisition activity.

---

## 12. Maintain the Standardised Shipping Process

### Evidence

All territories had an average shipping time of 7 days, and no orders were found where shipment occurred after the due date.

### Recommendation

Continue monitoring fulfilment consistency, but add more detailed measures such as:

- minimum and maximum shipping time
- percentage shipped within a target number of days
- shipping duration by product category
- shipping duration by order-value segment
- monthly fulfilment trend

### Expected business benefit

More detailed measures would identify variation that is hidden by the current average.

---

## Recommended Power BI Focus

The Power BI dashboard should highlight the most decision-relevant findings.

### Executive Overview

- Total revenue
- Total orders
- Total units sold
- Average order value
- Monthly revenue trend
- Month-over-month change
- Revenue by territory
- Order-value segment contribution

### Product Performance

- Category revenue contribution
- Top products
- Subcategory revenue
- Units sold
- Products with no sales

### Customer and Sales Performance

- Customer segment contribution
- Top customers
- Order frequency
- Territory performance
- Salesperson performance
- Inactive customers

---

## Final Recommendation

AdventureWorks should prioritise revenue protection before broad expansion.

The most important actions are:

1. Retain high-value customers.
2. Protect medium and high-value orders.
3. Maintain availability of leading bike products.
4. develop selected low-value customers.
5. diversify revenue through related product categories.
6. use territory-specific commercial strategies.
7. monitor monthly volatility and large-order concentration.
