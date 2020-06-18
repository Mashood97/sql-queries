--get Comapnies Store Proc
Use Company;


--get all comapnies
Alter Proc spGetAllCompanies
@responseMessage varchar(50) output
as
begin
	set nocount on;
	begin try
		IF EXISTS (Select * from tblCompanys)
		BEGIN
			Select * from tblCompanys
			 set @responseMessage = 'Success';
		END
	ELSE
		BEGIN
			set @responseMessage = 'Failed';
		END
	end try
	begin catch
	set @responseMessage = ERROR_MESSAGE();
	end catch
end

Declare @responseMessage varchar(50) 
EXEC spGetAllCompanies @responseMessage output
print @responseMessage


Truncate table tblCompanys



Alter proc spGetCompanyById
@id int, @responseMessage varchar(50) output

as
begin 
	set nocount on;
	begin try

	IF EXISTS (Select * from tblCompanys where id = @id)
		BEGIN
			Select * from tblCompanys where id = @id
			 set @responseMessage = 'Success';
		END
	ELSE
		BEGIN
			set @responseMessage = 'Failed';
		END
	end try
	begin catch 
	set @responseMessage = ERROR_MESSAGE();
	end catch
end


Declare @id int,@responseMessage varchar(50)
EXEC  spGetCompanyById @id =2 , @responseMessage = @responseMessage output
print @responseMessage


--delete data from store proc
alter proc spDeleteFromCompany
@id int, @responseMessage varchar(50) output
as
begin
	
	set nocount on;
	begin try
	
	IF EXISTS (Select * from tblCompanys where id = @id)
		BEGIN
			Delete from tblCompanys where id = @id
			 set @responseMessage = 'Success';
		END
	ELSE
		BEGIN
			set @responseMessage = 'Failed';
		END
	end try

	begin catch
	set @responseMessage = ERROR_MESSAGE();

	end catch
end

Declare @id int,@responseMessage varchar(50)
EXEC  spDeleteFromCompany @id =12 , @responseMessage = @responseMessage output
print @responseMessage




