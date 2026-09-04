/* ============================================================
   PROJECT: E-Commerce Marketing, Conversion and Customer Journey Analysis
   DATABASE: Ecommerce_Marketing_Conversion_Analysis
   SCHEMA: EMCA

   FILE: 01_primary_foreign_key_constraints.sql

   PURPOSE:
   Define the primary and foreign key relationships between
   website sessions, pageviews, orders, order items, products
   and refunds.

   These constraints establish the relational structure used
   throughout the subsequent data-quality and business analysis.
   ============================================================ */


USE Ecommerce_Marketing_Conversion_Analysis;
GO


/* ============================================================
   1. PRIMARY KEYS
   ============================================================ */


/* Website Sessions
   One row represents one website session.
*/
ALTER TABLE EMCA.website_sessions
ADD CONSTRAINT PK_website_sessions
PRIMARY KEY (website_session_id);
GO


/* Website Pageviews
   One row represents one page viewed during a website session.
*/
ALTER TABLE EMCA.website_pageviews
ADD CONSTRAINT PK_website_pageviews
PRIMARY KEY (website_pageview_id);
GO


/* Orders
   One row represents one completed order.
*/
ALTER TABLE EMCA.orders
ADD CONSTRAINT PK_orders
PRIMARY KEY (order_id);
GO


/* Order Items
   One row represents one product item within an order.
*/
ALTER TABLE EMCA.order_items
ADD CONSTRAINT PK_order_items
PRIMARY KEY (order_item_id);
GO


/* Order Item Refunds
   One row represents one refunded order item.
*/
ALTER TABLE EMCA.order_item_refunds
ADD CONSTRAINT PK_order_item_refunds
PRIMARY KEY (order_item_refund_id);
GO


/* Products
   One row represents one product.
*/
ALTER TABLE EMCA.products
ADD CONSTRAINT PK_products
PRIMARY KEY (product_id);
GO



/* ============================================================
   2. FOREIGN KEY RELATIONSHIPS
   ============================================================ */


/* ------------------------------------------------------------
   Website Sessions -> Website Pageviews

   One website session can contain multiple pageviews.
   ------------------------------------------------------------ */

ALTER TABLE EMCA.website_pageviews
ADD CONSTRAINT FK_website_pageviews_sessions
FOREIGN KEY (website_session_id)
REFERENCES EMCA.website_sessions(website_session_id);
GO


/* ------------------------------------------------------------
   Website Sessions -> Orders

   A website session may result in an order.
   Each recorded order links back to the session in which
   the purchase occurred.
   ------------------------------------------------------------ */

ALTER TABLE EMCA.orders
ADD CONSTRAINT FK_orders_sessions
FOREIGN KEY (website_session_id)
REFERENCES EMCA.website_sessions(website_session_id);
GO


/* ------------------------------------------------------------
   Products -> Orders

   primary_product_id identifies the main product associated
   with the order.
   ------------------------------------------------------------ */

ALTER TABLE EMCA.orders
ADD CONSTRAINT FK_orders_primary_product
FOREIGN KEY (primary_product_id)
REFERENCES EMCA.products(product_id);
GO


/* ------------------------------------------------------------
   Orders -> Order Items

   One order can contain one or more individual product items.
   ------------------------------------------------------------ */

ALTER TABLE EMCA.order_items
ADD CONSTRAINT FK_order_items_orders
FOREIGN KEY (order_id)
REFERENCES EMCA.orders(order_id);
GO


/* ------------------------------------------------------------
   Products -> Order Items

   Each individual order item refers to a valid product.
   ------------------------------------------------------------ */

ALTER TABLE EMCA.order_items
ADD CONSTRAINT FK_order_items_products
FOREIGN KEY (product_id)
REFERENCES EMCA.products(product_id);
GO


/* ------------------------------------------------------------
   Order Items -> Order Item Refunds

   Each refund record refers to the specific order item
   that was refunded.
   ------------------------------------------------------------ */

ALTER TABLE EMCA.order_item_refunds
ADD CONSTRAINT FK_refunds_order_items
FOREIGN KEY (order_item_id)
REFERENCES EMCA.order_items(order_item_id);
GO


/* ------------------------------------------------------------
   Orders -> Order Item Refunds

   Each refund record also identifies the order associated
   with the refunded item.
   ------------------------------------------------------------ */

ALTER TABLE EMCA.order_item_refunds
ADD CONSTRAINT FK_refunds_orders
FOREIGN KEY (order_id)
REFERENCES EMCA.orders(order_id);
GO



/* ============================================================
   3. RELATIONSHIP DESIGN NOTE
   ============================================================ */

/*
user_id appears in both website_sessions and orders.

A foreign key was NOT created between these fields because
user_id is not unique in website_sessions.

A single user can generate multiple website sessions and may
place multiple orders.

user_id will therefore be used analytically for repeat-user,
repeat-session and customer-journey analysis rather than as
a direct primary-key / foreign-key relationship.
*/



/* ============================================================
   4. FINAL RELATIONAL MODEL
   ============================================================ */

/*

website_sessions
      |
      |----< website_pageviews
      |
      |----< orders
                |
                |---- primary_product_id ----> products
                |
                |----< order_items >---------- products
                |          |
                |          |----< order_item_refunds
                |
                |----< order_item_refunds


Core relationships:

website_sessions.website_session_id
    -> website_pageviews.website_session_id

website_sessions.website_session_id
    -> orders.website_session_id

products.product_id
    -> orders.primary_product_id

orders.order_id
    -> order_items.order_id

products.product_id
    -> order_items.product_id

order_items.order_item_id
    -> order_item_refunds.order_item_id

orders.order_id
    -> order_item_refunds.order_id

*/