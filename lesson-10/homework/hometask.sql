1.
select e.Name, e.Salary, d.DepartmentName
from Employees e
inner join Departments d
on e.DepartmentID = d.DepartmentID
where e.Salary>50000

2.
select c.FirstName, c.LastName, o.OrderDate
from Customers c
inner join Orders o on  c.CustomerID = o.CustomerID
where year(OrderDate) = 2023

3.
select e.Name, d.DepartmentName
from Employees e
left join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentID is null

4.
select s.SupplierName, p.ProductName
from Suppliers s
left join Products p on s.SupplierID = p.SupplierID
where p.SupplierID is null

5.
select o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
from Orders o
full join Payments p on o.OrderID = p.OrderID
where o.OrderID is null or p.OrderID is null

6.
select e.Name as EmployeeName, em.Name as ManegerName
from Employees e
join Employees em on e.ManagerID = em.EmployeeID

7.
select s.Name, c.CourseName
from Enrollments e
join Students s on e.StudentID = s.StudentID
join Courses c on e.CourseID = c.CourseID
where c.CourseName = 'Math 101'

8.
select c.FirstName, c.LastName, o.Quantity
from Customers c
join Orders o on c.CustomerID = o.CustomerID
group by c.FirstName, c.LastName, o.Quantity
having o.Quantity>3

9.
select e.Name employeeName, d.DepartmentName
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName='Human Resources'

10.
select d.DepartmentName, count(e.EmployeeID) num_of_Employee
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName
having count(e.EmployeeID)>5

11.
select p.ProductID, p.ProductName
from Products p
left join Sales s on p.ProductID = s.ProductID
where s.ProductID is null

12.
select c.FirstName, c.LastName, count(o.Quantity) as TotalQuantity
from Customers c
join Orders o on  c.CustomerID = o.CustomerID
group by c.FirstName, c.LastName
having count(o.Quantity) >=1

13.
select e.Name EmployeeName, d.DepartmentName
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID 

14.
select e1.Name employee1, e2.Name employee2, e1.ManagerID ManagerID
from Employees e1
join Employees e2 on e1.ManagerID = e2.ManagerID
				and e1.EmployeeID < e2.EmployeeID

15.
select o.OrderID, o.OrderDate, c.FirstName, c.LastName
from Orders o
join Customers c on o.CustomerID = c.CustomerID 
where year(o.OrderDate) = 2022

16.
select e.Name EmployeeName , e.Salary Salary, d.DepartmentName DepartmentName
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Sales' and e.Salary=60000

17.
select o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
from Orders o
inner join Payments p on o.OrderID = p.OrderID

18.
select p.ProductID, p.ProductName
from Products p
left join Orders o on p.ProductID = o.ProductID
where o.ProductID is null

19.
select e1.Name EmployeeName , e1.Salary, e1.DepartmentID
from Employees e1
join Employees e2 on e1.DepartmentID = e2.DepartmentID and e1.EmployeeID < e2.EmployeeID
group by e1.Name, e1.Salary, e1.DepartmentID
having e1.Salary > avg(e2.Salary)

20.
select o.OrderID, o.OrderDate
from Orders o
left join Payments p on o.OrderID = p.PaymentID 
where year(OrderDate) < 2022 and p.PaymentID is null

21.
select p.ProductID, p.ProductName
from Products p
left join Categories c on p.Category = c.CategoryID 
where c.CategoryID is null

22.
select e1.Name Employee1, e2.Name Employee2, e1.ManagerID, e1.Salary
from Employees e1
join Employees e2 on e1.ManagerID = e2.ManagerID 
					and e1.EmployeeID < e2.EmployeeID
where e1.Salary > 60000

23.
select e.Name EmployeeName, d.DepartmentName
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName like 'M%'

24.
select s.SaleID, p.ProductName, s.SaleAmount
from Products p 
join Sales s on p.ProductID = s.ProductID
where s.SaleAmount > 500

25.
select s.StudentID, s.Name StudentName
from Students s
left join Enrollments e on s.StudentID = e.StudentID
left join Courses c on e.CourseID = c.CourseID and c.CourseName = 'Math 101'
where c.CourseID is null

26.
select o.OrderID, o.OrderDate, p.PaymentID
from Orders o
left join Payments p on o.OrderID = p.OrderID 
where p.PaymentMethod is null

27.
select p.ProductID, p.ProductName, c.CategoryName
from Products p
join Categories c on p.Category = c.CategoryID
where c.CategoryName in ('Electronics', 'Furniture')
