--1. Create a list of every country where we have either a customer or a supplier (UNION)
SELECT Country FROM Customers
UNION
SELECT Country FROM Suppliers

--2. list of every city and country where we have either a customer or a supplier
SELECT City, Country FROM Customers
UNION
SELECT City, Country FROM Suppliers
ORDER BY City;

--3. list of every country where we have both a customer and a supplier
SELECT Country FROM Customers
INTERSECT
SELECT Country FROM Suppliers

--4. list of every city and country where we have both
SELECT City, Country FROM Customers
INTERSECT
SELECT City, Country FROM Suppliers
ORDER BY City;

--5. list of every country have customers but not supplier
SELECT Country FROM Customers
EXCEPT
SELECT Country FROM Suppliers

--6. list of every country with suppliers but no customers
SELECT Country FROM Suppliers
EXCEPT
SELECT Country FROM Customers