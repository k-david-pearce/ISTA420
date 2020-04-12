--write query to retrieve freight from orders table, qty from order details, city from employee. Use NW DB

select freight, quantity, city
from orders as o
inner join employees as e on o.EmployeeID = e.EmployeeID
inner join [Order Details] as OD on OD.OrderID = o.OrderID
order by City

