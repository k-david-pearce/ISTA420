-- 1. Create an appropriate table schema

drop table if exists dbo.presidents;
create table dbo.presidents
(ID varchar(100),LastName varchar(100),FirstName varchar(100),MiddleName varchar(100),OrderofPresidency varchar(100),DateofBirth varchar(100),DateofDeath varchar(100),TownorCountyofBirth varchar(100),StateofBirth varchar(100),HomeState varchar(100),PartyAffiliation varchar(100),DateTookOffice varchar(100),
DateLeftOffice varchar(100),AssassinationAttempt varchar(100),Assassinated varchar(100),ReligiousAffiliation varchar(100),ImagePath varchar(100));

-- 2. Insert the CSV data into the table you just created

bulk insert dbo.presidents from 'C:\Users\erau\Desktop\ISTA 420 SQL\Week 5\Exercises\EX 5C\UsPresidents.csv'
with
(
fieldterminator = ',',
rowterminator = '\n'
);

select * from dbo.presidents

-- 3. Delete the column that contains the path to the images

alter table dbo.presidents drop column ImagePath;

-- 4. Delete first record from table

delete top(1) from dbo.presidents;

-- 5. Bring data up to date by updating the last row. Use output clause

DECLARE @id varchar(100)
UPDATE dbo.presidents
SET @id = DateLeftOffice = '1/20/2017'
WHERE ID = 44;

-- 6. Bring data up to date by adding a new row. Use output clause

insert into dbo.presidents output inserted.*
values('45', 'Trump', 'Donald', 'John', '45', '6/14/1946', NULL, 'Queens', 'New York', 'New York', 'Republican', '1/20/2017', NULL, 'false', 'false', 'Christian');

-- 7. How many presidents from each state belonged to each political party? Aggregate by party and state

select HomeState, PartyAffiliation, count(*) as Tot
from dbo.presidents
group by HomeState, PartyAffiliation
order by Tot desc;

-- 8. Show number of days president was in office

SELECT OrderofPresidency, LastName, FirstName, DATEDIFF(DAY, DateTookOffice, DateLeftOffice) as DaysInOffice 
FROM dbo.presidents
ORDER BY DaysInOffice;

-- 9. Show age of each president when he took office.

SELECT OrderofPresidency, LastName, FirstName, DATEDIFF(Year, DateofBirth, DateTookOffice) as AgeofPresident 
FROM dbo.presidents
ORDER BY AgeofPresident;

-- 10. See if any correlation between party and religion.

select PartyAffiliation, ReligiousAffiliation, count(*) as Tot
from dbo.presidents
group by PartyAffiliation, ReligiousAffiliation
order by Tot desc;

Select * from dbo.presidents;

-- unknown below

alter table dbo.presidents add Seq int identity Primary Key;




GO
ALTER TABLE dbo.presidents
ALTER COLUMN DateTookOffice DATE
ALTER TABLE dbo.presidents
ALTER COLUMN DateofBirth DATE
ALTER TABLE dbo.presidents
ALTER COLUMN DateofDeath DATE NULL
ALTER TABLE dbo.presidents
ALTER COLUMN DateLeftOffice DATE NULL;

