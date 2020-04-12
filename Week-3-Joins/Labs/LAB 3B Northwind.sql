-- 1. What is the order number and the date of each order sold by each employee?

select o.orderid, o.orderdate, e.employeeid, e.firstname + ' ' + e.lastname AS EmployeeName
from employees e inner join orders o
on e.employeeid = o.employeeid 
order by o.OrderID;


-- 2. List each territory by region

select t.territoryid, t.territorydescription, t.regionid, r.regiondescription
from territories as t
inner join region as r
on r.regionid = t.regionid
order by r.regiondescription;


-- 3. What is the supplier name for each product alphabetically by supplier?

select s.supplierid, s.companyname, p.productid, p.productname
from suppliers s
inner join products p
on s.supplierid = p.supplierid
order by s.companyname, p.productname;


-- 4. From every order on may 5, 1998, how many of each item was ordered, and what was the price of the item?

select o.orderdate, o.OrderID, od.quantity, od.UnitPrice
from orders o
inner join [Order Details] od
on o.orderid = od.orderid
where o.orderdate = '1998-05-05';


-- 5. For every order in May 5, 1998, how many of each item was ordered giving the name of the item, and what was the price of the item?

select o.orderdate, p.productname, od.quantity, p.UnitPrice,  (p.UnitPrice * od.quantity) AS totalPrice
from orders o
inner join [Order Details] od
on o.orderid = od.orderid
inner join products p
on p.productid = od.productid
where o.orderdate = '1998-05-05'


-- 6. For every order in May, 1998, what was the customer's name and the shipper's name

select o.orderdate, o.orderid, c.CompanyName AS CustomerName, s.companyname as ShipperName
from orders o
inner join shippers s on o.shipperid = s.shipperid
inner join customers c on o.customerid =  c.customerid
where o.orderdate >= '1998-05-01' AND o.OrderDate < '1998-06-01';


-- 7. What is the customer's name and the employee's name for every order shipped to France?

select o.orderid, o.shipcountry, c.companyname AS CustomerName, e.firstname + ' ' + e.lastname AS EmployeeName
from orders o
inner join customers c
on o.customerid = c.customerid
inner join employees e
on o.employeeid = e.employeeid
where o.shipcountry = 'France' 
order by c.companyname;


-- 8. List the products by name that were shipped to Germany.

select p.productname, o.shipcountry
from products p
inner join [Order Details] od
on p.productid = od.productid
inner join orders o
on od.orderid = o.orderid
where o.shipcountry = 'Germany' 
order by p.productname;