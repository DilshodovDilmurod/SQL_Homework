
1.
create table employees  (empid int, name varchar(50), salary decimal(10,2))
2.
insert into employees (
empid, name,salary) 
values (1, 'john', 34.125)
insert into employees (
empid, name, salary) 
values (2, 'tom', 482.125), 
(3, 'hamid', 589.456), 
(4, 'bunyod', 562.214)
select *
from employees
3.
update employees
set salary = 7000
where empid = 1
select * from employees
4.
delete from employees
where empid =2
select * from employees
5.
delete - to delete data from a table by filtered
truncate - to delete all data from a table
drop - to delete a table or a database 
6.
alter table employees
alter column name varchar(100)
7.
alter table employees
add Department varchar(50)
8.
alter table employees 
alter column salary float
9.
create table departements (departementid int primary key, departementname varchar(50))
10.
--delete from employees -- if not where same truncate 
--truncate table employees
11.
insert into departements
select 1, 'product'
union all
select 2, 'fruicts'
union all
select 3, 'milk'
union all
select 4, 'build_material'
union all
select 5, 'avto'
select * from departements
12.
update  employees
set Department ='Management'
where salary> 500
select * from employees
13.
delete from employees -- if not where same truncate 
truncate table employees
14.
alter table employees
drop column Department
15.
exec sp_rename 'employees' , 'StaffMembers'
16.
drop table departements
17.
create table Products (ProductId int primary key, ProductName varchar(15), Category varchar(20), Price decimal(10,2))
18.
alter table Products
add check (Price > 0)
19.
alter table Products
add StockQuantity int  default 50
select * from Products
20.
exec sp_rename 'Products.Category', 'ProductCategory', 'column';
select * from Products
21.
insert into Products values (2, 'laptop', 'product', 6735.21, 87), (3, 'corik', 'product', 6735.21, 45),
(4, 'ayron', 'milk', 3432.52, 54), (5, 'tv', 'product', 3445.21, 56)
select * from Products
22.
select * into Products_Backup from Products
select * from Products_Backup
23.
alter table Products
drop constraint price
exec sp_rename 'Products', 'Inventory' 
24.
alter table Inventory
alter column Price float
25.
alter table Inventory 
add ProductCode  int identity (1000, 5)
select * from Inventory
