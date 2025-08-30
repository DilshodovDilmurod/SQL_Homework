1. 
bulk insert is Imports a data file into a database table or view in a user-specified format in SQL Server.
2.
.txt, .csv, .xlsx, .tsv
3.
create table Products (
ProductId int primary key,
ProductName  varchar(50),
Price decimal(10,2)
)
4.
insert into Products 
values (
1, 'Phone', 120.12),
(2, 'laptop', 230.52),
(3, 'mouse', 65)
5.
null is  no element and not null is least a element
6.
alter table Products 
add unique (ProductName)
7.
truncate table Products -- truncate is delete all data from table 
8.
alter table Products
add CategoryID int
9.
create table Categories (
CategoryID int primary key,
CategoryName varchar(20) unique 
)
insert into Categories
values (
2, 'animal'),
(5, 'fruicts'),
(4, 'cars')
10.
identity is to give generating key values 
11.
bulk insert Products
from 'C:\Users\dilmu\Desktop\import.txt'
with (firstrow=2, fieldterminator=',', rowterminator='\n')
12.
alter table Products
add constraint FK_Products_Categories 
foreign key (CategoryID)
references Categories (CategoryID)
13.
primary key  does not accept dublicate and null values. 
Only one primary key is allowed to be used in a table 
Unique key  is a table can have more than one unique key,
constraints can accepts only one nullvalues for the column
14.
alter table Products
add check (Price > 0)
15.
alter table Products
add Stock int not null default 0
16.
select ProductId, ProductName, isnull(Price, null) CategoryID, Stock  
from Products
17.
Foreign key only to a primary key also unique constraint in another table, does not accept null value anothers
18.
create table Customers (
id int,
name varchar(20),
age int,
check (age>=18)
19.
create table cars (
id int identity (100, 10),
name varchar(20),
age int,
)
20.
create table OrderDetails (
id int primary key,
name varchar(20)
)
21.
isnull accept 2 argumnts, lets you return an alternative value when an expression is NULL
COALESCE accept some arguments , return first not null argument
22.
create table Employees (
EmpID int primary key,
Email varchar(50) unique
)
23.
CREATE TABLE Customer1 (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL
)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT,
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID) 
        REFERENCES Customer1(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)

