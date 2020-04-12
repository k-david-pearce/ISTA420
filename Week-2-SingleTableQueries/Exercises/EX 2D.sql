--EX 2C - PG 94

--EXERCISE 5
SELECT empid, lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS LIKE N'[abcdefghijklmnopqrstuvwxyz]%';

-- EXERCISE 6
-- WHERE is a row filter. Returns number of orders each employee processed prior to May 2016
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
WHERE orderdate < '20160501'
GROUP BY empid;

-- HAVING is a group filter. Returns number of orders processed by each employee who hasn't processed any orders since May 2016
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY empid
HAVING MAX(orderdate) < '20160501';