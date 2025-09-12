1).
select 
	p.ProductName, 
	s.SupplierName
from 
	Products p
cross join 
	Suppliers s 
2).
select 
	d.DepartmentName, 
	e.Name
from 
	Departments d
cross join 
	Employees e
3).
select 
	s.SupplierName, 
	p.ProductName
from 
	Suppliers s
inner join 
	Products p on s.SupplierID=p.SupplierID
4).
select 
	c.FirstName, 
	o.OrderID
from 
	Customers c
inner join 
	Orders o on c.CustomerID = o.CustomerID
5).
select 
	s.Name, 
	c.CourseName
from 
	Students s
cross join 
	Courses c
6).
select 
	p.ProductName, 
	o.OrderDate
from 
	Products p
inner join 
	Orders o on p.ProductID=o.ProductID
7).
select 
	e.Name
from 
	Employees e
inner join 
	Departments d on e.DepartmentID = d.DepartmentID
8).
select 
	s.Name, 
	e.CourseID
from 
	Students s
inner join 
	Enrollments e on s.StudentID = e.StudentID
9).
select 
	o.OrderID, 
	p.PaymentID, 
	p.Amount
from 
	Orders o
inner join 
	Payments p on o.OrderID = p.OrderID
10).
select 
	o.OrderID, 
	p.ProductID, 
	p.Price 
from 
	Orders o
inner join 
	Products p on o.ProductID = p.ProductID
where 
	p.Price>100
11).
select 
	e.name, 
	d.DepartmentName
from 
	Employees e
cross join 
	Departments d
where 
	e.DepartmentID!=D.DepartmentID
12).
select 
	o.OrderID, 
	o.OrderDate, 
	o.Quantity, 
	o.TotalAmount
from 
	Orders o 
inner join 
	Products p on o.ProductID = p.ProductID
where 
	o.Quantity> p.StockQuantity
13).
select 
	c.FirstName, 
	s.ProductID
from 
	Customers c 
inner join  
	Sales s  on c.CustomerID = s.CustomerID
where 
	s.SaleAmount>=500
14).
select 
	s.Name, 
	c.CourseName
from 
	Enrollments e
inner join 
	Students s on e.StudentID = s.StudentID
inner join 
	Courses c on e.CourseID = c.CourseID
15).
select 
	p.ProductName, 
	s.SupplierName
from 
	Products p
inner join 
	Suppliers s	on p.SupplierID = s.SupplierID
where 
	s.SupplierName like '%Tech%'
16).
select 
	o.*
from 
	Orders o
inner join 
	Payments p on o.OrderID = p.OrderID
where
	o.TotalAmount > p.Amount
17).
select 
	e.Name,
	d.DepartmentName
from
	Employees e
inner join 
	Departments d on e.DepartmentID = d.DepartmentID
18).
select 
	p.ProductName, c.CategoryName
from 
	Products p
inner join 
	Categories c on p.Category = c.CategoryID
where 
	c.CategoryName = 'Electronics' 
	or c.CategoryName = 'Furniture'
19).
select 
	c.*
from 
	Customers c
inner join 
	Sales s on c.CustomerID = s.CustomerID
where 
	c.Country = 'USA'
20).
select o.OrderID, c.FirstName, c.Country, o.TotalAmount
from
	Orders o
inner join 
	Customers c on o.CustomerID = c.CustomerID
where 
	c.Country = 'Germany' and o.TotalAmount>100
21).
select 
	e.Name,
	em.Name
from 
	Employees e
cross join 
	Employees em 
where 
	e.DepartmentID != em.DepartmentID
	and e.EmployeeID  < em.EmployeeID
22).
select
	pr.ProductName, 
	o.Quantity, 
	pr.Price, 
	p.Amount
from 
	Orders o
inner join 
	Payments p on o.OrderID = p.OrderID
inner join 
	Products pr on o.ProductID = pr.ProductID
where 
	p.Amount != o.Quantity* pr.Price
23).
select 
	s.Name,
	e.CourseID,
	c.CourseName
from 
	Enrollments e
right  join 
	Students s on e.StudentID = s.StudentID
left join 
	Courses c on e.CourseID = c.CourseID
where 
	e.CourseID is null
24).
select 
	e.*
from 
	Employees e
inner join 
	Employees em on e.ManagerID = em.EmployeeID
where 
	em.Salary<= e.Salary
25).
select 
	c.FirstName, 
	o.OrderID, 
	p.PaymentDate
from 
	Orders o
inner join 
	Customers c on o.CustomerID = c.CustomerID
left join 
	Payments p on o.OrderID = p.OrderID
where 
	p.OrderID is null
