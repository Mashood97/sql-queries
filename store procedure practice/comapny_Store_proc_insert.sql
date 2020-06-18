create Database Company;

use Company;

--Insert and see data at that time..


Create table tblCompanys(
id int primary key identity(1,1),
companyName varchar(50),
companyTotalEmp int,

);


Alter Proc spAddToCompanys
@companyName varchar(50),
@companyTotalEmp int,
@Deptno int,
@responseMessage NVARCHAR(250) output
as
begin 
	Set nocount on

	Begin try
	Insert into tblCompanys 
	Output Inserted.id,@companyName as CompanyName,@companyTotalEmp as TotalEmployees,@Deptno as DepartmentNo
	Values(@companyName,@companyTotalEmp,@Deptno)
	Set @responseMessage = 'Success'
	end try

	begin catch
	 SET @responseMessage=ERROR_MESSAGE() 
	end catch
	
end



Declare @responseMessage Nvarchar(250) 
EXEC spAddToCompanys @companyName= 'Shangrilla Foods Industries',@companyTotalEmp = 15,@Deptno = 9,@responseMessage = @responseMessage output
	print @responseMessage ;


Drop table tblCompany;
Delete  from tblCompanys where id Between 1002 AND 
1005

