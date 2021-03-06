---------------------------------------------------------------------
-- Script that creates the database TYFYS

---------------------------------------------------------------------
-- Create empty database TSQLV4
---------------------------------------------------------------------

-- For SQL Server box product use the steps in section A and then proceed to section C
-- For Azure SQL Database use the steps in section B and then proceed to section C

---------------------------------------------------------------------
-- Section A - for SQL Server box product only
---------------------------------------------------------------------

-- 1. Connect to your SQL Server instance, master database

-- 2. Run the following code to create an empty database called TSQLV4
USE master;

-- Drop database
IF DB_ID(N'TYFYS') IS NOT NULL DROP DATABASE TYFYS;

-- If database could not be created due to open connections, abort
IF @@ERROR = 3702 
   RAISERROR(N'Database cannot be dropped because there are still open connections.', 127, 127) WITH NOWAIT, LOG;

-- Create database
CREATE DATABASE TYFYS;
GO

USE TYFYS;
GO

-- 3. Proceed to section C

---------------------------------------------------------------------
-- Section B - for Azure SQL Database only
---------------------------------------------------------------------

/*
-- 1. Connect to Azure SQL Database, master database
USE master; -- used only as a test; will fail if not connected to master

-- 2. Run following if TSQLV4 database already exists, otherwise skip
DROP DATABASE TSQLV4; 
GO

-- 3. Run the following code to create an empty database called TSQLV4
CREATE DATABASE TSQLV4;
GO

-- 4. Connect to TSQLV4 before running the rest of the code
USE TSQLV4; -- used only as a test; will fail if not connected to TSQLV4
GO

-- 5. Proceed to section C
*/

---------------------------------------------------------------------
-- Populate database TSQLV4 with sample data
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Section C - for both SQL Server box and Azure SQL Database
---------------------------------------------------------------------

-- 1. Highlight the remaining code in the script file and execute

---------------------------------------------------------------------
-- Create Schemas
---------------------------------------------------------------------


CREATE SCHEMA HR AUTHORIZATION dbo;
GO
CREATE SCHEMA Store AUTHORIZATION dbo;
GO
CREATE SCHEMA Sales AUTHORIZATION dbo;
GO
CREATE SCHEMA Podcast AUTHORIZATION dbo;
GO

---------------------------------------------------------------------
-- Create Tables
---------------------------------------------------------------------

-- Create table Podcast.EpisodeDetails


-- Create table HR.Employees
CREATE TABLE HR.Employees
(
  empid           INT          NOT NULL IDENTITY,
  lastname        NVARCHAR(20) NOT NULL,
  firstname       NVARCHAR(10) NOT NULL,
  title           NVARCHAR(30) NOT NULL,
  titleofcourtesy NVARCHAR(25) NOT NULL,
  birthdate       DATE         NOT NULL,
  hiredate        DATE         NOT NULL,
  address         NVARCHAR(60) NOT NULL,
  city            NVARCHAR(15) NOT NULL,
  region          NVARCHAR(15) NULL,
  postalcode      NVARCHAR(10) NULL,
  country         NVARCHAR(15) NOT NULL,
  phone           NVARCHAR(24) NOT NULL,
  mgrid           INT          NULL,
  CONSTRAINT PK_Employees PRIMARY KEY(empid),
  CONSTRAINT FK_Employees_Employees FOREIGN KEY(mgrid)
    REFERENCES HR.Employees(empid),
  CONSTRAINT CHK_birthdate CHECK(birthdate <= CAST(SYSDATETIME() AS DATE))
);

CREATE NONCLUSTERED INDEX idx_nc_lastname   ON HR.Employees(lastname);
CREATE NONCLUSTERED INDEX idx_nc_postalcode ON HR.Employees(postalcode);

-- Create table Store.Suppliers
CREATE TABLE Store.Suppliers
(
  supplierid   INT          NOT NULL IDENTITY,
  companyname  NVARCHAR(40) NOT NULL,
  contactname  NVARCHAR(30) NOT NULL,
  contacttitle NVARCHAR(30) NOT NULL,
  address      NVARCHAR(60) NOT NULL,
  city         NVARCHAR(15) NOT NULL,
  region       NVARCHAR(15) NULL,
  postalcode   NVARCHAR(10) NULL,
  country      NVARCHAR(15) NOT NULL,
  phone        NVARCHAR(24) NOT NULL,
  fax          NVARCHAR(24) NULL,
  CONSTRAINT PK_Suppliers PRIMARY KEY(supplierid)
);

CREATE NONCLUSTERED INDEX idx_nc_companyname ON Store.Suppliers(companyname);
CREATE NONCLUSTERED INDEX idx_nc_postalcode  ON Store.Suppliers(postalcode);

-- Create table Store.Categories
CREATE TABLE Store.Categories
(
  categoryid   INT           NOT NULL IDENTITY,
  categoryname NVARCHAR(15)  NOT NULL,
  description  NVARCHAR(200) NOT NULL,
  CONSTRAINT PK_Categories PRIMARY KEY(categoryid)
);

CREATE NONCLUSTERED INDEX idx_nc_categoryname ON Store.Categories(categoryname);

-- Create table Store.Products
CREATE TABLE Store.Products
(
  productid    INT          NOT NULL IDENTITY,
  productname  NVARCHAR(40) NOT NULL,
  supplierid   INT          NOT NULL,
  categoryid   INT          NOT NULL,
  unitprice    MONEY        NOT NULL
    CONSTRAINT DFT_Products_unitprice DEFAULT(0),
  discontinued BIT          NOT NULL 
    CONSTRAINT DFT_Products_discontinued DEFAULT(0),
  CONSTRAINT PK_Products PRIMARY KEY(productid),
  CONSTRAINT FK_Products_Categories FOREIGN KEY(categoryid)
    REFERENCES Store.Categories(categoryid),
  CONSTRAINT FK_Products_Suppliers FOREIGN KEY(supplierid)
    REFERENCES Store.Suppliers(supplierid),
  CONSTRAINT CHK_Products_unitprice CHECK(unitprice >= 0)
);

CREATE NONCLUSTERED INDEX idx_nc_categoryid  ON Store.Products(categoryid);
CREATE NONCLUSTERED INDEX idx_nc_productname ON Store.Products(productname);
CREATE NONCLUSTERED INDEX idx_nc_supplierid  ON Store.Products(supplierid);

-- Create table Sales.Customers
CREATE TABLE Sales.Customers
(
  custid       INT          NOT NULL IDENTITY,
  email        NVARCHAR(40) NOT NULL,
  contactname  NVARCHAR(30) NOT NULL,
  contacttitle NVARCHAR(30) NOT NULL,
  address      NVARCHAR(60) NOT NULL,
  city         NVARCHAR(15) NOT NULL,
  region       NVARCHAR(15) NULL,
  postalcode   NVARCHAR(10) NOT NULL,
  country      NVARCHAR(15) NOT NULL,
  phone        NVARCHAR(24) NULL,
  fax          NVARCHAR(24) NULL,
  CONSTRAINT PK_Customers PRIMARY KEY(custid)
);

CREATE NONCLUSTERED INDEX idx_nc_city        ON Sales.Customers(city);
CREATE NONCLUSTERED INDEX idx_nc_postalcode  ON Sales.Customers(postalcode);
CREATE NONCLUSTERED INDEX idx_nc_region      ON Sales.Customers(region);

-- Create table Sales.Shippers
CREATE TABLE Sales.Shippers
(
  shipperid   INT          NOT NULL IDENTITY,
  companyname NVARCHAR(40) NOT NULL,
  phone       NVARCHAR(24) NOT NULL,
  CONSTRAINT PK_Shippers PRIMARY KEY(shipperid)
);

-- Create table Sales.Orders
CREATE TABLE Sales.Orders
(
  orderid        INT          NOT NULL IDENTITY,
  custid         INT          NULL,
  empid          INT          NOT NULL,
  orderdate      DATE         NOT NULL,
  requireddate   DATE         NOT NULL,
  shippeddate    DATE         NULL,
  shipperid      INT          NOT NULL,
  freight        MONEY        NOT NULL
    CONSTRAINT DFT_Orders_freight DEFAULT(0),
  shipname       NVARCHAR(40) NOT NULL,
  shipaddress    NVARCHAR(60) NOT NULL,
  shipcity       NVARCHAR(15) NOT NULL,
  shipregion     NVARCHAR(15) NULL,
  shippostalcode NVARCHAR(10) NULL,
  shipcountry    NVARCHAR(15) NOT NULL,
  CONSTRAINT PK_Orders PRIMARY KEY(orderid),
  CONSTRAINT FK_Orders_Customers FOREIGN KEY(custid)
    REFERENCES Sales.Customers(custid),
  CONSTRAINT FK_Orders_Employees FOREIGN KEY(empid)
    REFERENCES HR.Employees(empid),
  CONSTRAINT FK_Orders_Shippers FOREIGN KEY(shipperid)
    REFERENCES Sales.Shippers(shipperid)
);

CREATE NONCLUSTERED INDEX idx_nc_custid         ON Sales.Orders(custid);
CREATE NONCLUSTERED INDEX idx_nc_empid          ON Sales.Orders(empid);
CREATE NONCLUSTERED INDEX idx_nc_shipperid      ON Sales.Orders(shipperid);
CREATE NONCLUSTERED INDEX idx_nc_orderdate      ON Sales.Orders(orderdate);
CREATE NONCLUSTERED INDEX idx_nc_shippeddate    ON Sales.Orders(shippeddate);
CREATE NONCLUSTERED INDEX idx_nc_shippostalcode ON Sales.Orders(shippostalcode);

-- Create table Sales.OrderDetails
CREATE TABLE Sales.OrderDetails
(
  orderid   INT           NOT NULL,
  productid INT           NOT NULL,
  unitprice MONEY         NOT NULL
    CONSTRAINT DFT_OrderDetails_unitprice DEFAULT(0),
  qty       SMALLINT      NOT NULL
    CONSTRAINT DFT_OrderDetails_qty DEFAULT(1),
  discount  NUMERIC(4, 3) NOT NULL
    CONSTRAINT DFT_OrderDetails_discount DEFAULT(0),
  CONSTRAINT PK_OrderDetails PRIMARY KEY(orderid, productid),
  CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY(orderid)
    REFERENCES Sales.Orders(orderid),
  CONSTRAINT FK_OrderDetails_Products FOREIGN KEY(productid)
    REFERENCES Store.Products(productid),
  CONSTRAINT CHK_discount  CHECK (discount BETWEEN 0 AND 1),
  CONSTRAINT CHK_qty  CHECK (qty > 0),
  CONSTRAINT CHK_unitprice CHECK (unitprice >= 0)
);

CREATE NONCLUSTERED INDEX idx_nc_orderid   ON Sales.OrderDetails(orderid);
CREATE NONCLUSTERED INDEX idx_nc_productid ON Sales.OrderDetails(productid);

CREATE TABLE Podcast.EpisodeDetails
(
  EpisodeID      INT          NOT NULL IDENTITY,
  EpisodeName    NVARCHAR(20) NOT NULL,
  Producer       NVARCHAR(10) NOT NULL,
  Guest          NVARCHAR(30) NOT NULL,
  CONSTRAINT PK_Episodes PRIMARY KEY(EpisodeID),
);

CREATE NONCLUSTERED INDEX idx_nc_Producer   ON Podcast.EpisodeDetails(Producer);
CREATE NONCLUSTERED INDEX idx_nc_Guest   ON Podcast.EpisodeDetails(Guest);

-- Create table Podcast.EpisodePlay
CREATE TABLE Podcast.EpisodePlay
(
  EpisodeID      INT          NOT NULL IDENTITY,
  custid         INT          NOT NULL,
  playdate       DATE         NOT NULL,
  CONSTRAINT PK_EpisodePlay PRIMARY KEY(EpisodeID),
  CONSTRAINT FK_Orders_Customers FOREIGN KEY(custid)
    REFERENCES Sales.Customers(custid),
);

CREATE NONCLUSTERED INDEX idx_nc_EpisodeID   ON Podcast.EpisodePlay(EpisodeID);
CREATE NONCLUSTERED INDEX idx_nc_custid   ON Podcast.EpisodePlay(custid);
CREATE NONCLUSTERED INDEX idx_nc_playdate   ON Podcast.EpisodePlay(playdate);

-- Populate Tables
---------------------------------------------------------------------

SET NOCOUNT ON;

-- Populate table HR.Employees
SET IDENTITY_INSERT HR.Employees ON;
INSERT INTO HR.Employees(empid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, phone, mgrid)
  VALUES(1, N'Erickson', N'Allison', N'CEO', N'Mrs.', '19890923', '2020', N'431 West Hollywood Ave', N'San Antonio', N'TX', N'78212', N'USA', N'(210) 861-7464', NULL);
INSERT INTO HR.Employees(empid, lastname, firstname, title, titleofcourtesy, birthdate, hiredate, address, city, region, postalcode, country, phone, mgrid)
  VALUES(2, N'Pearce', N'Kyle', N'CTO', N'Mr.', '19860814', '2020', N'431 West Hollywood Ave', N'San Antonio', N'TX', N'78212', N'USA', N'(669) 282-8070', NULL);
  SET IDENTITY_INSERT HR.Employees OFF;

  -- Populate table Production.Suppliers
SET IDENTITY_INSERT Store.Suppliers ON;
INSERT INTO Store.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(1, N'Supplier SWRXU', N'Adams, Terry', N'Purchasing Manager', N'2345 Gilbert St.', N'London', NULL, N'10023', N'UK', N'(171) 456-7890', NULL);
INSERT INTO Store.Suppliers(supplierid, companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(2, N'Supplier VHQZD', N'Hance, Jim', N'Order Administrator', N'P.O. Box 5678', N'New Orleans', N'LA', N'10013', N'USA', N'(100) 555-0111', NULL);
SET IDENTITY_INSERT Production.Suppliers OFF;

  -- Populate table Production.Categories
SET IDENTITY_INSERT Store.Categories ON;
INSERT INTO Store.Categories(categoryid, categoryname, description)
  VALUES(1, N'Apparel', N'T-shirts, sweaters, hats');
INSERT INTO Store.Categories(categoryid, categoryname, description)
  VALUES(2, N'Accessories', N'Coffee mugs, beer mugs');
SET IDENTITY_INSERT Production.Categories OFF;

-- Populate table Production.Products
SET IDENTITY_INSERT Store.Products ON;
INSERT INTO Store.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(1, N'TYFYS T-Shirt', 1, 1, 15.00, 0);
INSERT INTO Store.Products(productid, productname, supplierid, categoryid, unitprice, discontinued)
  VALUES(2, N'TYFYS Coffee Mug', 2, 2, 10.00, 0);
SET IDENTITY_INSERT Production.Products OFF;

-- Populate table Sales.Customers
SET IDENTITY_INSERT Sales.Customers ON;
INSERT INTO Sales.Customers(custid, email, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(1, N'michael.allen@gmail.com', N'Allen, Michael', N'Sales Representative', N'Obere Str. 0123', N'Berlin', NULL, N'10092', N'Germany', N'030-3456789', N'030-0123456');
INSERT INTO Sales.Customers(custid, email, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
  VALUES(2, N'mark.hassall@yahoo.com', N'Hassall, Mark', N'Owner', N'Avda. de la Constitución 5678', N'México D.F.', NULL, N'10077', N'Mexico', N'(5) 789-0123', N'(5) 456-7890');
SET IDENTITY_INSERT Sales.Customers OFF;

-- Populate table Sales.Shippers
SET IDENTITY_INSERT Sales.Shippers ON;
INSERT INTO Sales.Shippers(shipperid, companyname, phone)
  VALUES(1, N'USPS', N'(503) 555-0137');
INSERT INTO Sales.Shippers(shipperid, companyname, phone)
  VALUES(2, N'FEDEX', N'(425) 555-0136');
SET IDENTITY_INSERT Sales.Shippers OFF;

-- Populate table Sales.Orders
SET IDENTITY_INSERT Sales.Orders ON;
INSERT INTO Sales.Orders(orderid, custid, empid, orderdate, requireddate, shippeddate, shipperid, freight, shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry)
  VALUES(1, 1, 1, '20200704', '20200801', '20200716', 2, 32.38, N'Ship to 85-B', N'6789 rue de l''Abbaye', N'Reims', NULL, N'10345', N'France');
INSERT INTO Sales.Orders(orderid, custid, empid, orderdate, requireddate, shippeddate, shipperid, freight, shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry)
  VALUES(2, 2, 1, '20200705', '20200816', '20200710', 1, 11.61, N'Ship to 79-C', N'Luisenstr. 9012', N'Münster', NULL, N'10328', N'Germany');
SET IDENTITY_INSERT Sales.Orders OFF;

-- Populate table Sales.OrderDetails
INSERT INTO Sales.OrderDetails(orderid, productid, unitprice, qty, discount)
  VALUES(1, 1, 15.00, 1, 0);
INSERT INTO Sales.OrderDetails(orderid, productid, unitprice, qty, discount)
  VALUES(2, 2, 10.00, 2, 0);
