Create database users;

use users;


create table tblUsers(
	id int primary key identity(1,1) Not null,
	username nvarchar(50) not null,
	email nvarchar(50) not null,
	userPassword BINARY(64) NOT NULL
)



Alter proc addToUsers
@username nvarchar(50),
@email nvarchar(50),
@userPassword NVARCHAR(50),
@responseMessage NVARCHAR(250) output

as 
begin

	
	Set nocount on

	Begin try

		Insert into tblUsers values(@username,@email,HASHBYTES('SHA2_512',@userPassword));

		Set @responseMessage = 'Success';
		
	End try

	Begin catch
		
        SET @responseMessage=ERROR_MESSAGE() 

	end catch
end


Declare @responseMessage Nvarchar(250) 
Exec addToUsers
	@username =N'Mashood',
	@email=N'mashood@abc.com',
	@userPassword =N'abcd1234',
	@responseMessage = @responseMessage output
	print @responseMessage 

 Select userPassword from tblUsers

