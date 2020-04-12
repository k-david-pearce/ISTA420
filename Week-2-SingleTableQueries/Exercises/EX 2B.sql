--EX 2B - PG 93

--EXERCISE 1
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate >= '20150601' 
  AND orderdate < '20150701';

--EXERCISE 2
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate);