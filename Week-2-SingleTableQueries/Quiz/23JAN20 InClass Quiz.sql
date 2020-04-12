--Q10--list products by name and unitprice that were shipped to mexico order by productname; mult joins

select productname, [order details].UnitPrice, shipcountry
from [Order Details] inner join Products on
products.ProductID = [Order Details].ProductID
inner join Orders on
[Order Details].OrderID = orders.OrderID
where ShipCountry = 'Mexico'
order by ProductName