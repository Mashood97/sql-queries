/*coalesce function which checks if first value is null then get second value if 
second is null then get the third value and if all is given then get first value also 
if two are given then get the first. */


 Create database people;

 use people



 create table peopleTbl(
	
	id int primary key identity(1,1),
	firstName varchar(50),
	middleName varchar(50),
	lastName varchar(50)
);


Insert into peopleTbl values('Mashood',null,null);

Insert into peopleTbl values(null,'saad',null);

Insert into peopleTbl values(null,null,'zain');

Insert into peopleTbl values('Mashood','saad',null);


Insert into peopleTbl values('Mashood',null,'lhan');

Insert into peopleTbl values('Mashood','saad','khan');


Select * from peopleTbl;

Select id, Coalesce(firstName,middleName,lastName) as Name from peopleTbl;

/*
this checks if first name is given in every condition then get the first name else get the 
given name.
*/


