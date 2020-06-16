use SampleDb


create table Employee(
 Empno int primary key identity(1,1),
 Ename nvarchar(50),
 Sal int,
 Deptno int
);

ALTER TABLE Employee
ALTER COLUMN Ename varchar(50);


ALTER TABLE  Employee 
Rename Ename TO EmployeeName;


EXEC sp_rename 'Employee.Ename', 'EmployeeName', 'COLUMN';



Insert into Employee values('Mashood',45000,10);

Insert into Employee values('Saad',20000,10);

Insert into Employee values('Zain',20000,10);

Insert into Employee values('Huzaifa',45000,10);

Insert into Employee values('Hasan',45000,10);

Insert into Employee values('Hani',25000,10);

Update Employee Set
Ename = 'Urooj' Where Empno = 4;


Select * from Employee;
