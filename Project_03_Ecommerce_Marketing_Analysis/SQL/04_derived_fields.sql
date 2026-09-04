/*==============================================================
  PROJECT: E-Commerce Marketing, Conversion and Customer Journey
  DATABASE: EcommerceMarketingAnalysis
  STAGE 4: ROW-LEVEL DERIVED FIELDS
==============================================================*/

USE EcommerceMarketingAnalysis;
GO


/*==============================================================
  1–3. SESSION DATE FIELDS
==============================================================*/

IF COL_LENGTH('EMCA.website_sessions', 'session_year') IS NULL
    ALTER TABLE EMCA.website_sessions ADD session_year INT;
GO

IF COL_LENGTH('EMCA.website_sessions', 'session_month') IS NULL
    ALTER TABLE EMCA.website_sessions ADD session_month VARCHAR(20);
GO

IF COL_LENGTH('EMCA.website_sessions', 'session_year_month') IS NULL
    ALTER TABLE EMCA.website_sessions ADD session_year_month CHAR(7);
GO

UPDATE EMCA.website_sessions
SET
    session_year = YEAR(created_at),
    session_month = DATENAME(MONTH, created_at),
    session_year_month = CONVERT(CHAR(7), created_at, 120);
GO


/*==============================================================
  4–6. ORDER DATE FIELDS
==============================================================*/

IF COL_LENGTH('EMCA.orders', 'order_year') IS NULL
    ALTER TABLE EMCA.orders ADD order_year INT;
GO

IF COL_LENGTH('EMCA.orders', 'order_month') IS NULL
    ALTER TABLE EMCA.orders ADD order_month VARCHAR(20);
GO

IF COL_LENGTH('EMCA.orders', 'order_year_month') IS NULL
    ALTER TABLE EMCA.orders ADD order_year_month CHAR(7);
GO

UPDATE EMCA.orders
SET
    order_year = YEAR(created_at),
    order_month = DATENAME(MONTH, created_at),
    order_year_month = CONVERT(CHAR(7), created_at, 120);
GO


/*==============================================================
  7. GROSS PROFIT
==============================================================*/

IF COL_LENGTH('EMCA.orders', 'gross_profit_usd') IS NULL
    ALTER TABLE EMCA.orders ADD gross_profit_usd DECIMAL(10,2);
GO

UPDATE EMCA.orders
SET gross_profit_usd =
    order_revenue_usd - order_cost_of_goods_usd;
GO


/*==============================================================
  8. GROSS MARGIN PERCENTAGE
==============================================================*/

IF COL_LENGTH('EMCA.orders', 'gross_margin_percentage') IS NULL
    ALTER TABLE EMCA.orders ADD gross_margin_percentage DECIMAL(10,2);
GO

UPDATE EMCA.orders
SET gross_margin_percentage =
    ROUND(
        (gross_profit_usd / NULLIF(order_revenue_usd, 0)) * 100,
        2
    );
GO


/*==============================================================
  9. CONVERTED SESSION FLAG
==============================================================*/

IF COL_LENGTH('EMCA.website_sessions', 'converted_session_flag') IS NULL
    ALTER TABLE EMCA.website_sessions ADD converted_session_flag BIT;
GO

UPDATE ws
SET converted_session_flag =
    CASE
        WHEN EXISTS
        (
            SELECT 1
            FROM EMCA.orders AS o
            WHERE o.website_session_id = ws.website_session_id
        )
        THEN 1
        ELSE 0
    END
FROM EMCA.website_sessions AS ws;
GO


/*==============================================================
  10. PAGES VIEWED PER SESSION
==============================================================*/

IF COL_LENGTH('EMCA.website_sessions', 'pages_viewed') IS NULL
    ALTER TABLE EMCA.website_sessions ADD pages_viewed INT;
GO

WITH PageCounts AS
(
    SELECT
        website_session_id,
        COUNT(website_pageview_id) AS pages_viewed
    FROM EMCA.website_pageviews
    GROUP BY website_session_id
)
UPDATE ws
SET pages_viewed = COALESCE(pc.pages_viewed, 0)
FROM EMCA.website_sessions AS ws
LEFT JOIN PageCounts AS pc
    ON ws.website_session_id = pc.website_session_id;
GO


/*==============================================================
  11. SESSION DURATION IN SECONDS
==============================================================*/

IF COL_LENGTH('EMCA.website_sessions', 'session_duration_seconds') IS NULL
    ALTER TABLE EMCA.website_sessions ADD session_duration_seconds INT;
GO

WITH SessionDuration AS
(
    SELECT
        website_session_id,
        DATEDIFF(
            SECOND,
            MIN(created_at),
            MAX(created_at)
        ) AS session_duration_seconds
    FROM EMCA.website_pageviews
    GROUP BY website_session_id
)
UPDATE ws
SET session_duration_seconds =
    COALESCE(sd.session_duration_seconds, 0)
FROM EMCA.website_sessions AS ws
LEFT JOIN SessionDuration AS sd
    ON ws.website_session_id = sd.website_session_id;
GO


/*==============================================================
  12. LANDING PAGE
==============================================================*/

IF COL_LENGTH('EMCA.website_sessions', 'landing_page') IS NULL
    ALTER TABLE EMCA.website_sessions ADD landing_page VARCHAR(255);
GO

WITH LandingPageCTE AS
(
    SELECT
        website_session_id,
        pageview_url,
        ROW_NUMBER() OVER
        (
            PARTITION BY website_session_id
            ORDER BY created_at, website_pageview_id
        ) AS rownumber
    FROM EMCA.website_pageviews
)
UPDATE ws
SET landing_page = lp.pageview_url
FROM EMCA.website_sessions AS ws
INNER JOIN LandingPageCTE AS lp
    ON ws.website_session_id = lp.website_session_id
WHERE lp.rownumber = 1;
GO


/*==============================================================
  13. EXIT PAGE
==============================================================*/

IF COL_LENGTH('EMCA.website_sessions', 'exit_page') IS NULL
    ALTER TABLE EMCA.website_sessions ADD exit_page VARCHAR(255);
GO

WITH ExitPageCTE AS
(
    SELECT
        website_session_id,
        pageview_url,
        ROW_NUMBER() OVER
        (
            PARTITION BY website_session_id
            ORDER BY created_at DESC, website_pageview_id DESC
        ) AS rownumber
    FROM EMCA.website_pageviews
)
UPDATE ws
SET exit_page = ep.pageview_url
FROM EMCA.website_sessions AS ws
INNER JOIN ExitPageCTE AS ep
    ON ws.website_session_id = ep.website_session_id
WHERE ep.rownumber = 1;
GO


/*==============================================================
  14. TIME TO ORDER
  Stored in orders because the metric only exists when an order exists.
==============================================================*/

IF COL_LENGTH('EMCA.orders', 'seconds_to_order') IS NULL
    ALTER TABLE EMCA.orders ADD seconds_to_order INT;
GO

IF COL_LENGTH('EMCA.orders', 'minutes_to_order') IS NULL
    ALTER TABLE EMCA.orders ADD minutes_to_order INT;
GO

UPDATE o
SET
    seconds_to_order =
        DATEDIFF(SECOND, ws.created_at, o.created_at),

    minutes_to_order =
        DATEDIFF(MINUTE, ws.created_at, o.created_at)
FROM EMCA.orders AS o
INNER JOIN EMCA.website_sessions AS ws
    ON o.website_session_id = ws.website_session_id;
GO


/*==============================================================
  15. REFUND FLAG
==============================================================*/

IF COL_LENGTH('EMCA.orders', 'refund_flag') IS NULL
    ALTER TABLE EMCA.orders ADD refund_flag BIT;
GO

UPDATE o
SET refund_flag =
    CASE
        WHEN EXISTS
        (
            SELECT 1
            FROM EMCA.order_item_refunds AS r
            WHERE r.order_id = o.order_id
        )
        THEN 1
        ELSE 0
    END
FROM EMCA.orders AS o;
GO


/*==============================================================
  16. TOTAL REFUND PER ORDER
==============================================================*/

IF COL_LENGTH('EMCA.orders', 'total_refund_usd') IS NULL
    ALTER TABLE EMCA.orders ADD total_refund_usd DECIMAL(10,2);
GO

WITH RefundTotals AS
(
    SELECT
        order_id,
        SUM(refund_amount_usd) AS total_refund_usd
    FROM EMCA.order_item_refunds
    GROUP BY order_id
)
UPDATE o
SET total_refund_usd =
    COALESCE(r.total_refund_usd, 0)
FROM EMCA.orders AS o
LEFT JOIN RefundTotals AS r
    ON o.order_id = r.order_id;
GO


/*==============================================================
  17. NET REVENUE
==============================================================*/

IF COL_LENGTH('EMCA.orders', 'net_revenue_usd') IS NULL
    ALTER TABLE EMCA.orders ADD net_revenue_usd DECIMAL(10,2);
GO

UPDATE EMCA.orders
SET net_revenue_usd =
    order_revenue_usd - COALESCE(total_refund_usd, 0);
GO


/*==============================================================
  18. MULTI-ITEM ORDER FLAG
==============================================================*/

IF COL_LENGTH('EMCA.orders', 'multi_item_order') IS NULL
    ALTER TABLE EMCA.orders ADD multi_item_order BIT;
GO

UPDATE EMCA.orders
SET multi_item_order =
    CASE
        WHEN items_purchased > 1 THEN 1
        ELSE 0
    END;
GO


/*==============================================================
  19. SESSION SEQUENCE PER USER
==============================================================*/

IF COL_LENGTH('EMCA.website_sessions', 'session_sequence') IS NULL
    ALTER TABLE EMCA.website_sessions ADD session_sequence INT;
GO

WITH SessionSequenceCTE AS
(
    SELECT
        website_session_id,
        ROW_NUMBER() OVER
        (
            PARTITION BY user_id
            ORDER BY created_at, website_session_id
        ) AS session_sequence
    FROM EMCA.website_sessions
)
UPDATE ws
SET session_sequence = ss.session_sequence
FROM EMCA.website_sessions AS ws
INNER JOIN SessionSequenceCTE AS ss
    ON ws.website_session_id = ss.website_session_id;
GO


/*==============================================================
  20. REPEAT USER FLAG
  1 = user has more than one session
==============================================================*/

IF COL_LENGTH('EMCA.website_sessions', 'repeat_user') IS NULL
    ALTER TABLE EMCA.website_sessions ADD repeat_user BIT;
GO

WITH UserSessionCount AS
(
    SELECT
        user_id,
        COUNT(*) AS session_count
    FROM EMCA.website_sessions
    GROUP BY user_id
)
UPDATE ws
SET repeat_user =
    CASE
        WHEN usc.session_count > 1 THEN 1
        ELSE 0
    END
FROM EMCA.website_sessions AS ws
INNER JOIN UserSessionCount AS usc
    ON ws.user_id = usc.user_id;
GO


/*==============================================================
  21. MARKETING CHANNEL
==============================================================*/

IF COL_LENGTH('EMCA.website_sessions', 'marketing_channel') IS NULL
    ALTER TABLE EMCA.website_sessions ADD marketing_channel VARCHAR(50);
GO

UPDATE EMCA.website_sessions
SET marketing_channel =
    CASE
        WHEN utm_source IN ('gsearch', 'bsearch')
            THEN 'Paid Search'

        WHEN utm_source = 'socialbook'
            THEN 'Paid Social'

        WHEN utm_source IS NULL
             AND http_referer IS NOT NULL
            THEN 'Organic Search'

        WHEN utm_source IS NULL
             AND http_referer IS NULL
            THEN 'Direct'

        ELSE 'Other'
    END;
GO


/*==============================================================
  22. ORDER VALUE BAND

  Distribution inspected before assigning thresholds:
  Minimum = 29.99
  25th percentile = 49.99
  Median = 49.99
  75th percentile = 59.99
  Maximum = 109.98

  49.99 is the dominant order value, so it is kept as its
  own "Standard" category instead of forcing quartile bands.
==============================================================*/

IF COL_LENGTH('EMCA.orders', 'order_value_band') IS NULL
    ALTER TABLE EMCA.orders ADD order_value_band VARCHAR(20);
GO

UPDATE EMCA.orders
SET order_value_band =
    CASE
        WHEN order_revenue_usd < 49.99
            THEN 'Low'

        WHEN order_revenue_usd = 49.99
            THEN 'Standard'

        WHEN order_revenue_usd < 80.00
            THEN 'Medium'

        ELSE 'High'
    END;
GO


/*==============================================================
  FINAL VALIDATION
==============================================================*/

SELECT TOP 20
    website_session_id,
    user_id,
    session_year,
    session_month,
    session_year_month,
    converted_session_flag,
    pages_viewed,
    session_duration_seconds,
    landing_page,
    exit_page,
    session_sequence,
    repeat_user,
    marketing_channel
FROM EMCA.website_sessions
ORDER BY website_session_id;
GO


SELECT TOP 20
    order_id,
    website_session_id,
    order_year,
    order_month,
    order_year_month,
    order_revenue_usd,
    gross_profit_usd,
    gross_margin_percentage,
    seconds_to_order,
    minutes_to_order,
    refund_flag,
    total_refund_usd,
    net_revenue_usd,
    items_purchased,
    multi_item_order,
    order_value_band
FROM EMCA.orders
ORDER BY order_id;
GO