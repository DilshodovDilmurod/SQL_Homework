1.

create proc #EmployeeBonus
as
select 
	EmployeeID, 
	concat( FirstName,' ', LastName) FullName, 
	e.Department, Salary, 
	(Salary* BonusPercentage/100) BonusAmount
from Employees e
join DepartmentBonus d on e.Department = d.Department

exec #EmployeeBonus

2.

alter proc #EmployeeBonus2 @DepartmentName varchar(40), @bonus int
as
select 
	EmployeeID, 
	concat( FirstName,' ', LastName) FullName, 
	Department, Salary, 
	(Salary* @bonus/100) + Salary UpdateSalary
from Employees 
where Department = @DepartmentName

exec #EmployeeBonus2 'Sales', 10

3.

merge into Products_Current as Target
using Products_new as source
on target.ProductID = source.ProductID

when matched and (Target.Price<>source.Price
	or Target.ProductName <> source.ProductName) 
		then update set
		Target.Price = soucre.Price,
		Target.ProductName = source.ProductName

when not matched by Target then 
insert(ProductID, ProductName,Price) 
values (source.ProductID, source.ProductName, source.Price)

when not matched by Source then 
delete;
select * from Product_Current

4.

select
	t.id,
	case when t.p_id is null then 'root'
		when not exists (select 1 from Tree c where c.p_id= t.id) then 'leaf'
		else 'Inner' end as [Type]
from Tree t
order by t.id

5.

select s.user_id, 
cast(COALESCE( SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) *1.0 
 / NULLIF(COUNT(c.user_id), 0), 0) as decimal(5,1))
 AS confirmation_rate
from Signups s
left join Confirmations c on c.user_id = s.user_id
group by s.user_id
order by s.user_id

6.
select * from Employees
where Salary = (select min(salary) from Employees)

7.
alter proc GetProductSalesSummary @ProductID int
as
if exists (select 1 from sales where ProductID = @ProductID)
	begin
		select ProductName, 
			sum(Quantity) [Total Quantity Sold], 
			sum(Quantity * Price) [Total Sales Amount], 
			min(SaleDate) [First Sale Date],
			max(SaleDate) [Last Sale Date]
		from Products p
		join  Sales s on p.ProductID = s.ProductID
		where p.ProductID = @ProductID
		group by ProductName
	end 
else if not exists (select 1 from sales where ProductID = @ProductID)
begin 
	select ProductName from Products
	where ProductID = @ProductID
end

exec GetProductSalesSummary 17
