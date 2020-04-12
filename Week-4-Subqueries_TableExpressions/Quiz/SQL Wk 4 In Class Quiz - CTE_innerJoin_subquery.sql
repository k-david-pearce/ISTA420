-- List the product name and the number of each product from a German supplier sold to a customer in Germany 
-- using a CTE. Sort high to low. Use INNER JOIN.

WITH German_Customers_CTE
AS
(SELECT Products.productName, count(Orders.CustomerID) totalNumbers 
FROM Orders INNER JOIN Customers ON customers.CustomerID = orders.CustomerID
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
WHERE customers.country = 'Germany'
group by Products.productName)
SELECT * FROM German_Customers_CTE ORDER BY totalNumbers DESC;

-- Create a query that returns every distinct customer/employee pair. Use that query to write another query returning 
-- the customerid, customername, and customercontact, and employeeid, firstname, and lastname

SELECT Customers.CustomerID, CompanyName, ContactName, Employees.EmployeeID, FirstName, LastName
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
WHERE EXISTS
(SELECT DISTINCT customerID, employeeID from Orders);
