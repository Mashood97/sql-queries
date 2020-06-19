Create database EcommerceApp

use EcommerceApp;

--signup for App.
Create table signupUser(
userId int primary key identity(1,1),
userEmail nvarchar(50),
userPassword nvarchar(max),
userName nvarchar(50),
userNumber nvarchar(50),
userDOB nvarchar(50),
userType nvarchar(50),
createdDateTime datetime,
);


--store proc for Signup

Alter Proc SignUpSetup
@userEmail nvarchar(50),
@userPassword nvarchar(max),
@userName nvarchar(50),
@userNumber nvarchar(50),
@userDOB nvarchar(50),
@userType nvarchar(50),
@createdDateTime datetime,
@responseMessage varchar(50) output


as

begin 
	set nocount on;
	set @createdDateTime = GETDATE();
	begin try
	IF EXISTS (Select userEmail from signupUser where userEmail = @userEmail)
		begin
			set @responseMessage = 'User Already Exist'; 
		end
	else
		begin
			Insert into signupUser 
			Output Inserted.userId,@userEmail as Email,@userPassword as userPassword,@userType as userType,@userName as UserName,
			@userNumber as PhoneNumber, @userDOB as DateOfBirth, @createdDateTime as CreatedDateTime

	values(@userEmail,@userPassword,@userName,@userNumber,@userDOB,@userType,@createdDateTime);
	
	set @responseMessage = 'Success';
		end
	end try

	begin catch
	set @responseMessage = 'Auth Failed'
		
	end catch
	
end

Declare @userEmail nvarchar(50),
@userPassword nvarchar(max),
@userName nvarchar(50),
@userNumber nvarchar(50),
@userDOB nvarchar(50),
@createdDateTime datetime,
@userType nvarchar(50),
@responseMessage varchar(50)

Exec SignUpSetup @userEmail = 'test1@abc.com', @userPassword='abcd1234',@userName='test',
@userNumber = '0335214564', @userDOB = '24-July-1955', @userType='User', @createdDateTime = @createdDateTime,
@responseMessage = @responseMessage output

print @responseMessage

select * from signupUser




--sign in store proc

alter proc signInSetup
 @userEmail nvarchar(50),
@userPassword nvarchar(max),
@responseMessage nvarchar(50) output 

as 

begin 
		set nocount on;
	begin try
		IF EXISTS (Select userEmail,userPassword,userType from signupUser 
		where userEmail = @userEmail and userPassword = @userPassword)
		begin
			Select * from signupUser;
			set @responseMessage = 'Login Success'
		end
		else
		begin 
			set @responseMessage = 'Login Failed'
		end

	end try


	begin catch
	set @responseMessage = 'Auth Failed'
	end catch
end



Declare @userEmail nvarchar(50), @userPassword nvarchar(max),@responseMessage varchar(50)
EXEC signInSetup @userEmail = 'test1@abc.com',@userPassword='abcd1234',@responseMessage = @responseMessage output
print @responseMessage





