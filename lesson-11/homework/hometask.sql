1.
select o.OrderID, c.FirstName +' '+c.LastName CustomerName, o.OrderDate
from Orders o
join Customers c on o.CustomerID = c.CustomerID
where year(o.OrderDate)>2022

2.
Select e.Name EmployeeName, d.DepartmentName
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID 
where d.DepartmentName in('Sales','Marketing')

3.
select d.DepartmentName, max(Salary)
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName

4.
select c.FirstName+' '+c.LastName CustomerName, o.OrderID, o.OrderDate
from Orders o
join Customers c on o.CustomerID = c.CustomerID 
where year(o.OrderDate) = 2023 and c.Country= 'USA'

5.
select c.FirstName+' '+c.LastName CustomerName, count(o.OrderID)
from Customers c
join Orders o on c.CustomerID = o.CustomerID
group by  c.FirstName+' '+c.LastName

6.
select p.ProductName, s.SupplierName
from Products p
join Suppliers s on p.SupplierID = s.SupplierID
where s.SupplierName in('Gadget Supplies', 'Clothing Mart')

7.
select c.FirstName, c.LastName,  max(o.OrderDate) MostRecentOrderDate
from Customers c
left join Orders o on c.CustomerID = o.CustomerID
group by c.FirstName, c.LastName

8.
select c.FirstName+' '+c.LastName, o.TotalAmount OrderTotal
from Orders o
join Customers c on o.CustomerID = c.CustomerID
where o.TotalAmount > 500

9.
select p.ProductName, s.SaleDate, s.SaleAmount
from Products p
join Sales s on p.ProductID = s.ProductID
where YEAR(s.SaleDate) = 2022 or s.SaleAmount>400

10.
select p.ProductName, sum(s.SaleAmount) TotalSaleAmount
from Products p
join Sales s on p.ProductID = s.ProductID
group by p.ProductName

11.
select e.Name EmployeeName, d.DepartmentName, e.Salary
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'HR' and e.Salary > 60000

12.
select p.ProductName, s.SaleDate, p.StockQuantity
from Products p
join Sales s on p.ProductID = s.ProductID
where year(s.SaleDate) = 2023 and p.StockQuantity > 100

13.
select e.Name EmployeeName, d.DepartmentName, e.HireDate
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Sales' or year(e.HireDate) > 2020

14.
select c.FirstName, c.LastName, o.OrderID, c.Address, o.OrderDate
from Customers c
join Orders o on c.CustomerID = o.CustomerID
where c.Country = 'USA' and c.Address like '[0-9][0-9][0-9][0-9]%'

15.
select p.ProductName, c.CategoryName, s.SaleAmount
from Products p
join Sales s on p.ProductID = s.ProductID
join Categories c on p.Category = c.CategoryID
where c.CategoryName = 'Electronics' or s.SaleAmount > 350

16.
select c.CategoryName, count(p.ProductID) ProductCount
from Products p
join Categories c on p.Category = c.CategoryID
group by c.CategoryName

17.
select c.FirstName, c.LastName, c.City, o.OrderID, o.TotalAmount
from Customers c
join Orders o on c.CustomerID = o.CustomerID
where c.City = 'Los Angeles' and o.TotalAmount > 300

18.
select e.Name EmployeeName, d.DepartmentName
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where (d.DepartmentName ='HR'or d.DepartmentName= 'Finance') or e.Name like '%[euioa]%[euioa]%[euioa]%[euioa]%'

19.
select e.Name EmployeeName, d.DepartmentName, e.Salary
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where (d.DepartmentName = 'Sales' or d.DepartmentName = 'Marketing') and e.Salary > 60000
