/*
Project: AdventureWorks Sales and Customer Performance Analysis
File: 01_data_quality_checks.sql
Database: AdventureWorks2025
Platform: SQL Server

Purpose:
Validate the reliability of sales, order, customer and product data before
calculating business KPIs and completing the main analysis.

Note:
AdventureWorks is a fictional Microsoft sample database.
*/

USE AdventureWorks2025;
GO

/*Data-quality check 1: Duplicate sales orders
Are there any sales order identifiers appearing more than once in the sales order header data?*/

SELECT
    SalesOrderID,
    COUNT(*) AS DuplicateCount
FROM Sales.SalesOrderHeader
GROUP BY SalesOrderID
HAVING COUNT(*) > 1;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 2: Duplicate sales order lines
Are there any duplicate sales order detail identifiers in the sales order detail data?*/

SELECT
    SalesOrderDetailID,
    COUNT(*) AS DuplicateCount
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderDetailID
HAVING COUNT(*) > 1;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 3: Invalid order quantities
Are there any sales order lines with zero or negative quantities?*/

SELECT
    SalesOrderID,
    SalesOrderDetailID,
    ProductID,
    OrderQty
FROM Sales.SalesOrderDetail
WHERE OrderQty <= 0;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 4: Invalid sales values
Are there any sales order lines with negative unit prices, discounts or line totals?*/

SELECT
    SalesOrderID,
    SalesOrderDetailID,
    ProductID,
    UnitPrice,
    UnitPriceDiscount,
    LineTotal
FROM Sales.SalesOrderDetail
WHERE UnitPrice < 0
   OR UnitPriceDiscount < 0
   OR LineTotal < 0;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 5: Invalid shipping dates
Are there any orders where the shipping date is earlier than the order date?*/

SELECT
    SalesOrderID,
    OrderDate,
    ShipDate
FROM Sales.SalesOrderHeader
WHERE ShipDate < OrderDate;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 6: Unmatched order details
Are there any sales order detail records without a matching sales order header?*/

SELECT
    d.SalesOrderID,
    d.SalesOrderDetailID
FROM Sales.SalesOrderDetail AS d
LEFT JOIN Sales.SalesOrderHeader AS h
    ON d.SalesOrderID = h.SalesOrderID
WHERE h.SalesOrderID IS NULL;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 7: Unmatched products
Are there any sales order detail records linked to a product that does not exist in the product table?*/

SELECT
    d.SalesOrderID,
    d.SalesOrderDetailID,
    d.ProductID
FROM Sales.SalesOrderDetail AS d
LEFT JOIN Production.Product AS p
    ON d.ProductID = p.ProductID
WHERE p.ProductID IS NULL;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 8: Missing or unmatched important order values
Are there any orders with missing customer, order date, due date or subtotal information,
or with a customer identifier that does not match the customer table?*/

SELECT
    h.SalesOrderID,
    h.CustomerID,
    h.OrderDate,
    h.DueDate,
    h.SubTotal
FROM Sales.SalesOrderHeader AS h
LEFT JOIN Sales.Customer AS c
    ON h.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL
   OR h.CustomerID IS NULL
   OR h.OrderDate IS NULL
   OR h.DueDate IS NULL
   OR h.SubTotal IS NULL;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 9: Invalid due dates
Are there any orders where the due date is earlier than the order date?*/

SELECT
    SalesOrderID,
    OrderDate,
    DueDate
FROM Sales.SalesOrderHeader
WHERE DueDate < OrderDate;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 10: Invalid discounts
Are there any sales order lines with discounts below 0% or above 100%?*/

SELECT
    SalesOrderID,
    SalesOrderDetailID,
    ProductID,
    UnitPrice,
    UnitPriceDiscount
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount < 0
   OR UnitPriceDiscount > 1;

-------------------------------------------------------------------                         
-------------------------------------------------------------------


/*Data-quality check 11: Dataset coverage
What are the earliest and latest order dates, and how many order and order-line records are available?*/

SELECT
    MIN(OrderDate) AS EarliestOrderDate,
    MAX(OrderDate) AS LatestOrderDate,
    COUNT(*) AS NumberOfCompleteOrders,
    (
        SELECT COUNT(*)
        FROM Sales.SalesOrderDetail
    ) AS NumberOfOrderLines
FROM Sales.SalesOrderHeader;

-------------------------------------------------------------------                         
-------------------------------------------------------------------
