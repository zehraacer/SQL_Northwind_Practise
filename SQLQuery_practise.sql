SELECT * FROM Products;

SELECT * FROM Suppliers;

CREATE VIEW view_orders_by_date_and_country AS
SELECT * FROM Orders WHERE CustomerID IN (
    SELECT CustomerID FROM Customers
    WHERE Country = 'Germany'
    OR Country = 'UK'
    AND OrderDate >= '1998-01-01'
);

SELECT * FROM view_orders_by_date_and_country;

SELECT DATEDIFF(DAY, '2017/08/25', '2022/08/21') AS datediff;

SELECT FirstName, 
       LastName, 
       TitleOfCourtesy,
       DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age,
       DATEDIFF(YEAR, BirthDate, HireDate) AS Duration
FROM Employees;

SELECT Orders.OrderID,
       SUM([Order Details].Quantity * [Order Details].UnitPrice) AS TotalPrice,
       STRING_AGG(CONVERT(VARCHAR(MAX), [Order Details].ProductID), ' - ') AS ProductIDs,
       STRING_AGG(CONVERT(VARCHAR(MAX), [Order Details].Quantity), ' - ') AS Quantities
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY Orders.OrderID;

FROM Orders 
INNER JOIN [Order Details]
ON Orders.OrderID = [Order Details].OrderID
GROUP BY Orders.OrderID
ORDER BY OrderID;

SELECT TOP 10
    O.OrderID,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalPrice,
    STRING_AGG(CONVERT(VARCHAR(MAX), OD.ProductID), ' - ') AS ProductIDs,
    STRING_AGG(CONVERT(VARCHAR(MAX), OD.Quantity), ' - ') AS Quantities
FROM Orders O 
INNER JOIN [Order Details] OD 
ON O.OrderID = OD.OrderID
GROUP BY O.OrderID
ORDER BY TotalPrice DESC;

-- Be careful!! When using GROUP BY, we need to be very careful.
-- In the SELECT statement, we must either include the columns in the GROUP BY clause,
-- or if we are not including these columns in the GROUP BY clause,
-- we must use them in the SELECT statement with aggregate functions like AVG, SUM, MAX, MIN, etc.

SELECT TOP 10
    O.OrderID,
    O.ShipCountry,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalPrice,
    STRING_AGG(CONVERT(VARCHAR(MAX), OD.ProductID), ' - ') AS ProductIDs,
    STRING_AGG(CONVERT(VARCHAR(MAX), OD.Quantity), ' - ') AS Quantities
FROM Orders O 
INNER JOIN [Order Details] OD 
ON O.OrderID = OD.OrderID
GROUP BY O.OrderID, O.ShipCountry
ORDER BY TotalPrice DESC;

SELECT OrderID, UnitPrice
FROM [Order Details]
GROUP BY OrderID, UnitPrice
ORDER BY OrderID;

SELECT * FROM Shippers;

SELECT Orders.OrderID, 
       Orders.CustomerID, 
       Customers.ContactTitle, 
       Customers.ContactName,
       Shippers.CompanyName
FROM Orders
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
INNER JOIN Shippers
ON Orders.ShipVia = Shippers.ShipperID;

SELECT Orders.OrderID, 
       Orders.CustomerID, 
       Customers.ContactTitle, 
       Customers.ContactName,
       Shippers.CompanyName
FROM Orders
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
JOIN Shippers
ON Orders.ShipVia = Shippers.ShipperID;

SELECT Orders.OrderID, 
       Orders.CustomerID, 
       Customers.ContactTitle, 
       Customers.ContactName,
       Shippers.CompanyName
FROM Orders
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
INNER JOIN Shippers
ON Orders.ShipVia = Shippers.ShipperID
ORDER BY CompanyName;

SELECT ShipVia, COUNT(*) 
FROM Orders 
GROUP BY ShipVia;

SELECT Shippers.CompanyName, COUNT(*) AS 'Total Number of Orders'
FROM Orders
INNER JOIN Shippers
ON Orders.ShipVia = Shippers.ShipperID
GROUP BY Shippers.CompanyName;

--1. Find the total number of orders/sales made by all sales employees.
--2. Find the sales employees who handled more than 100 orders.

--1.
SELECT Employees.EmployeeID, COUNT(Orders.OrderID)
FROM Orders
INNER JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY Employees.EmployeeID
--2
HAVING COUNT(Orders.OrderID) > 100; -- For more than 100

--2nd Method
SELECT Employees.FirstName + ' ' + Employees.LastName AS 'Salesman', COUNT(*) AS 'Total Sales'
FROM Orders
INNER JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID 
GROUP BY Employees.FirstName + ' ' + Employees.LastName
-- HAVING COUNT(Orders.OrderID) > 100;