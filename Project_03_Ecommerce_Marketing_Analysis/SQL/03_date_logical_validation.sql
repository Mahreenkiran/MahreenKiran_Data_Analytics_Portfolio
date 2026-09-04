/* ============================================================
   PROJECT: E-Commerce Marketing, Conversion and Customer Journey Analysis
   DATABASE: EcommerceMarketingAnalysis
   SCHEMA: EMCA

   FILE: 03_date_logical_validation.sql

   PURPOSE:
   Validate chronological and behavioural consistency across
   website sessions, pageviews, orders, products and refunds.

   Checks include:
   - pageviews before session start
   - orders before session start
   - order items before order creation
   - refunds before purchase activity
   - products used before product creation
   - repeat-session logic
   - duplicate session timestamps
   - pageview sequencing
   - overall date coverage
   ============================================================ */


USE EcommerceMarketingAnalysis;
GO


/* ============================================================
   1. PAGEVIEWS BEFORE WEBSITE SESSION START
   ============================================================ */

SELECT
    wp.website_pageview_id,
    wp.website_session_id,
    ws.created_at AS session_created_at,
    wp.created_at AS pageview_created_at,
    wp.pageview_url
FROM EMCA.website_pageviews AS wp
JOIN EMCA.website_sessions AS ws
    ON wp.website_session_id = ws.website_session_id
WHERE wp.created_at < ws.created_at;
GO



/* ============================================================
   2. ORDERS BEFORE WEBSITE SESSION START
   ============================================================ */

SELECT
    o.order_id,
    o.website_session_id,
    ws.created_at AS session_created_at,
    o.created_at AS order_created_at
FROM EMCA.orders AS o
JOIN EMCA.website_sessions AS ws
    ON o.website_session_id = ws.website_session_id
WHERE o.created_at < ws.created_at;
GO



/* ============================================================
   3. ORDER ITEMS BEFORE ORDER CREATION
   ============================================================ */

SELECT
    oi.order_item_id,
    oi.order_id,
    o.created_at AS order_created_at,
    oi.created_at AS order_item_created_at
FROM EMCA.order_items AS oi
JOIN EMCA.orders AS o
    ON oi.order_id = o.order_id
WHERE oi.created_at < o.created_at;
GO



/* ============================================================
   4. REFUNDS BEFORE ORDER ITEM CREATION
   ============================================================ */

SELECT
    r.order_item_refund_id,
    r.order_item_id,
    oi.created_at AS order_item_created_at,
    r.refund_created_at
FROM EMCA.order_item_refunds AS r
JOIN EMCA.order_items AS oi
    ON r.order_item_id = oi.order_item_id
WHERE r.refund_created_at < oi.created_at;
GO



/* ============================================================
   5. REFUNDS BEFORE ORDER CREATION
   ============================================================ */

SELECT
    r.order_item_refund_id,
    r.order_id,
    o.created_at AS order_created_at,
    r.refund_created_at
FROM EMCA.order_item_refunds AS r
JOIN EMCA.orders AS o
    ON r.order_id = o.order_id
WHERE r.refund_created_at < o.created_at;
GO



/* ============================================================
   6. ORDERS LINKED TO PRODUCTS CREATED AFTER THE ORDER
   ============================================================ */

SELECT
    o.order_id,
    o.primary_product_id,
    o.created_at AS order_created_at,
    p.created_at AS product_created_at,
    p.product_name
FROM EMCA.orders AS o
JOIN EMCA.products AS p
    ON o.primary_product_id = p.product_id
WHERE p.created_at > o.created_at;
GO



/* ============================================================
   7. ORDER ITEMS LINKED TO PRODUCTS CREATED AFTER THE ITEM
   ============================================================ */

SELECT
    oi.order_item_id,
    oi.order_id,
    oi.product_id,
    oi.created_at AS order_item_created_at,
    p.created_at AS product_created_at,
    p.product_name
FROM EMCA.order_items AS oi
JOIN EMCA.products AS p
    ON oi.product_id = p.product_id
WHERE p.created_at > oi.created_at;
GO



/* ============================================================
   8. REPEAT SESSION FLAG VALIDATION
   ============================================================ */

/*
For each user, identify the chronological order of sessions.

Expected logic:
- first recorded session = is_repeat_session = 0
- later sessions = is_repeat_session = 1
*/

WITH SessionSequence AS
(
    SELECT
        website_session_id,
        user_id,
        created_at,
        is_repeat_session,
        ROW_NUMBER() OVER
        (
            PARTITION BY user_id
            ORDER BY created_at, website_session_id
        ) AS session_number
    FROM EMCA.website_sessions
)
SELECT
    website_session_id,
    user_id,
    created_at,
    is_repeat_session,
    session_number
FROM SessionSequence
WHERE
       (session_number = 1 AND is_repeat_session <> 0)
    OR (session_number > 1 AND is_repeat_session <> 1);
GO



/* ============================================================
   9. USERS WITH MULTIPLE SESSIONS AT THE SAME TIMESTAMP
   ============================================================ */

SELECT
    user_id,
    created_at,
    COUNT(*) AS session_count
FROM EMCA.website_sessions
GROUP BY
    user_id,
    created_at
HAVING COUNT(*) > 1;
GO



/* ============================================================
   10. PAGEVIEW SEQUENCE VALIDATION
   ============================================================ */

/*
Compare each pageview timestamp with the previous pageview
within the same website session.
*/

WITH PageviewSequence AS
(
    SELECT
        website_pageview_id,
        website_session_id,
        created_at,
        pageview_url,

        LAG(created_at) OVER
        (
            PARTITION BY website_session_id
            ORDER BY created_at, website_pageview_id
        ) AS previous_pageview_at

    FROM EMCA.website_pageviews
)
SELECT
    website_pageview_id,
    website_session_id,
    previous_pageview_at,
    created_at AS current_pageview_at,
    pageview_url
FROM PageviewSequence
WHERE created_at < previous_pageview_at;
GO



/* ============================================================
   11. SESSION DATE RANGE
   ============================================================ */

SELECT
    MIN(created_at) AS earliest_session,
    MAX(created_at) AS latest_session
FROM EMCA.website_sessions;
GO



/* ============================================================
   12. PAGEVIEW DATE RANGE
   ============================================================ */

SELECT
    MIN(created_at) AS earliest_pageview,
    MAX(created_at) AS latest_pageview
FROM EMCA.website_pageviews;
GO



/* ============================================================
   13. ORDER DATE RANGE
   ============================================================ */

SELECT
    MIN(created_at) AS earliest_order,
    MAX(created_at) AS latest_order
FROM EMCA.orders;
GO



/* ============================================================
   14. ORDER ITEM DATE RANGE
   ============================================================ */

SELECT
    MIN(created_at) AS earliest_order_item,
    MAX(created_at) AS latest_order_item
FROM EMCA.order_items;
GO



/* ============================================================
   15. REFUND DATE RANGE
   ============================================================ */

SELECT
    MIN(refund_created_at) AS earliest_refund,
    MAX(refund_created_at) AS latest_refund
FROM EMCA.order_item_refunds;
GO



/* ============================================================
   16. PRODUCT CREATION DATE RANGE
   ============================================================ */

SELECT
    MIN(created_at) AS earliest_product_created,
    MAX(created_at) AS latest_product_created
FROM EMCA.products;
GO



/* ============================================================
   END OF DATE AND LOGICAL VALIDATION
   ============================================================ */