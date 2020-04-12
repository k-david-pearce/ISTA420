select orderid, orderdate, custid, empid 
from sales.orders 
where orderdate >= '20150601' 
AND orderdate < '20150701';

select orderid, orderdate, custid, empid 
from sales.orders
where orderdate = EOMONTH(orderdate);

SELECT empid, firstname, lastname from HR.Employees where lastname LIKE '%e%e%';