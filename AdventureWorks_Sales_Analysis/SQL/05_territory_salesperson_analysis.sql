/*
Project: AdventureWorks Sales and Customer Performance Analysis
File: 05_territory_salesperson_analysis.sql
Database: AdventureWorks2025
Platform: SQL Server

Purpose:
Analyse sales performance by country, sales territory and salesperson,
including total revenue, total orders and average order value.

Note:
AdventureWorks is a fictional Microsoft sample database.
*/

USE AdventureWorks2025;
GO

-------------------------------------------------------------------
-------------------------------------------------------------------

/*Question 9: Sales by country and territory
Which countries and sales territories generated the highest total
revenue, total orders and average order value?*/

-------------------------------------------------------------------
                         -- Tables Used --
-------------------------------------------------------------------

SELECT TOP 10 *
FROM Sales.SalesOrderHeader;

SELECT TOP 10 *
FROM Sales.SalesTerritory;

-------------------------------------------------------------------
                -- Country and Territory Analysis --
-------------------------------------------------------------------

WITH TerritoryPerformance AS
(
    SELECT
        h.TerritoryID,
        t.Name AS TerritoryName,
        t.CountryRegionCode AS CountryCode,
        SUM(h.SubTotal) AS TotalRevenue,
        COUNT(*) AS TotalOrders,
        AVG(h.SubTotal) AS AverageOrderValue
    FROM Sales.SalesOrderHeader AS h
    INNER JOIN Sales.SalesTerritory AS t
        ON h.TerritoryID = t.TerritoryID
    GROUP BY
        h.TerritoryID,
        t.Name,
        t.CountryRegionCode
)
SELECT
    TerritoryID,
    TerritoryName,
    CASE
        WHEN CountryCode = 'AU' THEN 'Australia'
        WHEN CountryCode = 'CA' THEN 'Canada'
        WHEN CountryCode = 'DE' THEN 'Germany'
        WHEN CountryCode = 'FR' THEN 'France'
        WHEN CountryCode = 'GB' THEN 'United Kingdom'
        WHEN CountryCode = 'US' THEN 'United States'
        ELSE CountryCode
    END AS CountryName,
    CountryCode,
    TotalOrders,
    CAST(
        TotalRevenue
        AS DECIMAL(18,2)
    ) AS TotalRevenue,
    CAST(
        AverageOrderValue
        AS DECIMAL(18,2)
    ) AS AverageOrderValue
FROM TerritoryPerformance
ORDER BY
    TotalRevenue DESC;

-------------------------------------------------------------------
-------------------------------------------------------------------

/*
Final grain:
One row per sales territory.

Business meaning:
Total revenue identifies the territories making the largest financial
contribution.

Total orders measures order volume.

Average order value shows whether a territory's revenue is supported
by larger orders or by a higher number of smaller orders.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------


/*Question 10: Salesperson performance
Which salespeople generated the highest total revenue and number
of orders, and what was their average order value?*/

-------------------------------------------------------------------
                         -- Tables Used --
-------------------------------------------------------------------

SELECT TOP 10 *
FROM Sales.SalesOrderHeader;

SELECT TOP 10 *
FROM Sales.SalesPerson;

SELECT TOP 10 *
FROM HumanResources.Employee;

SELECT TOP 10 *
FROM Person.Person;

-------------------------------------------------------------------
                   -- Salesperson Performance --
-------------------------------------------------------------------

SELECT
    h.SalesPersonID,
    CONCAT(
        p.FirstName,
        ' ',
        p.LastName
    ) AS SalesPersonName,
    CAST(
        SUM(h.SubTotal)
        AS DECIMAL(18,2)
    ) AS TotalRevenue,
    COUNT(*) AS NumberOfOrders,
    CAST(
        AVG(h.SubTotal)
        AS DECIMAL(18,2)
    ) AS AverageOrderValue
FROM Sales.SalesOrderHeader AS h
INNER JOIN Sales.SalesPerson AS sp
    ON h.SalesPersonID = sp.BusinessEntityID
INNER JOIN HumanResources.Employee AS e
    ON sp.BusinessEntityID = e.BusinessEntityID
INNER JOIN Person.Person AS p
    ON e.BusinessEntityID = p.BusinessEntityID
GROUP BY
    h.SalesPersonID,
    p.FirstName,
    p.LastName
ORDER BY
    TotalRevenue DESC;

-------------------------------------------------------------------
-------------------------------------------------------------------

/*
Relationship path:

SalesOrderHeader.SalesPersonID
    to SalesPerson.BusinessEntityID

SalesPerson.BusinessEntityID
    to Employee.BusinessEntityID

Employee.BusinessEntityID
    to Person.BusinessEntityID

SalesOrderHeader contains one row per order, so COUNT(*) correctly
calculates the number of orders assigned to each salesperson.

Orders with no assigned salesperson are excluded because this analysis
measures individual salesperson performance.

Final grain:
One row per salesperson.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------
