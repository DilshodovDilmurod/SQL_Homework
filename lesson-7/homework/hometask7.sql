1.
select min(Price) 
from Products
2.
select max(Salary) 
from Employees
3.
select count(*) 
from Customers
4.
select count(distinct(Category)) 
from Products
5.
select sum(SaleAmount) 
from Sales
where ProductID =7
6.
select avg(Age) 
from Employees
7.
select DepartmentName , count (DepartmentName) 
from Employees
group by DepartmentName
8.
select Category, min(Price)as minPrice, max(Price)as maxPrice 
from Products
group by Category
9.
select  CustomerID, sum(SaleAmount) as TotalAmount 
from Sales
group by CustomerID
10.
select DepartmentName , count(DepartmentName) as DepNumber 
from Employees
group by DepartmentName
having count (DepartmentName)>5
11.
select ProductID, sum(SaleAmount) as TotalAmount, avg(SaleAmount) as AvgAmount
from Sales
group by ProductID
12.
select DepartmentName, count(*) 
from Employees 
where DepartmentName = 'HR'
group by DepartmentName
13.
select DepartmentName, max(salary) as highest_salary, min(Salary) as lowest_salary 
from Employees
group by DepartmentName
14.
select DepartmentName, avg(Salary) as  AverageSalary 
from Employees
group by DepartmentName
15.
select DepartmentName, avg(Salary) as  AverageSalary, count(*) as number 
from Employees
group by DepartmentName
16.
select Category, avg(Price) as AvgPrice  
from Products
group by Category
having avg(Price)>400
17.
select year(SaleDate) as year, sum(SaleAmount) as TotalAmount 
from Sales
group by year(SaleDate)
18.
select CustomerID, count(*) numOrders
from Orders
group by CustomerID
having count(*)>=3
19.
select DepartmentName, avg(Salary) as AvgSalary 
from Employees
group by DepartmentName
Having avg(salary)> 60000
20.
select Category, avg(Price) as AveragePrice
from Products
group by Category 
having avg(price)>150
21.
select CustomerID, sum(TotalAmount) as TotalSales 
from Orders
group by CustomerID
having sum(TotalAmount) > 1500
22.
with CTE as (
	select DepartmentName, 
		avg(Salary) as AvgSalary 
	from Employees
	group by DepartmentName
	Having avg(salary) > 65000
)
select	e.EmployeeID,
		e.DepartmentName,
		e.Salary,
		d.AvgSalary
from Employees e
inner join CTE d 
	on e.DepartmentName = d.DepartmentName
23
SELECT count([orderid]) numorders
      ,[custid]
      ,sum([freight]) TotalFreight
FROM [TSQL2012].[Sales].[Orders]
where freight>50
group by custid
having count([orderid])<=50
24.
select 
	year(OrderDate) as OrderYear, 
	month(OrderDate) as OrderMonth, 
	sum(TotalAmount) as TotalSalary, 
	count(distinct(ProductID)) as numpr
from Orders	
group by year(OrderDate), month(OrderDate)
having count(distinct(ProductID))>= 2
25
select year(OrderDate), 
min(quantity) as min_quantity, 
max(quantity) as max_quantity 
from Orders
group by year(OrderDate)
