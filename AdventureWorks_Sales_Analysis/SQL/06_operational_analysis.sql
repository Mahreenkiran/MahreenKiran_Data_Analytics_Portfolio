/*
Project: AdventureWorks Sales and Customer Performance Analysis
File: 06_operational_analysis.sql
Database: AdventureWorks2025
Platform: SQL Server

Purpose:
Analyse order fulfilment performance by measuring the average time
between order placement and shipment across sales territories.

Note:
AdventureWorks is a fictional Microsoft sample database.
*/

USE AdventureWorks2025;
GO

-------------------------------------------------------------------
-------------------------------------------------------------------

/*Question 12: Order fulfilment performance
What was the average number of days between order placement and
shipment for each sales territory, and which territories took the
longest to ship orders?*/

-------------------------------------------------------------------
                         -- Tables Used --
-------------------------------------------------------------------

SELECT TOP 10 *
FROM Sales.SalesOrderHeader;

SELECT TOP 10 *
FROM Sales.SalesTerritory;

-------------------------------------------------------------------
                -- Order Fulfilment Analysis --
-------------------------------------------------------------------

SELECT
    h.TerritoryID,
    st.Name AS TerritoryName,
    AVG(
        DATEDIFF(
            DAY,
            h.OrderDate,
            h.ShipDate
        )
    ) AS AverageShippingDays
FROM Sales.SalesOrderHeader AS h
INNER JOIN Sales.SalesTerritory AS st
    ON h.TerritoryID = st.TerritoryID
WHERE h.ShipDate IS NOT NULL
GROUP BY
    h.TerritoryID,
    st.Name
ORDER BY
    AverageShippingDays DESC;

-------------------------------------------------------------------
-------------------------------------------------------------------

/*
Final grain:
One row per sales territory.

Business meaning:
AverageShippingDays measures the average time between order placement
and shipment for completed orders.

Territories appearing at the top took the longest average time to
ship orders and may require further operational investigation.

Orders with a missing ShipDate are excluded because their fulfilment
time cannot yet be calculated.

A separate validation check found no completed orders where ShipDate
was later than DueDate.
*/

-------------------------------------------------------------------
-------------------------------------------------------------------

/*
Data limitation:

All analysed territories returned an average shipping time of 7 days.
Further shipping-time segmentation was not added because the dataset
does not contain meaningful variation in this measure.

This likely reflects the standardised structure of the fictional
AdventureWorks sample data rather than real-world operational behaviour.
*/
