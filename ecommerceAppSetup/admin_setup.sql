
use EcommerceApp;



---Admin maanges products , users, orders states etc


--table products:

create table tblProducts(
	productId int primary key identity(1,1),
	productName nvarchar(max),
	productDescription varchar(max),
	productImage varbinary(max),
	productType nvarchar(50),
	productPrice float,
);

Alter table tblProducts
Add StockQuantity int

Select * from tblProducts


--insert into products with store proc


create proc spAddProducts
@productName nvarchar(max),
@productDescription varchar(max),
@productImage varbinary(max),
@productType nvarchar(50),
@productPrice float,
@createdProductDatetime datetime,
@StockQuantity int,
@responseMessage varchar(50) output

as 
begin 
	set nocount on;
	set @createdProductDatetime = GETDATE();
	begin try
	Insert into tblProducts 
			Output Inserted.productId,@productName as ProductName,@productDescription as productDescription,
			@productImage as productImage,@productType as productType,
			@productPrice as productPrice, @createdProductDatetime as productCreatedDateTime, 
			@StockQuantity as stockQuantity

	values(@productName,@productDescription,@productImage,@productType,@productPrice,@createdProductDatetime,@StockQuantity);
	
	set @responseMessage = 'Product Added Successfully';
	
	end try
	
	begin catch
	set @responseMessage = 'Adding Product Failed'

	end catch
end 


Declare @productName nvarchar(max),
@productDescription varchar(max),
@productImage varbinary(max),
@productType nvarchar(50),
@productPrice float,
@createdProductDatetime datetime,
@StockQuantity int,
@responseMessage varchar(50)

EXEC spAddProducts
@productName='Test Product', @productDescription = 'A test product', @productImage=1,@productType='Test',
@productPrice = 25.33,@createdProductDatetime = @createdProductDatetime, @StockQuantity = 10,
@responseMessage = @responseMessage output
print @responseMessage;



--store proc to get all the products according to date time

Alter proc spGetAllProducts
@responseMessage varchar(50) output
as
begin 
	set nocount on;
	begin try
		IF EXISTS (Select * from tblProducts)
			begin 
				Select * from tblProducts;
				set @responseMessage = 'Success';
			end
		else
			begin
				set @responseMessage = 'No Product Found'; 
			end
	
	end try

	begin catch
		 set @responseMessage = 'Failed to retrieve products'
	end catch
end


Declare @responseMessage varchar(50)
exec spGetAllProducts @responseMessage = @responseMessage output
print @responseMessage

truncate table tblProducts
--get single product

alter proc spGetSingleProduct
@productId int,
@responseMessage varchar(50) output

as 

begin 
	set nocount on;
	begin try
	IF EXISTS (Select * from tblProducts where productId = @productId)
		begin	
			Select * from tblProducts where productId = @productId
			set @responseMessage = 'Product Fetched'
		end
	else 
		begin 
			set @responseMessage = 'No Product Found'; 
		end

	end try

	begin catch 
			set @responseMessage = 'Failed to retrieve products'
	end catch
end


Declare @productId int,@responseMessage varchar(50)
Exec spGetSingleProduct @productId = 1,@responseMessage = @responseMessage output
print @responseMessage



---get product under 24 hours i.e latest products

alter proc spGetLatestProducts

@responseMessage varchar(50) output

as

begin 
	set nocount on;
	begin try
	if EXISTS(SELECT * FROM tblProducts WHERE createdProductDatetime >= DATEADD(day, -1, GETDATE()))
		begin
			SELECT * FROM tblProducts WHERE createdProductDatetime >= DATEADD(day, -1, GETDATE())
			set @responseMessage = 'Products Fetched'
		end

	else
		begin	
			set @responseMessage = 'No Product Found';
		end
	end try

	begin catch 
			set @responseMessage = 'Failed to retrieve products'
	end catch
	
end

Declare
@responseMessage varchar(50)

Exec spGetLatestProducts  @responseMessage = @responseMessage output
print @responseMessage;



--update product
Create proc spUpdateProduct
@productId int,
@productName nvarchar(max),
@productDescription varchar(max),
@productImage varbinary(max),
@productType nvarchar(50),
@productPrice float,
@createdProductDatetime datetime,
@StockQuantity int,
@responseMessage varchar(50) output

as

begin
	set nocount on;
	set @createdProductDatetime = GETDATE();
	begin try
		IF EXISTS (Select * from tblProducts where productId = @productId)
			begin
				update tblProducts set productName = @productName, productDescription = @productDescription,
				productImage = @productImage, productType = @productType,productPrice = @productPrice,
				StockQuantity = @StockQuantity where productId = @productId;

				set @responseMessage = 'Product updated Successfully'
			end
		else
			begin 
			set @responseMessage ='Product Not Found';
			end
	end try

	begin catch
		set @responseMessage = 'Failed'
	end catch
end


Declare
@productId int,
 @productName nvarchar(max),
@productDescription varchar(max),
@productImage varbinary(max),
@productType nvarchar(50),
@productPrice float,
@createdProductDatetime datetime,
@StockQuantity int,
@responseMessage varchar(50)

EXEC spUpdateProduct
@productId = 2,
@productName='Test Product1', @productDescription = 'A test product1', @productImage=2,@productType='Test',
@productPrice = 25.33,@createdProductDatetime = @createdProductDatetime, @StockQuantity = 20,
@responseMessage = @responseMessage output
print @responseMessage;


--Delete a product


Alter proc spDeleteProduct
@productId int,
@responseMessage varchar(50) output

as

begin
		set nocount on;
	begin try
		IF EXISTS (Select * from tblProducts where productId = @productId)
		begin 
			Delete from tblProducts where productId = @productId;
			set @responseMessage = 'Product Deleted Successfully';
		end
		else
		begin 
			set @responseMessage= 'Cannot Find Product';
		end	
		end try

	begin catch 
			set @responseMessage= 'Failed deleting product';
	end catch
end


Declare @productId int,@responseMessage varchar(50)
Exec spDeleteProduct @productId = 2,@responseMessage = @responseMessage output
print @responseMessage