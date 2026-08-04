
-------------------------------------------------------------------                         
                        --Data Cleaning--
-------------------------------------------------------------------

SELECT * FROM AdventureWorks2025.SALES.SalesOrderHeader;

-------------------------------------------------------------------                         
-------------------------------------------------------------------
/*Data-quality check 1: Duplicate sales orders
Are there any sales order identifiers appearing more than once in the sales order header data?*/


SELECT *
FROM
(
    SELECT
        SalesOrderID,
        ROW_NUMBER() OVER
        (
            PARTITION BY SalesOrderID
            ORDER BY SalesOrderID
        ) AS RowNumber
    FROM AdventureWorks2025.Sales.SalesOrderHeader
) AS DuplicateCheck
WHERE RowNumber > 1;

-------------------------------------------------------------------
                            -- OR --
-------------------------------------------------------------------

SELECT
    SalesOrderID,
    COUNT(*) AS DuplicateCount
FROM AdventureWorks2025.Sales.SalesOrderHeader
GROUP BY SalesOrderID
HAVING COUNT(*) > 1;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

--SELECT * FROM AdventureWorks2025.SALES.SalesOrderDetail;

/*Data-quality check 2: Duplicate sales order lines
Are there any duplicate sales order detail identifiers in the sales order detail data?*/

SELECT * 
FROM
(
SELECT SalesOrderDetailID,COUNT(SalesOrderDetailID) AS DuplicateCheking
FROM AdventureWorks2025.SALES.SalesOrderDetail
GROUP BY SalesOrderDetailID
) QualityChecking
WHERE DuplicateCheking >1;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 3: Invalid order quantities
Are there any sales order lines with zero or negative quantities?*/

SELECT
    SalesOrderID,
    SalesOrderDetailID,
    OrderQty
FROM AdventureWorks2025.Sales.SalesOrderDetail
WHERE OrderQty <= 0;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 4: Invalid sales values
Are there any sales order lines with negative unit prices, discounts or line totals?*/

SELECT SalesOrderID,SalesOrderDetailID,UnitPrice,UnitPriceDiscount,LineTotal
FROM AdventureWorks2025.Sales.SalesOrderDetail
WHERE UnitPrice <0 OR UnitPriceDiscount <0 OR LineTotal <0;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 5: Invalid order dates
Are there any orders where the shipping date is earlier than the order date?*/

SELECT SalesOrderID,OrderDate,ShipDate
FROM AdventureWorks2025.Sales.SalesOrderHeader
WHERE ShipDate < OrderDate 

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 6: Unmatched order details
Are there any sales order detail records without a matching sales order header?*/

SELECT O.SalesOrderID,SalesOrderDetailID
FROM AdventureWorks2025.Sales.SalesOrderDetail as O
LEFT JOIN AdventureWorks2025.Sales.SalesOrderHeader AS H
ON O.SalesOrderID=H.SalesOrderID
WHERE H.SalesOrderID IS NULL

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 7: Unmatched products
Are there any sales order detail records linked to a product that does not exist in the product table?*/

SELECT O.SalesOrderID,SalesOrderDetailID, o.ProductID
FROM AdventureWorks2025.Sales.SalesOrderDetail as O
LEFT JOIN AdventureWorks2025.Production.PRODUCT AS P
ON O.ProductID=P.ProductID
WHERE P.ProductID IS NULL

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 8: Missing important order values
Are there any orders with missing customer, order date, due date or order total information?*/

SELECT * FROM AdventureWorks2025.SALES.SalesOrderHeader;

SELECT
    h.SalesOrderID,
    h.CustomerID,
    h.OrderDate,
    h.DueDate,
    h.SubTotal
FROM AdventureWorks2025.Sales.SalesOrderHeader AS h
LEFT JOIN AdventureWorks2025.Sales.Customer AS c
    ON h.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL
   OR h.OrderDate IS NULL
   OR h.DueDate IS NULL
   OR h.SubTotal IS NULL;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

--SELECT * FROM AdventureWorks2025.SALES.SalesOrderHeader;

/*Data-quality check 9: Invalid due dates
Are there any orders where the due date is earlier than the order date?*/
SELECT SalesOrderID,
OrderDate,
DueDate 
FROM AdventureWorks2025.SALES.SalesOrderHeader
WHERE DueDate < OrderDate;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 10: Invalid discounts
Are there any sales order lines with discounts below 0 or above 100%?*/

--SELECT * FROM AdventureWorks2025.Sales.SalesOrderDetail;

SELECT
    SalesOrderID,
    SalesOrderDetailID,
    UnitPrice,
    UnitPriceDiscount
FROM AdventureWorks2025.Sales.SalesOrderDetail
WHERE UnitPriceDiscount < 0
   OR UnitPriceDiscount > 1;

-------------------------------------------------------------------                         
-------------------------------------------------------------------

/*Data-quality check 11: Dataset coverage
What are the earliest and latest order dates, and how many order and order-line records are available?*/

SELECT * FROM AdventureWorks2025.SALES.SalesOrderHeader;
SELECT * FROM AdventureWorks2025.SALES.SalesOrderDetail;

SELECT MIN(OrderDate) AS MinOrderDate, 
MAX(OrderDate) AS MaximumOrderDate,
(SELECT COUNT(*) AS CompleteOrders FROM  AdventureWorks2025.SALES.SalesOrderHeader) NumberCompleteOrders,
(SELECT COUNT(ProductID) FROM AdventureWorks2025.SALES.SalesOrderDETAIL AS O) AS NumberOfOrderLines
FROM AdventureWorks2025.SALES.SalesOrderHEADER 

-------------------------------------------------------------------                         
-------------------------------------------------------------------
