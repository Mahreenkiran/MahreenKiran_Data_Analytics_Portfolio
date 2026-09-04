/* ============================================================
   PROJECT: E-Commerce Marketing, Conversion and Customer Journey Analysis
   DATABASE: Ecommerce_Marketing_Conversion_Analysis
   SCHEMA: EMCA

   FILE: 02_data_quality_validation.sql

   PURPOSE:
   Validate the structural and analytical quality of the core
   e-commerce tables before completing business analysis.

   Validation includes:
   - row counts
   - duplicate and NULL primary keys
   - orphan foreign-key relationships
   - missing analytical fields
   - invalid financial values
   - order-item count reconciliation
   - order-level financial reconciliation
   - refund consistency
   - duplicate business records
   ============================================================ */


USE EcommerceMarketingAnalysis;
GO


/* ============================================================
   1. ROW COUNTS
   ============================================================ */

SELECT 'website_sessions' AS table_name, COUNT(*) AS row_count
FROM EMCA.website_sessions

UNION ALL

SELECT 'website_pageviews', COUNT(*)
FROM EMCA.website_pageviews

UNION ALL

SELECT 'orders', COUNT(*)
FROM EMCA.orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM EMCA.order_items

UNION ALL

SELECT 'order_item_refunds', COUNT(*)
FROM EMCA.order_item_refunds

UNION ALL

SELECT 'products', COUNT(*)
FROM EMCA.products;
GO



/* ============================================================
   2. DUPLICATE PRIMARY KEY CHECKS
   ============================================================ */

SELECT
    website_session_id,
    COUNT(*) AS duplicate_count
FROM EMCA.website_sessions
GROUP BY website_session_id
HAVING COUNT(*) > 1;
GO


SELECT
    website_pageview_id,
    COUNT(*) AS duplicate_count
FROM EMCA.website_pageviews
GROUP BY website_pageview_id
HAVING COUNT(*) > 1;
GO


SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM EMCA.orders
GROUP BY order_id
HAVING COUNT(*) > 1;
GO


SELECT
    order_item_id,
    COUNT(*) AS duplicate_count
FROM EMCA.order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1;
GO


SELECT
    order_item_refund_id,
    COUNT(*) AS duplicate_count
FROM EMCA.order_item_refunds
GROUP BY order_item_refund_id
HAVING COUNT(*) > 1;
GO


SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM EMCA.products
GROUP BY product_id
HAVING COUNT(*) > 1;
GO



/* ============================================================
   3. NULL PRIMARY KEY CHECKS
   ============================================================ */

SELECT *
FROM EMCA.website_sessions
WHERE website_session_id IS NULL;
GO


SELECT *
FROM EMCA.website_pageviews
WHERE website_pageview_id IS NULL;
GO


SELECT *
FROM EMCA.orders
WHERE order_id IS NULL;
GO


SELECT *
FROM EMCA.order_items
WHERE order_item_id IS NULL;
GO


SELECT *
FROM EMCA.order_item_refunds
WHERE order_item_refund_id IS NULL;
GO


SELECT *
FROM EMCA.products
WHERE product_id IS NULL;
GO



/* ============================================================
   4. ORPHAN FOREIGN KEY CHECKS
   ============================================================ */


/* Pageviews without a valid website session */

SELECT wp.*
FROM EMCA.website_pageviews AS wp
LEFT JOIN EMCA.website_sessions AS ws
    ON wp.website_session_id = ws.website_session_id
WHERE ws.website_session_id IS NULL;
GO


/* Orders without a valid website session */

SELECT o.*
FROM EMCA.orders AS o
LEFT JOIN EMCA.website_sessions AS ws
    ON o.website_session_id = ws.website_session_id
WHERE ws.website_session_id IS NULL;
GO


/* Orders without a valid primary product */

SELECT o.*
FROM EMCA.orders AS o
LEFT JOIN EMCA.products AS p
    ON o.primary_product_id = p.product_id
WHERE p.product_id IS NULL;
GO


/* Order items without a valid order */

SELECT oi.*
FROM EMCA.order_items AS oi
LEFT JOIN EMCA.orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;
GO


/* Order items without a valid product */

SELECT oi.*
FROM EMCA.order_items AS oi
LEFT JOIN EMCA.products AS p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
GO


/* Refunds without a valid order item */

SELECT r.*
FROM EMCA.order_item_refunds AS r
LEFT JOIN EMCA.order_items AS oi
    ON r.order_item_id = oi.order_item_id
WHERE oi.order_item_id IS NULL;
GO


/* Refunds without a valid order */

SELECT r.*
FROM EMCA.order_item_refunds AS r
LEFT JOIN EMCA.orders AS o
    ON r.order_id = o.order_id
WHERE o.order_id IS NULL;
GO



/* ============================================================
   5. MISSING IMPORTANT ANALYTICAL FIELDS
   ============================================================ */


/* Website Sessions */

SELECT *
FROM EMCA.website_sessions
WHERE created_at IS NULL
   OR user_id IS NULL
   OR is_repeat_session IS NULL
   OR device_type IS NULL;
GO


/* Website Pageviews */

SELECT *
FROM EMCA.website_pageviews
WHERE created_at IS NULL
   OR website_session_id IS NULL
   OR pageview_url IS NULL
   OR LTRIM(RTRIM(pageview_url)) = '';
GO


/* Orders */

SELECT *
FROM EMCA.orders
WHERE created_at IS NULL
   OR website_session_id IS NULL
   OR user_id IS NULL
   OR primary_product_id IS NULL
   OR items_purchased IS NULL
   OR order_revenue_usd IS NULL
   OR order_cost_of_goods_usd IS NULL;
GO


/* Order Items */

SELECT *
FROM EMCA.order_items
WHERE created_at IS NULL
   OR order_id IS NULL
   OR product_id IS NULL
   OR is_primary_item IS NULL
   OR item_price_usd IS NULL
   OR item_cost_of_goods_usd IS NULL;
GO


/* Order Item Refunds */

SELECT *
FROM EMCA.order_item_refunds
WHERE refund_created_at IS NULL
   OR order_item_id IS NULL
   OR order_id IS NULL
   OR refund_amount_usd IS NULL;
GO


/* Products */

SELECT *
FROM EMCA.products
WHERE created_at IS NULL
   OR product_name IS NULL
   OR LTRIM(RTRIM(product_name)) = '';
GO



/* ============================================================
   6. INVALID FINANCIAL VALUES
   ============================================================ */


/* Orders with negative revenue or cost */

SELECT *
FROM EMCA.orders
WHERE order_revenue_usd < 0
   OR order_cost_of_goods_usd < 0;
GO


/* Order items with negative price or cost */

SELECT *
FROM EMCA.order_items
WHERE item_price_usd < 0
   OR item_cost_of_goods_usd < 0;
GO


/* Refunds with zero or negative refund values */

SELECT *
FROM EMCA.order_item_refunds
WHERE refund_amount_usd <= 0;
GO


/* Orders where cost exceeds revenue */

SELECT *
FROM EMCA.orders
WHERE order_cost_of_goods_usd > order_revenue_usd;
GO


/* Order items where cost exceeds selling price */

SELECT *
FROM EMCA.order_items
WHERE item_cost_of_goods_usd > item_price_usd;
GO



/* ============================================================
   7. ORDER ITEM COUNT VALIDATION
   ============================================================ */


/* Orders with zero or negative items purchased */

SELECT *
FROM EMCA.orders
WHERE items_purchased <= 0;
GO


/* Compare recorded items_purchased with actual order-item rows */

SELECT
    o.order_id,
    o.items_purchased AS recorded_items_purchased,
    COUNT(oi.order_item_id) AS actual_item_count
FROM EMCA.orders AS o
LEFT JOIN EMCA.order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    o.items_purchased
HAVING o.items_purchased <> COUNT(oi.order_item_id);
GO



/* ============================================================
   8. ORDER-LEVEL FINANCIAL RECONCILIATION
   ============================================================ */


/* Compare order revenue with the sum of item prices */

SELECT
    o.order_id,
    o.order_revenue_usd,
    SUM(oi.item_price_usd) AS calculated_item_revenue,
    o.order_revenue_usd - SUM(oi.item_price_usd) AS revenue_difference
FROM EMCA.orders AS o
JOIN EMCA.order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    o.order_revenue_usd
HAVING ABS(
    o.order_revenue_usd - SUM(oi.item_price_usd)
) > 0.01;
GO


/* Compare order cost with the sum of item costs */

SELECT
    o.order_id,
    o.order_cost_of_goods_usd,
    SUM(oi.item_cost_of_goods_usd) AS calculated_item_cost,
    o.order_cost_of_goods_usd - SUM(oi.item_cost_of_goods_usd) AS cost_difference
FROM EMCA.orders AS o
JOIN EMCA.order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    o.order_cost_of_goods_usd
HAVING ABS(
    o.order_cost_of_goods_usd - SUM(oi.item_cost_of_goods_usd)
) > 0.01;
GO



/* ============================================================
   9. REFUND CONSISTENCY
   ============================================================ */


/* Refund amount greater than the original item selling price */

SELECT
    r.order_item_refund_id,
    r.order_item_id,
    r.refund_amount_usd,
    oi.item_price_usd
FROM EMCA.order_item_refunds AS r
JOIN EMCA.order_items AS oi
    ON r.order_item_id = oi.order_item_id
WHERE r.refund_amount_usd > oi.item_price_usd;
GO


/* Check that each refund order_id matches the order_id
   associated with the refunded order item */

SELECT
    r.order_item_refund_id,
    r.order_item_id,
    r.order_id AS refund_order_id,
    oi.order_id AS item_order_id
FROM EMCA.order_item_refunds AS r
JOIN EMCA.order_items AS oi
    ON r.order_item_id = oi.order_item_id
WHERE r.order_id <> oi.order_id;
GO



/* ============================================================
   10. DUPLICATE BUSINESS RECORD CHECKS
   ============================================================ */


/* Potential duplicate pageviews based on
   session, timestamp and URL */

SELECT
    website_session_id,
    created_at,
    pageview_url,
    COUNT(*) AS duplicate_count
FROM EMCA.website_pageviews
GROUP BY
    website_session_id,
    created_at,
    pageview_url
HAVING COUNT(*) > 1;
GO


/* Potential duplicate order-item records based on
   order, product, timestamp and selling price */

SELECT
    order_id,
    product_id,
    created_at,
    item_price_usd,
    COUNT(*) AS duplicate_count
FROM EMCA.order_items
GROUP BY
    order_id,
    product_id,
    created_at,
    item_price_usd
HAVING COUNT(*) > 1;
GO



/* ============================================================
   VALIDATION RESULT

   Core structural, relationship, financial and reconciliation
   checks identified no issues in the tested areas.

   The dataset is suitable for subsequent logical, behavioural
   and business analysis.
   ============================================================ */