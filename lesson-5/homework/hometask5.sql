1.
exec sp_rename 'Products.ProductName', 'Name', 'column';
2.
select (FirstName + ' ' + LastName) as FullName from Customers
3.
select ProductName from Products
union 
select ProductName from Products_Discounted
4.
select ProductName from Products 
intersect 
select ProductName from Products_Discounted
5.select distinct (FirstName + ' ' + LastName), Country from Customers
6.
select Price,  case when price > 1000 then 'High'
				when price <= 1000 then 'Low' end
as Price		
from Products
7.
select  StockQuantity, iif(StockQuantity>100, 'yes', 'no') from Products_Discounted
8. same example with 3
select Name from Products
union 
select ProductName from Products_Discounted
9.
select * from Products 
except
select * from Products_Discounted
10.
select Price, iif(Price>1000, 'Expensive', 'Affordable') from Products
11.
select * from Employees
where Age<25 or Salary>60000
12.

update Employees
set salary = salary *1.1
where EmployeeID =5 or DepartmentName ='HR'
13.
select SaleAmount, case when SaleAmount >500 then 'Top Tier'
						when SaleAmount between 200 and 500 then 'Mid Tier'
						else 'Low Tier' end as SaleAmount
from Sales
14.
select CustomerID from Orders
except
select CustomerID from Sales
15.
select CustomerID, quantity, case when quantity = 1 then '3%'
									when quantity between 1 and 3 then '5%'
									else '7%' end as discount
from Orders
