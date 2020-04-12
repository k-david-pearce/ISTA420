--Q3: Use Northwind. Write a query to get product list (id, name, unit price) of above average price. Use Subquery
select productid, productname, unitprice
from dbo.Products
where UnitPrice >
(select avg(UnitPrice) from dbo.Products)

--This line computes the average price
select avg(UnitPrice) from dbo.Products


--Q4: Return all contactnames, and any orders they might have. retrieve top 20 rows.
SELECT Top(20) ContactName, OrderID
FROM dbo.Customers full outer join dbo.Orders ON
Customers.CustomerID = Orders.CustomerID
ORDER BY ContactName