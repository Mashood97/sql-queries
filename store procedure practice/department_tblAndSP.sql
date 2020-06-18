


Create table Department(
Deptno int primary key identity(1,1),
DeptName varchar(50),
);



Alter table tblCompanys 
Add Deptno int Foreign key  References Department



Create Proc spInsertDepartment
@responseMessage varchar(50) output,
@DeptName varchar(50)
as 

begin
		set nocount on;
		begin try
			Insert into Department values(@DeptName);
			
			set @responseMessage = 'Success';
		end try
		
		begin catch
			
			Set @responseMessage = ERROR_MESSAGE();
		
		end catch
end

Declare @Deptname varchar(50), @responseMessage varchar(50) 
EXEC spInsertDepartment @Deptname = 'Civil Engineering', @responseMessage = @responseMessage output
print @responseMessage

Select * from Department