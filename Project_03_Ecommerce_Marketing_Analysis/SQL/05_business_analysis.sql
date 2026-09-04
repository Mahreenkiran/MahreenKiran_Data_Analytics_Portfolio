/*==============================================================
  PROJECT: E-Commerce Marketing, Conversion and Customer Journey
  DATABASE: EcommerceMarketingAnalysis
  FILE: 05_business_analysis.sql

  PURPOSE:
  Analyse website traffic, marketing performance, customer
  behaviour, conversion, orders, revenue, refunds, products
  and the customer journey.

  The analysis includes:
  - website and marketing performance
  - device and campaign performance
  - landing and exit behaviour
  - conversion engagement
  - repeat-user behaviour
  - order and refund performance
  - product performance
  - month-on-month growth
  - rolling performance
  - conversion funnel analysis
  - performance ranking
==============================================================*/

USE EcommerceMarketingAnalysis;
GO


/*==============================================================
  1. MONTHLY WEBSITE PERFORMANCE
==============================================================*/

WITH MonthlySessions AS
(
    SELECT
        session_year_month,
        COUNT(website_session_id) AS total_sessions,
        SUM(CAST(converted_session_flag AS INT)) AS converted_sessions
    FROM EMCA.website_sessions
    GROUP BY session_year_month
),
MonthlyOrders AS
(
    SELECT
        order_year_month,
        COUNT(order_id) AS total_orders,
        SUM(order_revenue_usd) AS gross_revenue_usd,
        SUM(net_revenue_usd) AS net_revenue_usd
    FROM EMCA.orders
    GROUP BY order_year_month
)

SELECT
    ms.session_year_month,
    ms.total_sessions,

    COALESCE(mo.total_orders, 0) AS total_orders,

    ROUND(
        ms.converted_sessions * 100.0 /
        NULLIF(ms.total_sessions, 0),
        2
    ) AS conversion_rate_pct,

    COALESCE(mo.gross_revenue_usd, 0) AS gross_revenue_usd,
    COALESCE(mo.net_revenue_usd, 0) AS net_revenue_usd

FROM MonthlySessions AS ms

LEFT JOIN MonthlyOrders AS mo
    ON ms.session_year_month = mo.order_year_month

ORDER BY
    ms.session_year_month;
GO



/*==============================================================
  2. MARKETING CHANNEL PERFORMANCE
==============================================================*/

SELECT
    ws.marketing_channel,

    COUNT(ws.website_session_id) AS total_sessions,

    SUM(CAST(ws.converted_session_flag AS INT))
        AS converted_sessions,

    ROUND(
        SUM(CAST(ws.converted_session_flag AS INT)) * 100.0 /
        NULLIF(COUNT(ws.website_session_id), 0),
        2
    ) AS conversion_rate_pct,

    COUNT(o.order_id) AS total_orders,

    ROUND(
        SUM(COALESCE(o.net_revenue_usd, 0)),
        2
    ) AS net_revenue_usd

FROM EMCA.website_sessions AS ws

LEFT JOIN EMCA.orders AS o
    ON ws.website_session_id = o.website_session_id

GROUP BY
    ws.marketing_channel

ORDER BY
    net_revenue_usd DESC;
GO



/*==============================================================
  3. DEVICE PERFORMANCE
==============================================================*/

SELECT
    ws.device_type,

    COUNT(ws.website_session_id) AS total_sessions,

    COUNT(o.order_id) AS total_orders,

    ROUND(
        SUM(CAST(ws.converted_session_flag AS INT)) * 100.0 /
        NULLIF(COUNT(ws.website_session_id), 0),
        2
    ) AS conversion_rate_pct,

    ROUND(
        SUM(COALESCE(o.net_revenue_usd, 0)),
        2
    ) AS net_revenue_usd

FROM EMCA.website_sessions AS ws

LEFT JOIN EMCA.orders AS o
    ON ws.website_session_id = o.website_session_id

GROUP BY
    ws.device_type

ORDER BY
    net_revenue_usd DESC;
GO



/*==============================================================
  4. CAMPAIGN PERFORMANCE
==============================================================*/

SELECT
    COALESCE(ws.utm_campaign, 'No Campaign') AS campaign,

    COUNT(ws.website_session_id) AS total_sessions,

    COUNT(o.order_id) AS total_orders,

    ROUND(
        SUM(CAST(ws.converted_session_flag AS INT)) * 100.0 /
        NULLIF(COUNT(ws.website_session_id), 0),
        2
    ) AS conversion_rate_pct,

    ROUND(
        SUM(COALESCE(o.net_revenue_usd, 0)),
        2
    ) AS net_revenue_usd

FROM EMCA.website_sessions AS ws

LEFT JOIN EMCA.orders AS o
    ON ws.website_session_id = o.website_session_id

GROUP BY
    COALESCE(ws.utm_campaign, 'No Campaign')

ORDER BY
    net_revenue_usd DESC;
GO



/*==============================================================
  5. LANDING PAGE PERFORMANCE
==============================================================*/

SELECT
    landing_page,

    COUNT(*) AS total_sessions,

    SUM(CAST(converted_session_flag AS INT))
        AS converted_sessions,

    ROUND(
        SUM(CAST(converted_session_flag AS INT)) * 100.0 /
        NULLIF(COUNT(*), 0),
        2
    ) AS conversion_rate_pct

FROM EMCA.website_sessions

GROUP BY
    landing_page

ORDER BY
    total_sessions DESC;
GO



/*==============================================================
  6. EXIT PAGE ANALYSIS
==============================================================*/

SELECT
    exit_page,

    COUNT(*) AS non_converted_exits

FROM EMCA.website_sessions

WHERE converted_session_flag = 0

GROUP BY
    exit_page

ORDER BY
    non_converted_exits DESC;
GO



/*==============================================================
  7. SESSION DURATION VS CONVERSION
==============================================================*/

SELECT
    converted_session_flag,

    COUNT(*) AS total_sessions,

    ROUND(
        AVG(CAST(session_duration_seconds AS DECIMAL(10,2))),
        2
    ) AS avg_session_duration_seconds,

    ROUND(
        AVG(CAST(session_duration_seconds AS DECIMAL(10,2))) / 60.0,
        2
    ) AS avg_session_duration_minutes

FROM EMCA.website_sessions

GROUP BY
    converted_session_flag;
GO



/*==============================================================
  8. TIME TO ORDER
==============================================================*/

SELECT
    COUNT(*) AS total_orders,

    ROUND(
        AVG(CAST(seconds_to_order AS DECIMAL(10,2))),
        2
    ) AS avg_seconds_to_order,

    ROUND(
        AVG(CAST(seconds_to_order AS DECIMAL(10,2))) / 60.0,
        2
    ) AS avg_minutes_to_order

FROM EMCA.orders;
GO



/*==============================================================
  9. MEDIAN TIME TO ORDER
==============================================================*/

SELECT DISTINCT

    PERCENTILE_CONT(0.50)
    WITHIN GROUP
    (
        ORDER BY seconds_to_order
    )
    OVER () AS median_seconds_to_order

FROM EMCA.orders;
GO



/*==============================================================
  10. TIME TO ORDER BY MARKETING CHANNEL
==============================================================*/

SELECT
    ws.marketing_channel,

    COUNT(o.order_id) AS total_orders,

    ROUND(
        AVG(CAST(o.seconds_to_order AS DECIMAL(10,2))),
        2
    ) AS avg_seconds_to_order,

    ROUND(
        AVG(CAST(o.seconds_to_order AS DECIMAL(10,2))) / 60.0,
        2
    ) AS avg_minutes_to_order

FROM EMCA.orders AS o

INNER JOIN EMCA.website_sessions AS ws
    ON o.website_session_id = ws.website_session_id

GROUP BY
    ws.marketing_channel

ORDER BY
    avg_seconds_to_order;
GO



/*==============================================================
  11. REPEAT USER PERFORMANCE
==============================================================*/

SELECT
    repeat_user,

    COUNT(*) AS total_sessions,

    SUM(CAST(converted_session_flag AS INT))
        AS converted_sessions,

    ROUND(
        SUM(CAST(converted_session_flag AS INT)) * 100.0 /
        NULLIF(COUNT(*), 0),
        2
    ) AS conversion_rate_pct

FROM EMCA.website_sessions

GROUP BY
    repeat_user;
GO



/*==============================================================
  12. SESSION SEQUENCE PERFORMANCE
==============================================================*/

SELECT

    CASE
        WHEN session_sequence = 1 THEN '1st Session'
        WHEN session_sequence = 2 THEN '2nd Session'
        WHEN session_sequence = 3 THEN '3rd Session'
        ELSE '4th+ Session'
    END AS session_stage,

    COUNT(*) AS total_sessions,

    SUM(CAST(converted_session_flag AS INT))
        AS converted_sessions,

    ROUND(
        SUM(CAST(converted_session_flag AS INT)) * 100.0 /
        NULLIF(COUNT(*), 0),
        2
    ) AS conversion_rate_pct

FROM EMCA.website_sessions

GROUP BY
    CASE
        WHEN session_sequence = 1 THEN '1st Session'
        WHEN session_sequence = 2 THEN '2nd Session'
        WHEN session_sequence = 3 THEN '3rd Session'
        ELSE '4th+ Session'
    END

ORDER BY
    conversion_rate_pct DESC;
GO



/*==============================================================
  13. ORDER VALUE BAND PERFORMANCE
==============================================================*/

SELECT
    order_value_band,

    COUNT(*) AS total_orders,

    ROUND(
        SUM(order_revenue_usd),
        2
    ) AS gross_revenue_usd,

    ROUND(
        SUM(net_revenue_usd),
        2
    ) AS net_revenue_usd,

    ROUND(
        AVG(order_revenue_usd),
        2
    ) AS avg_order_value_usd

FROM EMCA.orders

GROUP BY
    order_value_band

ORDER BY
    avg_order_value_usd;
GO



/*==============================================================
  14. MULTI-ITEM ORDER PERFORMANCE
==============================================================*/

SELECT
    multi_item_order,

    COUNT(*) AS total_orders,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_orders,

    ROUND(
        AVG(order_revenue_usd),
        2
    ) AS avg_order_revenue_usd,

    ROUND(
        AVG(gross_profit_usd),
        2
    ) AS avg_gross_profit_usd

FROM EMCA.orders

GROUP BY
    multi_item_order;
GO



/*==============================================================
  15. REFUND PERFORMANCE
==============================================================*/

SELECT
    COUNT(*) AS total_orders,

    SUM(CAST(refund_flag AS INT))
        AS refunded_orders,

    ROUND(
        SUM(CAST(refund_flag AS INT)) * 100.0 /
        NULLIF(COUNT(*), 0),
        2
    ) AS refunded_order_rate_pct,

    ROUND(
        SUM(total_refund_usd),
        2
    ) AS total_refund_usd,

    ROUND(
        SUM(net_revenue_usd),
        2
    ) AS net_revenue_usd

FROM EMCA.orders;
GO



/*==============================================================
  16. PRODUCT PERFORMANCE
==============================================================*/

SELECT
    p.product_id,
    p.product_name,

    COUNT(oi.order_item_id) AS units_sold,

    ROUND(
        SUM(oi.item_price_usd),
        2
    ) AS item_revenue_usd,

    ROUND(
        SUM(
            oi.item_price_usd -
            oi.item_cost_of_goods_usd
        ),
        2
    ) AS gross_profit_usd,

    COUNT(r.order_item_refund_id)
        AS refunded_items,

    ROUND(
        SUM(COALESCE(r.refund_amount_usd, 0)),
        2
    ) AS refund_amount_usd

FROM EMCA.products AS p

LEFT JOIN EMCA.order_items AS oi
    ON p.product_id = oi.product_id

LEFT JOIN EMCA.order_item_refunds AS r
    ON oi.order_item_id = r.order_item_id

GROUP BY
    p.product_id,
    p.product_name

ORDER BY
    item_revenue_usd DESC;
GO



/*==============================================================
  17. PRODUCT REVENUE RANKING
==============================================================*/

WITH ProductPerformance AS
(
    SELECT
        p.product_id,
        p.product_name,

        SUM(oi.item_price_usd)
            AS revenue_usd

    FROM EMCA.products AS p

    INNER JOIN EMCA.order_items AS oi
        ON p.product_id = oi.product_id

    GROUP BY
        p.product_id,
        p.product_name
)

SELECT
    product_id,
    product_name,
    revenue_usd,

    RANK() OVER
    (
        ORDER BY revenue_usd DESC
    ) AS revenue_rank

FROM ProductPerformance

ORDER BY
    revenue_rank;
GO



/*==============================================================
  18. MONTH-ON-MONTH REVENUE AND ORDER GROWTH
==============================================================*/

WITH MonthlyPerformance AS
(
    SELECT
        order_year_month,

        SUM(net_revenue_usd)
            AS net_revenue_usd,

        COUNT(order_id)
            AS total_orders

    FROM EMCA.orders

    GROUP BY
        order_year_month
),

PreviousMonth AS
(
    SELECT
        *,

        LAG(net_revenue_usd)
        OVER
        (
            ORDER BY order_year_month
        ) AS previous_month_revenue,

        LAG(total_orders)
        OVER
        (
            ORDER BY order_year_month
        ) AS previous_month_orders

    FROM MonthlyPerformance
)

SELECT
    order_year_month,

    net_revenue_usd,

    previous_month_revenue,

    ROUND(
        (
            net_revenue_usd -
            previous_month_revenue
        )
        * 100.0 /
        NULLIF(previous_month_revenue, 0),
        2
    ) AS revenue_mom_growth_pct,

    total_orders,

    previous_month_orders,

    ROUND(
        (
            total_orders -
            previous_month_orders
        )
        * 100.0 /
        NULLIF(previous_month_orders, 0),
        2
    ) AS orders_mom_growth_pct

FROM PreviousMonth

ORDER BY
    order_year_month;
GO



/*==============================================================
  19. THREE-MONTH ROLLING PERFORMANCE
==============================================================*/

WITH MonthlyPerformance AS
(
    SELECT
        ws.session_year_month,

        COUNT(ws.website_session_id)
            AS total_sessions,

        SUM(CAST(ws.converted_session_flag AS INT))
            AS converted_sessions,

        SUM(COALESCE(o.net_revenue_usd, 0))
            AS net_revenue_usd

    FROM EMCA.website_sessions AS ws

    LEFT JOIN EMCA.orders AS o
        ON ws.website_session_id =
           o.website_session_id

    GROUP BY
        ws.session_year_month
),

MonthlyMetrics AS
(
    SELECT
        *,

        converted_sessions * 100.0 /
        NULLIF(total_sessions, 0)
            AS conversion_rate_pct

    FROM MonthlyPerformance
)

SELECT
    session_year_month,

    ROUND(
        net_revenue_usd,
        2
    ) AS net_revenue_usd,

    ROUND(
        AVG(net_revenue_usd)
        OVER
        (
            ORDER BY session_year_month
            ROWS BETWEEN 2 PRECEDING
            AND CURRENT ROW
        ),
        2
    ) AS three_month_avg_revenue,

    ROUND(
        conversion_rate_pct,
        2
    ) AS conversion_rate_pct,

    ROUND(
        AVG(conversion_rate_pct)
        OVER
        (
            ORDER BY session_year_month
            ROWS BETWEEN 2 PRECEDING
            AND CURRENT ROW
        ),
        2
    ) AS three_month_avg_conversion_rate

FROM MonthlyMetrics

ORDER BY
    session_year_month;
GO



/*==============================================================
  20. CUSTOMER JOURNEY FUNNEL
==============================================================*/

WITH SessionJourney AS
(
    SELECT
        ws.website_session_id,

        MAX(
            CASE
                WHEN wp.pageview_url = '/products'
                THEN 1 ELSE 0
            END
        ) AS reached_products,

        MAX(
            CASE
                WHEN wp.pageview_url = '/cart'
                THEN 1 ELSE 0
            END
        ) AS reached_cart,

        MAX(
            CASE
                WHEN wp.pageview_url = '/shipping'
                THEN 1 ELSE 0
            END
        ) AS reached_shipping,

        MAX(
            CASE
                WHEN wp.pageview_url LIKE '/billing%'
                THEN 1 ELSE 0
            END
        ) AS reached_billing,

        MAX(
            CASE
                WHEN wp.pageview_url =
                     '/thank-you-for-your-order'
                THEN 1 ELSE 0
            END
        ) AS reached_order

    FROM EMCA.website_sessions AS ws

    LEFT JOIN EMCA.website_pageviews AS wp
        ON ws.website_session_id =
           wp.website_session_id

    GROUP BY
        ws.website_session_id
)

SELECT
    COUNT(*) AS total_sessions,

    SUM(reached_products)
        AS product_sessions,

    SUM(reached_cart)
        AS cart_sessions,

    SUM(reached_shipping)
        AS shipping_sessions,

    SUM(reached_billing)
        AS billing_sessions,

    SUM(reached_order)
        AS order_sessions

FROM SessionJourney;
GO



/*==============================================================
  21. FUNNEL BY DEVICE
==============================================================*/

WITH SessionJourney AS
(
    SELECT
        ws.website_session_id,
        ws.device_type,

        MAX(
            CASE
                WHEN wp.pageview_url = '/products'
                THEN 1 ELSE 0
            END
        ) AS product_stage,

        MAX(
            CASE
                WHEN wp.pageview_url = '/cart'
                THEN 1 ELSE 0
            END
        ) AS cart_stage,

        MAX(
            CASE
                WHEN wp.pageview_url = '/shipping'
                THEN 1 ELSE 0
            END
        ) AS shipping_stage,

        MAX(
            CASE
                WHEN wp.pageview_url LIKE '/billing%'
                THEN 1 ELSE 0
            END
        ) AS billing_stage,

        MAX(
            CASE
                WHEN wp.pageview_url =
                     '/thank-you-for-your-order'
                THEN 1 ELSE 0
            END
        ) AS order_stage

    FROM EMCA.website_sessions AS ws

    LEFT JOIN EMCA.website_pageviews AS wp
        ON ws.website_session_id =
           wp.website_session_id

    GROUP BY
        ws.website_session_id,
        ws.device_type
)

SELECT
    device_type,

    COUNT(*) AS total_sessions,

    SUM(product_stage)
        AS product_sessions,

    SUM(cart_stage)
        AS cart_sessions,

    SUM(shipping_stage)
        AS shipping_sessions,

    SUM(billing_stage)
        AS billing_sessions,

    SUM(order_stage)
        AS order_sessions,

    ROUND(
        SUM(order_stage) * 100.0 /
        NULLIF(COUNT(*), 0),
        2
    ) AS overall_conversion_pct

FROM SessionJourney

GROUP BY
    device_type;
GO



/*==============================================================
  22. FUNNEL BY MARKETING CHANNEL
==============================================================*/

WITH SessionJourney AS
(
    SELECT
        ws.website_session_id,
        ws.marketing_channel,

        MAX(
            CASE
                WHEN wp.pageview_url = '/products'
                THEN 1 ELSE 0
            END
        ) AS product_stage,

        MAX(
            CASE
                WHEN wp.pageview_url = '/cart'
                THEN 1 ELSE 0
            END
        ) AS cart_stage,

        MAX(
            CASE
                WHEN wp.pageview_url = '/shipping'
                THEN 1 ELSE 0
            END
        ) AS shipping_stage,

        MAX(
            CASE
                WHEN wp.pageview_url LIKE '/billing%'
                THEN 1 ELSE 0
            END
        ) AS billing_stage,

        MAX(
            CASE
                WHEN wp.pageview_url =
                     '/thank-you-for-your-order'
                THEN 1 ELSE 0
            END
        ) AS order_stage

    FROM EMCA.website_sessions AS ws

    LEFT JOIN EMCA.website_pageviews AS wp
        ON ws.website_session_id =
           wp.website_session_id

    GROUP BY
        ws.website_session_id,
        ws.marketing_channel
)

SELECT
    marketing_channel,

    COUNT(*) AS total_sessions,

    SUM(product_stage)
        AS product_sessions,

    SUM(cart_stage)
        AS cart_sessions,

    SUM(shipping_stage)
        AS shipping_sessions,

    SUM(billing_stage)
        AS billing_sessions,

    SUM(order_stage)
        AS order_sessions,

    ROUND(
        SUM(order_stage) * 100.0 /
        NULLIF(COUNT(*), 0),
        2
    ) AS conversion_rate_pct

FROM SessionJourney

GROUP BY
    marketing_channel

ORDER BY
    conversion_rate_pct DESC;
GO



/*==============================================================
  23. MONTHLY PERFORMANCE RANKING
==============================================================*/

WITH MonthlyPerformance AS
(
    SELECT
        ws.session_year_month,

        COUNT(ws.website_session_id)
            AS total_sessions,

        SUM(CAST(ws.converted_session_flag AS INT))
            AS converted_sessions,

        SUM(COALESCE(o.net_revenue_usd, 0))
            AS net_revenue_usd

    FROM EMCA.website_sessions AS ws

    LEFT JOIN EMCA.orders AS o
        ON ws.website_session_id =
           o.website_session_id

    GROUP BY
        ws.session_year_month
),

MonthlyMetrics AS
(
    SELECT
        *,

        converted_sessions * 100.0 /
        NULLIF(total_sessions, 0)
            AS conversion_rate_pct

    FROM MonthlyPerformance
)

SELECT
    session_year_month,

    ROUND(
        net_revenue_usd,
        2
    ) AS net_revenue_usd,

    ROUND(
        conversion_rate_pct,
        2
    ) AS conversion_rate_pct,

    DENSE_RANK() OVER
    (
        ORDER BY net_revenue_usd DESC
    ) AS revenue_rank,

    DENSE_RANK() OVER
    (
        ORDER BY conversion_rate_pct DESC
    ) AS conversion_rank

FROM MonthlyMetrics

ORDER BY
    revenue_rank;
GO


/*==============================================================
  END OF BUSINESS ANALYSIS

  The analysis covers:
  - traffic and conversion trends
  - marketing and campaign effectiveness
  - device performance
  - landing and exit behaviour
  - session engagement
  - purchase timing
  - repeat-customer behaviour
  - order-value and basket behaviour
  - refunds and product performance
  - revenue growth and rolling trends
  - customer journey funnel performance
  - monthly performance ranking
==============================================================*/
