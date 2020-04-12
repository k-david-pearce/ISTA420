-- 1-1. Create a system-versioned temporal table called Departments 

CREATE TABLE dbo.Departments
(
deptid INT NOT NULL
CONSTRAINT PK_Departments PRIMARY KEY,
deptname VARCHAR(25) NOT NULL,
mgrid INT NOT NULL,
validfrom DATETIME2(0)
GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
validto DATETIME2(0)
GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
PERIOD FOR SYSTEM_TIME (validfrom, validto)
)
WITH ( SYSTEM_VERSIONING = ON ( HISTORY_TABLE = dbo.DepartmentsHistory ) );

-- 1-2. Identify the Departments table and its associated history table in Object Explorer 


-- 2-1. Insert four rows to the table Departments and note the time when you apply this insert (call it P1):

SELECT CAST(SYSUTCDATETIME() AS DATETIME2(0)) AS P1;
INSERT INTO dbo.Departments(deptid, deptname, mgrid)
VALUES(1, 'HR' , 7 ),
(2, 'IT' , 5 ),
(3, 'Sales' , 11),
(4, 'marketing', 13);

-- 2-2. Update the name of department 3 to Sales and Marketing and delete department 4. Note the time and call it P2.

SELECT CAST(SYSUTCDATETIME() AS DATETIME2(0)) AS P2;
BEGIN TRAN;
UPDATE dbo.Departments
SET deptname = 'Sales and Marketing'
WHERE deptid = 3;
DELETE FROM dbo.Departments
WHERE deptid = 4;
COMMIT TRAN;

-- 2-3. Update the manager ID of department 3 to 13. Note the time and call it P3.
SELECT CAST(SYSUTCDATETIME() AS DATETIME2(0)) AS P3;
UPDATE dbo.Departments
SET mgrid = 13
WHERE deptid = 3;

-- 3-1. Query the current state of the table Departments
SELECT *
FROM dbo.Departments;

-- 3-2. Query the state of the table Departments at a point in time after P2 and before P3
SELECT *
FROM dbo.Departments
FOR SYSTEM_TIME AS OF '2016-02-18 10:29:00'; -- replace this with your time

-- 3-3. Query the state of the table Departments in the period between P2 and P3
SELECT deptid, deptname, mgrid, validfrom, validto
FROM dbo.Departments
FOR SYSTEM_TIME BETWEEN '2016-02-18 10:28:27' -- replace this with your P2
AND '2016-02-18 10:30:40'; -- replace this with your P3

-- 4. Drop the table Departments and its associated history table
ALTER TABLE dbo.Departments SET ( SYSTEM_VERSIONING = OFF );
DROP TABLE dbo.DepartmentsHistory, dbo.Departments;