
create database joinPractice;
use joinPractice


Create table Customer(
	CustmId int primary key Identity(1,1),
	custmName varchar(50),
);


Insert into Customer values('Mashood');

Insert into Customer values('Huzaifa');

Insert into Customer values('Hasan');

Insert into Customer values('Salman');

Insert into Customer values('Zain');


Select * from Customer;


create table Products(
	prodId int primary key identity(1,1),
	prodName varchar(50),

);


Insert into Products values('Laptop');


Insert into Products values('Gaming console');

Insert into Products values('Ps4');

Insert into Products values('Pc computer');

Insert into Products values('Led');







create table Orders(
	orderId int primary key identity(1,1),
	CustmId int Foreign key References Customer(CustmId),
	 prodId int Foreign key References Products(prodId),
	price float,
);


Insert into Orders values(1,3,225.0);
Insert into Orders values(3,4,220.0);





Select * from Orders;

Select * from Products;
Select * from Customer;


--this inner join or join returns the common data among both the tables.
Select * from Customer Inner join Orders on  Customer.CustmId = Orders.CustmId; 


-- left join or left outer join returns the matching as well as non matching data from first table.

Select * from Customer left join Orders on Customer.custmId = Orders.orderId;


--right outer join is the vice versa case of left outer join, outer is an optional keyword in both cases.

Select * from Customer right join Orders on Customer.custmId = Orders.orderId;

--full outer join or full join returns all matching and non matching data from both tables.

Select * from Customer full join Orders on Customer.custmId = Orders.orderId;


--cross join produces cartesian product between both the tables i.e multiple both tables

Select * from Customer cross join Orders; 
--it returns 10 because we have 5 data in one table and
-- 2 in another after * we have 10, 5*2 =10
-- it takes all the data from right table and associate it with every element of left table.
--in our case two orders which we assigned is associated to every member of customer table.



/*
Joins Generic formula not for cross join:

Select		ColumnList
From		left-table
joins		right table
on			join condition
*/










