/*
Project: AdventureWorks Sales and Customer Performance Analysis
File: 02_overall_sales_analysis.sql
Database: AdventureWorks2025
Platform: SQL Server

Purpose:
Analyse the company’s overall sales performance, monthly sales movement
and the distribution of orders across different order-value segments.

Note:
AdventureWorks is a fictional Microsoft sample database.
*/

USE AdventureWorks2025;
GO

-------------------------------------------------------------------
                    -- Question 1: Overall Sales Performance --
-------------------------------------------------------------------

/*Question 1: Overall sales performance
What are the total revenue, total orders, total units sold
and average order value?*/

-------------------------------------------------------------------
                         -- Tables Used --
-------------------------------------------------------------------

-- Review the order-level data.
SELECT TOP 10 *
FROM Sales.SalesOrderHeader;

-- Review the order-line-level data.
SELECT TOP 10 *
FROM Sales.SalesOrderDetail;

-------------------------------------------------------------------
                 -- Approach 1: Order-Line-Level Data --
-------------------------------------------------------------------

SELECT
    SUM(OrderQty) AS TotalUnitsSold,
    COUNT(DISTINCT SalesOrderID) AS TotalOrders,
    CAST(
        SUM(LineTotal) / COUNT(DISTINCT SalesOrderID)
        AS DECIMAL(18,2)
    ) AS AverageOrderValue,
    CAST(
        SUM(LineTotal)
        AS DECIMAL(18,2)
    ) AS TotalRevenue
FROM Sales.SalesOrderDetail;

-------------------------------------------------------------------
                 -- Approach 2: Order-Level Data --
-------------------------------------------------------------------

SELECT
    (
        SELECT SUM(OrderQty)
        FROM Sales.SalesOrderDetail
    ) AS TotalUnitsSold,
    COUNT(*) AS TotalOrders,
    CAST(
        AVG(SubTotal)
        AS DECIMAL(18,2)
    ) AS AverageOrderValue,
    CAST(
        SUM(SubTotal)
        AS DECIMAL(18,2)
    ) AS TotalRevenue
FROM Sales.SalesOrderHeader;

-------------------------------------------------------------------
                      -- Validation Note --
-------------------------------------------------------------------

/*
Both approaches should return the same overall business KPIs.

Approach 1:
Uses line-level revenue and counts unique sales orders.

Approach 2:
Uses one row per order for revenue, total orders and average order value,
while retrieving total units sold separately from the order-detail table.

Revenue definition:
Revenue is based on LineTotal or SubTotal and excludes tax and freight.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------


-------------------------------------------------------------------
               -- Question 2: Month-over-Month Performance --
-------------------------------------------------------------------

/*Question 2: Month-over-month sales performance
How did total revenue, total orders and total units sold change by month,
and did sales increase, decrease or remain unchanged compared with
the previous month?*/

-------------------------------------------------------------------
                         -- Tables Used --
-------------------------------------------------------------------

-- Contains one row per complete sales order and provides OrderDate.
SELECT TOP 10 *
FROM Sales.SalesOrderHeader;

-- Contains product-level quantities and line-level revenue.
SELECT TOP 10 *
FROM Sales.SalesOrderDetail;

-------------------------------------------------------------------
                 -- Approach 1: CTE-Based Solution --
-------------------------------------------------------------------

WITH MonthlySalesComparison AS
(
    SELECT
        YEAR(h.OrderDate) AS OrderYear,
        MONTH(h.OrderDate) AS OrderMonth,
        SUM(d.OrderQty) AS TotalUnitsSold,
        COUNT(DISTINCT h.SalesOrderID) AS TotalOrdersPlaced,
        CAST(
            SUM(d.LineTotal)
            AS DECIMAL(18,2)
        ) AS TotalRevenue,
        LAG(SUM(d.LineTotal)) OVER
        (
            ORDER BY
                YEAR(h.OrderDate),
                MONTH(h.OrderDate)
        ) AS PreviousMonthRevenue
    FROM Sales.SalesOrderHeader AS h
    INNER JOIN Sales.SalesOrderDetail AS d
        ON h.SalesOrderID = d.SalesOrderID
    GROUP BY
        YEAR(h.OrderDate),
        MONTH(h.OrderDate)
)
SELECT
    OrderYear,
    OrderMonth,
    TotalUnitsSold,
    TotalOrdersPlaced,
    TotalRevenue,
    CAST(
        PreviousMonthRevenue
        AS DECIMAL(18,2)
    ) AS PreviousMonthRevenue,
    CAST(
        (
            TotalRevenue - PreviousMonthRevenue
        )
        / NULLIF(PreviousMonthRevenue, 0)
        * 100
        AS DECIMAL(18,2)
    ) AS MonthOverMonthPercentageChange,
    CASE
        WHEN PreviousMonthRevenue IS NULL
            THEN 'No Previous Month'
        WHEN TotalRevenue > PreviousMonthRevenue
            THEN 'Sales Increased'
        WHEN TotalRevenue < PreviousMonthRevenue
            THEN 'Sales Decreased'
        ELSE 'No Change'
    END AS SalesTrend
FROM MonthlySalesComparison
ORDER BY
    OrderYear,
    OrderMonth;

-------------------------------------------------------------------
             -- Approach 2: Single-Query Solution --
-------------------------------------------------------------------

SELECT
    YEAR(h.OrderDate) AS OrderYear,
    MONTH(h.OrderDate) AS OrderMonth,
    SUM(d.OrderQty) AS TotalUnitsSold,
    COUNT(DISTINCT h.SalesOrderID) AS TotalOrdersPlaced,
    CAST(
        SUM(d.LineTotal)
        AS DECIMAL(18,2)
    ) AS TotalRevenue,
    CAST(
        LAG(SUM(d.LineTotal)) OVER
        (
            ORDER BY
                YEAR(h.OrderDate),
                MONTH(h.OrderDate)
        )
        AS DECIMAL(18,2)
    ) AS PreviousMonthRevenue,
    CAST(
        (
            SUM(d.LineTotal)
            -
            LAG(SUM(d.LineTotal)) OVER
            (
                ORDER BY
                    YEAR(h.OrderDate),
                    MONTH(h.OrderDate)
            )
        )
        /
        NULLIF(
            LAG(SUM(d.LineTotal)) OVER
            (
                ORDER BY
                    YEAR(h.OrderDate),
                    MONTH(h.OrderDate)
            ),
            0
        )
        * 100
        AS DECIMAL(18,2)
    ) AS MonthOverMonthPercentageChange,
    CASE
        WHEN LAG(SUM(d.LineTotal)) OVER
             (
                 ORDER BY
                     YEAR(h.OrderDate),
                     MONTH(h.OrderDate)
             ) IS NULL
            THEN 'No Previous Month'

        WHEN SUM(d.LineTotal) >
             LAG(SUM(d.LineTotal)) OVER
             (
                 ORDER BY
                     YEAR(h.OrderDate),
                     MONTH(h.OrderDate)
             )
            THEN 'Sales Increased'

        WHEN SUM(d.LineTotal) <
             LAG(SUM(d.LineTotal)) OVER
             (
                 ORDER BY
                     YEAR(h.OrderDate),
                     MONTH(h.OrderDate)
             )
            THEN 'Sales Decreased'

        ELSE 'No Change'
    END AS SalesTrend
FROM Sales.SalesOrderHeader AS h
INNER JOIN Sales.SalesOrderDetail AS d
    ON h.SalesOrderID = d.SalesOrderID
GROUP BY
    YEAR(h.OrderDate),
    MONTH(h.OrderDate)
ORDER BY
    OrderYear,
    OrderMonth;

-------------------------------------------------------------------
                      -- Validation Note --
-------------------------------------------------------------------

/*
Both approaches calculate the same monthly KPIs.

The CTE-based solution is recommended for the final portfolio because it:

1. Separates monthly aggregation from the comparison calculation.
2. Avoids repeatedly writing the same LAG calculation.
3. Is easier for another analyst or recruiter to read and maintain.
4. Keeps the month-over-month percentage numeric for Power BI.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------


-------------------------------------------------------------------
                  -- Question 14: Order Value Segmentation --
-------------------------------------------------------------------

/*Question 14: Order value segmentation
How are sales orders distributed across low-value, medium-value
and high-value order groups, and what percentage of total revenue
does each group generate?*/

-------------------------------------------------------------------
                         -- Table Used --
-------------------------------------------------------------------

-- Contains one row per order and the order-level SubTotal.
SELECT TOP 10 *
FROM Sales.SalesOrderHeader;

-------------------------------------------------------------------
                    -- Order Segmentation Analysis --
-------------------------------------------------------------------

WITH OrderValueClassification AS
(
    SELECT
        SalesOrderID,
        SubTotal,
        CASE
            WHEN SubTotal <= 3491
                THEN 3
            WHEN SubTotal > 3491
                 AND SubTotal <= 55000
                THEN 2
            ELSE 1
        END AS OrderValueGroup
    FROM Sales.SalesOrderHeader
),
TotalCompanyRevenue AS
(
    SELECT
        SUM(SubTotal) AS TotalRevenue
    FROM Sales.SalesOrderHeader
),
OrderSegmentSummary AS
(
    SELECT
        OrderValueGroup,
        COUNT(*) AS NumberOfOrders,
        SUM(SubTotal) AS SegmentRevenue
    FROM OrderValueClassification
    GROUP BY OrderValueGroup
)
SELECT
    CASE
        WHEN s.OrderValueGroup = 1
            THEN 'High Value Order'
        WHEN s.OrderValueGroup = 2
            THEN 'Medium Value Order'
        WHEN s.OrderValueGroup = 3
            THEN 'Low Value Order'
    END AS OrderValueSegment,
    s.NumberOfOrders,
    CAST(
        s.SegmentRevenue
        AS DECIMAL(18,2)
    ) AS SegmentRevenue,
    CAST(
        s.SegmentRevenue
        / NULLIF(t.TotalRevenue, 0)
        * 100
        AS DECIMAL(18,2)
    ) AS RevenueContributionPercentage
FROM OrderSegmentSummary AS s
CROSS JOIN TotalCompanyRevenue AS t
ORDER BY
    s.SegmentRevenue DESC;

-------------------------------------------------------------------
                      -- Threshold Explanation --
-------------------------------------------------------------------

/*
Order-value thresholds used:

Low-value order:
SubTotal less than or equal to 3,491.

Medium-value order:
SubTotal above 3,491 and up to 55,000.

High-value order:
SubTotal above 55,000.

The lower threshold is based approximately on the overall average order
value. The thresholds should be described as analyst-defined business
bands and reviewed if management provides official commercial thresholds.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------
