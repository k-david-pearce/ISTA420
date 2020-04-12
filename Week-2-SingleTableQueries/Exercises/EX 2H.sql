--1. Mailing Labels
select concat(contacttitle, ' ', contactname, char(13), 
companyname, char(13),
address, char(13), 
city, ' ', customers.Region,' ', postalcode,' ', country,
char(13),char(13))
from customers;

--2. Telephone Book: Lastname, Firstname Middlename [tab] Company name [tab] phone number*/
select substring(contactname, charindex(' ', ContactName)+ 1, len(contactname)) as LastName,
left(ContactName,charindex(' ',ContactName + ' ')-1) as First_Name, 
' ' as Middle_Name,'', CompanyName, '',Phone 
from customers;

-- 3. Shipping Lag Report: the order number, the order date, the shipped date, and the diff_erence in days between the order date and the shipped date
select orderid, orderdate, shippeddate, DATEDIFF(day, orderdate, ShippedDate) as LagDays 
from orders where DATEDIFF(day, orderdate, ShippedDate) > 0;

--4. Your Age in years, months, weeks, days. Assume 365 days/year
select DATEDIFF(YEAR,'19860814', '20200301') as Years, DATEDIFF(Month,'19860814', '20200301') as Months, DATEDIFF(DAY,'19860814', '20200301') as Days,
DATEDIFF_BIG(HOUR,'19860814', '20200301') as Hour, DATEDIFF_BIG(MINUTE,'19860814', '20200301') as Minutes, DATEDIFF_BIG(SECOND,'19860814', '20200301') as Seconds;


