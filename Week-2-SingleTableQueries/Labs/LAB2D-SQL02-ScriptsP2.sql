SELECT CustomerID, CompanyName, Country FROM Customers WHERE Country = 'Canada' OR Country = 'USA' OR Country = 'Mexico'
ORDER BY  Country;

SELECT CustomerID, CompanyName, Country FROM Customers WHERE Country IN ('Canada', 'Mexico', 'USA')
ORDER BY  Country;


SELECT * FROM Orders where OrderDate LIKE ('%1998-04%'); # where orderdate >= '19980401' and orderdate < '19980501';

SELECT * FROM Orders where MONTH (OrderDate) = 4 AND YEAR (OrderDate) = 1998 ORDER BY OrderDate;




