select orderid, orderdate, firstname 
from Orders INNER JOIN Employees on
orders.EmployeeID = Employees.EmployeeID
order by OrderID, OrderDate;

select customers.CustomerID, customers.CompanyName
from customers inner join orders on
customers.CustomerID = orders.CustomerID
where datediff (month, OrderDate, '1996-07-15') = 0
and customers.CustomerID = orders.CustomerID;

select top 10 city, shipname, shipcity
from orders inner join Customers on
orders.CustomerID = customers.CustomerID
where (city = 'Berlin') or (city = 'Mexico d.f.')
order by city, shipname, shipcity;
---------same results----------
select top 10 city, shipname, shipcity
from orders inner join Customers on
orders.CustomerID = customers.CustomerID
order by shipname 

select territorydescription, regiondescription
from Territories inner join Region on
Territories.RegionID = region.RegionID
order by RegionDescription;

select companyname, productname, unitprice
from Suppliers cross join Products
order by companyname, productname;

--cross join--OR Venn Diagram
select unitprice, quantity, productid
from orders, [Order Details]
where orderdate = '1998-05-05'
order by ProductID;
-----compare results------
--inner join--AND Venn Diagram
select unitprice, quantity, productid
from orders inner join [Order Details] on
orders.OrderID = [Order Details].OrderID
where orderdate = '1998-05-05'
order by ProductID;

--select freight, quantity, city
--from orders inner join [Order Details] inner join Employees on
--Orders.OrderId = [Order Details].OrderID and orders.employeeid = employees.employeeid

select freight, quantity, city
from orders inner join [Order Details] on
Orders.OrderId = [Order Details].OrderID 
inner join employees on
orders.employeeid = employees.employeeid

select contactname, productname, unitprice
from suppliers cross join Products
-----
select contactname, productname, unitprice
from suppliers, Products

select productname, quantity, [Order Details].UnitPrice
from products inner join [Order Details] on
products.ProductID = [Order Details].ProductID
inner join Orders on
orders.OrderID = [Order Details].OrderID
where orderdate = '1998-05-05'
order by ProductName;

--Q10--list products by name and unitprice that were shipped to mexico order by productname; mult joins

select productname, [order details].UnitPrice, shipcountry
from [Order Details] inner join Products on
products.ProductID = [Order Details].ProductID
inner join Orders on
[Order Details].OrderID = orders.OrderID
where ShipCountry = 'Mexico'
order by ProductName

--Q11--Write C# program using methods that determins roots of quadratic formula ax^2+bx+c=0
-- be sure to include calculating determinent in your method. Must include dialogue with user asking input


