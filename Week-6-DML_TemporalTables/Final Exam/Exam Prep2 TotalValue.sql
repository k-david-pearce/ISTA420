--write query against order details that returns orders with a total value (qty * price) < 10k sort total value
--almost correct
select orderid, unitprice
from sales.OrderDetails
where (qty * unitprice) < 10000 
order by unitprice desc

--correct
select *, (qty*unitprice) as TotalValue
from sales.OrderDetails
where (qty*unitprice) < 10000
order by totalvalue desc;

--incorrect
select sum(qty*unitprice) as totalvalue, orderid
from sales.OrderDetails
group by orderid
having sum (qty*unitprice) < 10000
order by totalvalue desc

