/*
Project: AdventureWorks Sales and Customer Performance Analysis
File: 03_product_analysis.sql
Database: AdventureWorks2025
Platform: SQL Server

Purpose:
Analyse product, category and subcategory performance, identify the
highest-revenue products, measure category revenue contribution and
highlight low-performing or unsold products.

Note:
AdventureWorks is a fictional Microsoft sample database.
*/

USE AdventureWorks2025;
GO

-------------------------------------------------------------------
-------------------------------------------------------------------

/*Question 3: Top products by revenue
Which 10 products generated the highest total revenue,
and how many units of each product were sold?*/

-------------------------------------------------------------------
                         -- Tables Used --
-------------------------------------------------------------------

SELECT TOP 10 *
FROM Sales.SalesOrderDetail;

SELECT TOP 10 *
FROM Production.Product;

-------------------------------------------------------------------
                    -- Top Product Analysis --
-------------------------------------------------------------------

SELECT TOP 10
    d.ProductID,
    p.Name AS ProductName,
    SUM(d.OrderQty) AS TotalUnitsSold,
    CAST(
        SUM(d.LineTotal)
        AS DECIMAL(18,2)
    ) AS TotalRevenue
FROM Sales.SalesOrderDetail AS d
INNER JOIN Production.Product AS p
    ON d.ProductID = p.ProductID
GROUP BY
    d.ProductID,
    p.Name
ORDER BY
    TotalRevenue DESC;

-------------------------------------------------------------------
-------------------------------------------------------------------

/*
Final grain:
One row per product.

Business meaning:
The result identifies the products that generated the highest sales
revenue and shows whether their performance was supported by a high
number of units sold.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------


/*Question 4: Product category performance
Which product categories and subcategories generated the highest
total revenue and units sold?*/

-------------------------------------------------------------------
                         -- Tables Used --
-------------------------------------------------------------------

SELECT TOP 10 *
FROM Sales.SalesOrderDetail;

SELECT TOP 10 *
FROM Production.Product;

SELECT TOP 10 *
FROM Production.ProductSubcategory;

SELECT TOP 10 *
FROM Production.ProductCategory;

-------------------------------------------------------------------
               -- Category and Subcategory Analysis --
-------------------------------------------------------------------

SELECT
    c.ProductCategoryID,
    c.Name AS CategoryName,
    sc.ProductSubcategoryID,
    sc.Name AS SubcategoryName,
    SUM(d.OrderQty) AS TotalUnitsSold,
    CAST(
        SUM(d.LineTotal)
        AS DECIMAL(18,2)
    ) AS TotalRevenue
FROM Sales.SalesOrderDetail AS d
INNER JOIN Production.Product AS p
    ON d.ProductID = p.ProductID
INNER JOIN Production.ProductSubcategory AS sc
    ON p.ProductSubcategoryID = sc.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS c
    ON sc.ProductCategoryID = c.ProductCategoryID
GROUP BY
    c.ProductCategoryID,
    c.Name,
    sc.ProductSubcategoryID,
    sc.Name
ORDER BY
    TotalRevenue DESC,
    TotalUnitsSold DESC;

-------------------------------------------------------------------
-------------------------------------------------------------------

/*
Final grain:
One row per product subcategory within each product category.

Business meaning:
The result compares product groups by both revenue and demand.
Revenue shows commercial contribution, while units sold show product
volume.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------


/*Question 5: Category revenue contribution
What percentage of the company’s total revenue was generated
by each product category?*/

-------------------------------------------------------------------
                         -- Tables Used --
-------------------------------------------------------------------

SELECT TOP 10 *
FROM Sales.SalesOrderDetail;

SELECT TOP 10 *
FROM Production.Product;

SELECT TOP 10 *
FROM Production.ProductSubcategory;

SELECT TOP 10 *
FROM Production.ProductCategory;

-------------------------------------------------------------------
               -- Category Revenue Contribution --
-------------------------------------------------------------------

WITH CategoryRevenue AS
(
    SELECT
        c.ProductCategoryID,
        c.Name AS CategoryName,
        SUM(d.LineTotal) AS ProductCategoryRevenue
    FROM Sales.SalesOrderDetail AS d
    INNER JOIN Production.Product AS p
        ON d.ProductID = p.ProductID
    INNER JOIN Production.ProductSubcategory AS sc
        ON p.ProductSubcategoryID = sc.ProductSubcategoryID
    INNER JOIN Production.ProductCategory AS c
        ON sc.ProductCategoryID = c.ProductCategoryID
    GROUP BY
        c.ProductCategoryID,
        c.Name
),
TotalCompanyRevenue AS
(
    SELECT
        SUM(LineTotal) AS TotalRevenue
    FROM Sales.SalesOrderDetail
)
SELECT
    cr.ProductCategoryID,
    cr.CategoryName,
    CAST(
        cr.ProductCategoryRevenue
        AS DECIMAL(18,2)
    ) AS ProductCategoryRevenue,
    CAST(
        tr.TotalRevenue
        AS DECIMAL(18,2)
    ) AS TotalCompanyRevenue,
    CAST(
        cr.ProductCategoryRevenue
        / NULLIF(tr.TotalRevenue, 0)
        * 100
        AS DECIMAL(18,2)
    ) AS CategoryRevenueContributionPercentage
FROM CategoryRevenue AS cr
CROSS JOIN TotalCompanyRevenue AS tr
ORDER BY
    CategoryRevenueContributionPercentage DESC;

-------------------------------------------------------------------
-------------------------------------------------------------------

/*
Formula:
Category revenue divided by total company revenue, multiplied by 100.

Final grain:
One row per product category.

Validation:
The category contribution percentages should total approximately 100%.
Small differences may occur because the percentages are rounded.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------


/*Question 11: Low-performing and unsold products
Which products generated the lowest total revenue,
and which products have not recorded any sales?*/

-------------------------------------------------------------------
                         -- Tables Used --
-------------------------------------------------------------------

SELECT TOP 10 *
FROM Production.Product;

SELECT TOP 10 *
FROM Sales.SalesOrderDetail;

-------------------------------------------------------------------
             -- Low-Performing and Unsold Products --
-------------------------------------------------------------------

WITH ProductPerformance AS
(
    SELECT
        p.ProductID,
        p.Name AS ProductName,
        CAST(
            COALESCE(SUM(d.LineTotal), 0)
            AS DECIMAL(18,2)
        ) AS TotalRevenue,
        COALESCE(
            SUM(d.OrderQty),
            0
        ) AS TotalUnitsSold
    FROM Production.Product AS p
    LEFT JOIN Sales.SalesOrderDetail AS d
        ON p.ProductID = d.ProductID
    GROUP BY
        p.ProductID,
        p.Name
)
SELECT
    ProductID,
    ProductName,
    TotalUnitsSold,
    TotalRevenue,
    CASE
        WHEN TotalRevenue = 0
            THEN 'No Revenue Generated'
        ELSE 'Revenue Generated'
    END AS SalesStatus
FROM ProductPerformance
ORDER BY
    TotalRevenue ASC,
    TotalUnitsSold ASC;

-------------------------------------------------------------------
-------------------------------------------------------------------

/*
The analysis begins with Production.Product because it contains every
product, including products that have never appeared in a sales order.

The LEFT JOIN keeps unsold products in the result.

Final grain:
One row per product.

Business meaning:
Products with zero revenue may be inactive, discontinued, newly added
or commercially unsuccessful. These products should be investigated
before any recommendation is made.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------
