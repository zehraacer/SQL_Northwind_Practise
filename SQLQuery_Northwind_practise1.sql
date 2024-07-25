--1.List the full names of the employees.
select FirstName, LastName from Employees;  --1

--2.Retrieve the list of customers and their company names.
select ContactName, CompanyName from Customers; --2

--3.List the names and prices of the products.
select ProductName, UnitPrice from Products; --3

--4.List the cities and names of the employees.
select FirstName, City from Employees; --4

--5.Find the customers in the city of Stockholm.
select ContactName from Customers where city = 'Stockholm'; --5

--6.Find products with prices between 20 and 30.
select ProductName, UnitPrice from Products where UnitPrice between 20 and 30; -- 6

--7.Count the number of orders for each employee.
select EmployeeID, count(OrderID) as OrderCount From Orders group by EmployeeID; --7

--8.List products and their stock quantities in the 'Seafood' category.
select ProductName, UnitsInStock FROM Products where CategoryID = (select CategoryID from Categories where CategoryName = 'Seafood');--8

--9.Find the total number of orders by year.
SELECT YEAR(OrderDate) AS Year, count(OrderID) as OrderCount From Orders group by YEAR(OrderDate); --9

--10.List orders placed in the year 1996.
SELECT * From Orders where Year(OrderDate) = 1996; --10

--11.Find the top 5 customers with the most orders.
select top 5 CustomerID, count(OrderID) as CountOrder from Orders group by CustomerID ORDER BY CountOrder desc; --11

--12.Calculate the average product price in each category.
select p.CategoryID, c.CategoryName, AVG(p.UnitPrice) as AvgPrice 
from Products p 
JOIN Categories c ON p.CategoryID = c.CategoryID                        --12
group by p.CategoryID, c.CategoryName;

--13.Calculate the total quantity of products sold by each employee.
SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(od.Quantity) as TotalProductsSold
FROM Employees e 
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID                         --13
GROUP BY e.EmployeeID, e.FirstName, e.LastName;

--14.Rank the suppliers by the total quantity of products they have sold.
SELECT p.SupplierID, s.CompanyName, COUNT(o.OrderID) as CountSales
FROM Products p 
JOIN Suppliers s ON p.SupplierID = s.SupplierID
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID                         --14
GROUP BY p.SupplierID, s.CompanyName
ORDER BY CountSales DESC;

--15.Find the product with the highest sales.
SELECT p.ProductID, p.ProductName, SUM(od.Quantity) as TotalProductsSold
FROM Products p 
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID              			--15
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalProductsSold DESC;
