--when you're using any query again and again create store procedure of it and call it where u want.

create Proc spGetPeoples
As
begin
	
	Select * from peopleTbl;
end


-- to run store proc use this
	

EXEC spGetPeoples;


--parameterized input store procedures

create proc getPeople
@firstName varchar(50)
As 
begin
	
	Select * from peopleTbl where firstName = @firstName;
		
end
--getPeople 'Mashood'
 getPeople @firstName= 'Mashood'



 --to update the table through store procedure

 alter proc getPeople
@firstName varchar(50)
As 
begin
	
	Select * from peopleTbl where firstName = @firstName order by firstName;
		
end




--encryption store proc


alter  Proc spGetPeoples
With Encryption
As

begin
	
	Select * from peopleTbl;
end


--parametrized output store proc

create proc getCustomer
@custmName varchar(50),
@custmCount int output
as
begin
	
	Select @custmCount = Count(custmId) from customers where custmName=@custmName;
	
end


--to run output parameterized store proc:

Declare @totalCount int
Exec getCustomer 'Mashood',@totalCount output
print @totalCount




--store proc with return values.

create proc getTotalCount
as 
begin
return (Select Count(custmId) from customers);
end

Declare @count  int
EXECUTE @count = getTotalCount; 
print @count