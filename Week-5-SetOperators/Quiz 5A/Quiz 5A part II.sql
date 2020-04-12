--Q3. Update pets table with following data
INSERT INTO Pets (PetID, PetName, PetSpeciesID, Birthday, Notes)
VALUES
(1, 'Buddy', 1, '2018-01-01', 'Dog-Boxer'),
(2, 'Sasha', 1, '2000-12-16', 'Dog-Miniature Schnauzer'),
(3, 'Elmore', 2, '2009-07-04', 'Cat-Persian'),
(4, 'Max', 1, '2020-01-01', 'Dog-German Shepard'),
(5, 'Milo', 2, '2019-01-01', 'Cat-Siamese');

select * from Pets

--Q3 a) retrieve name in alphabetical order using offset (2 rows)-Fetch(next 3 rows) to returns rows
--Q3 b) update pet name Elmore's birthday to 2019-07-04

SELECT PetName
FROM Pets
ORDER BY PetName
OFFSET 2 ROWS
FETCH Next 3 rows only;

UPDATE Pets
SET Birthday = '2019-07-04'
WHERE PetName = 'Elmore';
select * from Pets;

--Q4.a) create a table called facility with the following info:

CREATE TABLE Facility
(
FacilityID int,
FacilityName VARCHAR(255),
FacilityAddress VARCHAR(255),
Phone VARCHAR(255),
Email VARCHAR(255),
ContactPerson VARCHAR(255),
)

--4.b) *See object explorer at left*

--4.c)
INSERT INTO Facility(FacilityID, FacilityName, FacilityAddress, Phone, Email, ContactPerson)
VALUES
(1, 'White House', '12345 White House Drive', '1234567', 'bigdon@usa.com','Donald'),
(2, 'Pentagon', '12345 Pentagon Circle', '2345678', 'bangbang@pewpew.com','Milley'),
(3, 'CIA', '12345 Sneaky Trail', '3456789', 'nocomment@delete.com', 'Haspel');

--4.d)
UPDATE Pets
SET Birthday = '2019-01-01'
WHERE PetName = 'Max';
select * from Pets;

--4.c)
SELECT * FROM Facility

--4.e) Use windows function to write query to genereate 
SELECT count(*) over (partition by month(Birthday), year(Birthday)) as numPerMonth, 
DATENAME(month, Birthday)+''+DATENAME(year, Birthday) As TheMonth,
PetName
FROM Pets
order by PetName;

--4.f) Write query to generate following: Use JOIN and SET operator INTERSECT
SELECT PetName, Birthday
FROM Pets
LEFT OUTER JOIN PetOwner
ON Pets.PetID = PetOwner.PetID
INTERSECT
SELECT PetName, Birthday
FROM Pets
RIGHT OUTER JOIN PetOwner
ON Pets.PetID = PetOwner.PetID

select * from PetOwner

