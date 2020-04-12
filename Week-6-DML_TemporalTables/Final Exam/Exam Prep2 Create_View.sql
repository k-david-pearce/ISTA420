--using pet care db, create view called allMyDog that contains dogs only
--after you create the view, show your results from the view. order by petid

drop view allMyDog;

create view allMyDog as
select *
from dbo.Pets
where PetSpeciesID = 1;

select * from allMyDog
order by PetID;

