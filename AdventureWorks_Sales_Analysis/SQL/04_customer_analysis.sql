/*
Project: AdventureWorks Sales and Customer Performance Analysis
File: 04_customer_analysis.sql
Database: AdventureWorks2025
Platform: SQL Server

Purpose:
Analyse customer revenue, purchasing frequency, average order value,
customer value segments and recent customer inactivity.

Note:
AdventureWorks is a fictional Microsoft sample database.
*/

USE AdventureWorks2025;
GO

-------------------------------------------------------------------
-------------------------------------------------------------------

/*Question 6: Top customers by revenue
Which 10 customers generated the highest total revenue,
and how many orders did each customer place?*/

-------------------------------------------------------------------
                         -- Tables Used --
-------------------------------------------------------------------

SELECT TOP 10 *
FROM Sales.SalesOrderHeader;

SELECT TOP 10 *
FROM Sales.Customer;

SELECT TOP 10 *
FROM Sales.Store;

SELECT TOP 10 *
FROM Person.Person;

-------------------------------------------------------------------
                  -- Top Customers by Revenue --
-------------------------------------------------------------------

SELECT TOP 10
    c.CustomerID,
    CASE
        WHEN s.Name IS NOT NULL
            THEN s.Name
        ELSE CONCAT(p.FirstName, ' ', p.LastName)
    END AS CustomerName,
    CAST(
        SUM(h.SubTotal)
        AS DECIMAL(18,2)
    ) AS RevenueGenerated,
    COUNT(*) AS NumberOfOrdersPlaced
FROM Sales.SalesOrderHeader AS h
LEFT JOIN Sales.Customer AS c
    ON h.CustomerID = c.CustomerID
LEFT JOIN Sales.Store AS s
    ON c.StoreID = s.BusinessEntityID
LEFT JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID
GROUP BY
    c.CustomerID,
    s.Name,
    p.FirstName,
    p.LastName
ORDER BY
    RevenueGenerated DESC,
    NumberOfOrdersPlaced DESC;

-------------------------------------------------------------------
-------------------------------------------------------------------

/*
Final grain:
One row per customer.

Customer name logic:
Store customers use the store name.
Individual customers use the person's first and last name.

SalesOrderHeader contains one row per order, so COUNT(*) correctly
calculates the number of orders placed by each customer.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------


/*Question 7: Customer order frequency
Which customers placed the highest number of orders,
and what were their total revenue and average order value?*/

-------------------------------------------------------------------
                         -- Tables Used --
-------------------------------------------------------------------

SELECT TOP 10 *
FROM Sales.SalesOrderHeader;

SELECT TOP 10 *
FROM Sales.Customer;

SELECT TOP 10 *
FROM Sales.Store;

SELECT TOP 10 *
FROM Person.Person;

-------------------------------------------------------------------
                 -- Customer Order Frequency --
-------------------------------------------------------------------

SELECT TOP 10
    h.CustomerID,
    CASE
        WHEN s.Name IS NOT NULL
            THEN s.Name
        ELSE CONCAT(p.FirstName, ' ', p.LastName)
    END AS CustomerName,
    CAST(
        SUM(h.SubTotal)
        AS DECIMAL(18,2)
    ) AS CustomerRevenue,
    COUNT(h.SalesOrderID) AS NumberOfOrders,
    CAST(
        AVG(h.SubTotal)
        AS DECIMAL(18,2)
    ) AS AverageOrderValue
FROM Sales.SalesOrderHeader AS h
LEFT JOIN Sales.Customer AS c
    ON h.CustomerID = c.CustomerID
LEFT JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.Store AS s
    ON c.StoreID = s.BusinessEntityID
GROUP BY
    h.CustomerID,
    s.Name,
    p.FirstName,
    p.LastName
ORDER BY
    NumberOfOrders DESC,
    CustomerRevenue DESC;

-------------------------------------------------------------------
-------------------------------------------------------------------

/*
Final grain:
One row per customer.

Business meaning:
This result identifies customers who purchase most frequently.

Customer revenue is used as the second sorting condition when two
customers have placed the same number of orders.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------


/*Question 8: Customer value segmentation
How can customers be grouped into high-value, medium-value
and low-value segments based on their total revenue?

How many customers belong to each segment, and what percentage
of company revenue does each segment generate?*/

-------------------------------------------------------------------
                         -- Table Used --
-------------------------------------------------------------------

SELECT TOP 10 *
FROM Sales.SalesOrderHeader;

-------------------------------------------------------------------
                  -- Customer Segmentation --
-------------------------------------------------------------------

WITH CustomerRevenue AS
(
    SELECT
        CustomerID,
        SUM(SubTotal) AS TotalRevenue
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
),
CustomerSegments AS
(
    SELECT
        CustomerID,
        TotalRevenue,
        CASE
            WHEN TotalRevenue >= 100495
                THEN 'High Value Customer'
            WHEN TotalRevenue >= 10000
                THEN 'Medium Value Customer'
            ELSE 'Low Value Customer'
        END AS CustomerSegment
    FROM CustomerRevenue
),
SegmentSummary AS
(
    SELECT
        CustomerSegment,
        COUNT(*) AS NumberOfCustomers,
        SUM(TotalRevenue) AS SegmentRevenue
    FROM CustomerSegments
    GROUP BY CustomerSegment
)
SELECT
    CustomerSegment,
    NumberOfCustomers,
    CAST(
        SegmentRevenue
        AS DECIMAL(18,2)
    ) AS SegmentRevenue,
    CAST(
        SegmentRevenue
        / NULLIF(SUM(SegmentRevenue) OVER (), 0)
        * 100
        AS DECIMAL(18,2)
    ) AS RevenueContributionPercentage
FROM SegmentSummary
ORDER BY
    SegmentRevenue DESC;

-------------------------------------------------------------------
-------------------------------------------------------------------

/*
Customer segment thresholds:

High-value customer:
Total customer revenue of 100,495 or more.

Medium-value customer:
Total customer revenue from 10,000 to below 100,495.

Low-value customer:
Total customer revenue below 10,000.

These are analyst-defined business thresholds based on the distribution
of customer revenue in the AdventureWorks dataset.

The segmentation should be interpreted together with both the number
of customers and each segment's revenue contribution.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------


/*Question 13: Recent customer inactivity
Which customers have not placed an order during the most recent
12 months available in the database?*/

-------------------------------------------------------------------
                         -- Tables Used --
-------------------------------------------------------------------

SELECT TOP 10 *
FROM Sales.Customer;

SELECT TOP 10 *
FROM Sales.SalesOrderHeader;

SELECT TOP 10 *
FROM Person.Person;

SELECT TOP 10 *
FROM Sales.Store;

-------------------------------------------------------------------
                  -- Inactive Customer Analysis --
-------------------------------------------------------------------

SELECT
    c.CustomerID,
    CASE
        WHEN c.StoreID IS NULL
            THEN CONCAT(p.FirstName, ' ', p.LastName)
        ELSE s.Name
    END AS CustomerName,
    MAX(h.OrderDate) AS LastOrderDate
FROM Sales.Customer AS c
LEFT JOIN Sales.SalesOrderHeader AS h
    ON c.CustomerID = h.CustomerID
LEFT JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID
LEFT JOIN Sales.Store AS s
    ON c.StoreID = s.BusinessEntityID
GROUP BY
    c.CustomerID,
    c.StoreID,
    s.Name,
    p.FirstName,
    p.LastName
HAVING
       MAX(h.OrderDate) < '2024-06-29'
    OR MAX(h.OrderDate) IS NULL
ORDER BY
    LastOrderDate ASC;

-------------------------------------------------------------------
-------------------------------------------------------------------

/*
The latest available order date in the database was identified as
29 June 2025.

The inactivity cut-off was therefore set to 29 June 2024, representing
the beginning of the most recent 12-month period available in the data.

Customers with no recorded order are also included because their
maximum order date is NULL.

Final grain:
One row per inactive customer.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------
