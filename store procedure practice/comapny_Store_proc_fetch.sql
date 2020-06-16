--get Comapnies Store Proc
Use Company;


--get all comapnies
Create Proc spGetAllCompanies
@responseMessage varchar(50) output
as
begin
	set nocount on;
	begin try
		Select * from tblCompanys;
		
		set @responseMessage = 'Success';
	end try
	begin catch
	Set @responseMessage = Error_Message();
	end catch

end

Declare @responseMessage varchar(50) 
EXEC spGetAllCompanies @responseMessage output
print @responseMessage