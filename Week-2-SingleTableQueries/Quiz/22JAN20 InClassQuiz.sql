SELECT orderID, sum(unitprice*quantity) as [Total Sum]
FROM [Order Details]
GROUP BY OrderID
HAVING sum(unitprice*quantity) > 30
ORDER BY [Total Sum] desc;