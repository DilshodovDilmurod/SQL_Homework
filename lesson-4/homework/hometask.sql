1.
select Top(5) * from Employees
2.
select distinct Category from Products
3.
select * from Products 
where Price >100
4.
select * from Customers 
where FirstName like 'A%'
5.
select * from Products
order by Price asc
6.
select * from Employees
where Salary >=6000 and DepartmentName='HR'
7.
select isnull(Email, 'noemail@example.com')as Email from Employees
8.
select * from Products
where between 50 and 100
9. 
select distinct Category, ProductName
from Products
10.
select distinct Category, ProductName
from Products
order by ProductName desc
11.
select top 10 * from Products
order by Price desc
12.
select coalesce (FirstName, LAstName) 
from Employees
13.
select distinct(Category), Price
from Products
14.
select * from Employees
where Age between 30 and 40 or DepartmentName = 'Marketing'
15.
select * from Employees
order by Salary desc 
offset 10 rows
fetch next 10 rows only
16.
select * from Products
where Price < 1000 and StockQuantity> 50
order by StockQuantity asc
17.
select * from Products
where ProductName like '%e%'
18.
select * from Employees
where  DepartmentName in('HR', 'IT', 'Finance')
19.
select City, PostalCode from Customers
order by City asc, PostalCode desc
20.
select top 5 ProductID, ProductName, Price, Category, StockQuantity, Price*StockQuantity as SaleAmount from Products
order by  Price*StockQuantity  desc
21.
select ( FirstName +' '+ LastName) as FullName from Employees
22.
select distinct Category, ProductName, Price
from Products
where price >50
23.
select * from Products
where Price < (select avg(Price) *0.1 from Products)
24.
select Age, DepartmentName from Employees
where Age < 30 and DepartmentName in ('HR', 'IT')
25.
select * from  Customers
where Email like '%@gmail.com%'
26.
select * from Employees
where Salary > All (select Salary from Employees where DepartmentName = 'Sales')
27.
select * from Orders
where OrderDate between dateadd(day, -180, (select max(OrderDate) from Orders))
						and (select max(OrderDate) from Orders)
