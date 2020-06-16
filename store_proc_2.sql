create table customers(

custmId int primary key identity(1,1),
custmName varchar(50),
custmNumber nvarchar(50),
custmCountry varchar(50),
);


--insert into customers
create proc insertIntoCustomer
@custmName varchar(50), @custmNumber nvarchar(50), @custmCountry varchar(50)

as 
begin
	Insert into customers values(@custmName,@custmNumber,@custmCountry);

end

insertIntoCustomer 'Mashood','03352655824','Pakistan';


--get all customers

create proc getAllCustomers
as 
begin
	Select * from customers order by custmName;
end


getAllCustomers





