--1.List the employees' names and birthdates.
select FirstName, BirthDate from Employees;  --1

--2.List the number of products in each category.
select c.CategoryName, count(p.ProductID) as CountProduct 
from Categories c  
JOIN Products p ON p.CategoryID = C.CategoryID                   --2
group by  c.CategoryName;

--3.List the suppliers' names and cities.
select ContactName, City from Suppliers;       --3

--4.List the products' names, stock quantities, and reorder levels.
select ProductName,UnitsInStock, ReorderLevel from Products; --4

--5.Get the list of customers in the USA.
select ContactName, Country from Customers where Country = 'USA'; --5

--6.List the employees' last names and the total number of orders each employee has received.
select e.FirstName, e.LastName, Count(o.OrderID) as TotalSales
from Employees e
join Orders o on o.EmployeeID = e.EmployeeID            --6
Group by e.FirstName, e.LastName;

--7.List the names and stock quantities of products with prices greater than 10.
Select ProductName, UnitsInStock, UnitPrice from Products where Unitprice > 10; --7

--8.List which customers each employee has placed orders for.
select e.EmployeeID, e.FirstName, e.LastName, c.ContactName
from Employees e  
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN Customers c ON o.CustomerID = c.CustomerID   --8
ORDER BY
    e.EmployeeID, c.CustomerID;          

--9.Calculate the total sales amount (quantity * unit price) from orders.
select p.ProductName, SUM(od.Quantity * od.UnitPrice) as TotalOrderAmount 
from Products p
join [Order Details] od on p.ProductID = od.ProductID      --9
group by p.ProductName;

--10.List the most 8 expensive products in each category.
select top 8 p.ProductName, c.CategoryName, UnitPrice
from Categories c
join Products p on p.CategoryID = c.CategoryID           --10
group by p.ProductName, c.CategoryName, UnitPrice
Order by UnitPrice desc;

--11.Find the top 3 products with the highest number of orders.
select top 3 p.ProductID, p.ProductName, COUNT(od.OrderID) AS OrderCount
from Products p
join [Order Details] od on p.ProductID = od.ProductID            --11
group by p.ProductID, p.ProductName
Order by OrderCount desc;

--12.Calculate the average age of employees.
select FirstName, LastName, AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) AS AverageAge   --12
from Employees
GROUP BY FirstName, LastName;

--13.List each customer's total order amount and the month with the highest number of orders.
select top 5 c.customerID, c.ContactName, 
SUM(od.Quantity * od.UnitPrice) AS TotalOrderAmount, DATEPART(MONTH, o.OrderDate) as OrderMonth
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join [Order Details] od on o.OrderID = od.OrderID                                --13
Group by c.customerID, c.ContactName, DATEPART(MONTH, o.OrderDate)
order by TotalOrderAmount DESC;

--14.Calculate the total quantity of products sold and the total sales amount for each employee.
select e.EmployeeID, e.FirstName, e.LastName,
SUM(od.Quantity) AS TotalQuantitySold,
SUM(od.Quantity * od.UnitPrice) AS TotalSell
from Employees e                                                   --14
join Orders o on e.EmployeeID = o.EmployeeID
join [Order Details] od on o.OrderID = od.OrderID  
Group by e.EmployeeID, e.FirstName, e.LastName;

--15.Find the top 3 suppliers with the highest sales revenue.
SELECT top 3 s.SupplierID, s.CompanyName, SUM(od.Quantity * od.UnitPrice) AS TotalSalesRevenue
FROM Suppliers s 
JOIN Products p ON s.SupplierID = p.SupplierID
JOIN [Order Details] od ON p.ProductID = od.ProductID              			--15
GROUP BY s.SupplierID, s.CompanyName
ORDER BY TotalSalesRevenue DESC;