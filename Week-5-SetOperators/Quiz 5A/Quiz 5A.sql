--Q1. Write a Query that returns customer and employee pairs that had order activity in both January 2016 and February 2016
--TSQLV4, Orders Table; use set operators
--WHERE orderdate >= 20160101 AND orderdate <= 20160201
--INTERSECT
--WHERE orderdate >= 20160201 AND orderdate <= 20160301

--Desired Output:
--custid   empid
--20		3
--39		9
--46		5
--67		1
--71		4

SELECT custid, empid
FROM sales.Orders
WHERE orderdate >= '20160101' AND orderdate <= '20160201'
INTERSECT
SELECT custid, empid
FROM sales.Orders
WHERE orderdate >= '20160201' AND orderdate <= '20160301'

--Q2. Write a SQL statement returns the USA cities (duplicate values also) from both the "customers" and the "suppliers" table. Northwind. Set.

SELECT city 
FROM sales.Customers
WHERE country = 'USA'
UNION ALL
SELECT city
FROM production.Suppliers
WHERE country = 'USA'