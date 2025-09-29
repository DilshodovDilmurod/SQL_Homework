
--1.
select * ,
row_number() over(order by SaleDate) row_numbers
from ProductSales

--2.
select  distinct ProductName, 
(select sum(quantity) from ProductSales p2 where p2.ProductName = p1.ProductName) total_quantity,
DENSE_RANK () over (order by (select sum(quantity) from Productsales p2 where p2.ProductName = p1.ProductName)) ds
from ProductSales p1

--3.
with cte as (
select *,
DENSE_RANK() over (partition by CustomerID
					order by saleAmount desc) ds
from ProductSales 
) 
select SaleID, ProductName, SaleDate, 
	SaleAmount, Quantity, CustomerID 
from cte
where ds =1

--4.
select SaleDate, SaleAmount, 
lead(SaleAmount, 1, 0) over (order by SaleDate) next_SaleAmount
from ProductSales

--5.
select SaleDate, SaleAmount, 
lag(SaleAmount, 1, 0) over (order by SaleDate) previous_SaleAmount
from ProductSales

--6.
with cte as(
select *, 
lag(SaleAmount, 1, 0) over (order by SaleDate) previous_SaleAmount
from ProductSales
)
select SaleID, SaleAmount, previous_SaleAmount 
from cte
where SaleAmount > previous_SaleAmount

--7.
with cte as(
select *,
lag(SaleAmount) over(partition by ProductName 
		order by SaleDate) previous_SaleAmount
from ProductSales
) 
select ProductName, SaleDate, 
SaleAmount, previous_saleAmount, 
abs( SaleAmount-previous_saleAmount) different
from cte

--8.
with cte as(
select *,
lead(SaleAmount) over(partition by ProductName order by SaleDate) next_SaleAmount
from ProductSales
) 
select ProductName, SaleDate, SaleAmount, next_saleAmount, 
cast(abs( 1-next_saleAmount/SaleAmount)*100 as decimal(5,2)) [change]
from cte

--9.
with cte as (
select *,
lag(SaleAmount) over (partition by ProductName order by SaleDate) previous_Sale
from ProductSales
)
select ProductName, SaleAmount, previous_Sale, 
		cast(SaleAmount/previous_Sale as decimal(5,2)) ratio_sale 
from cte
where previous_Sale is not null

--10.
with cte as (
select  ProductName, SaleAmount,
first_value(SaleAmount) 
	over(partition by ProductName order by SaleDate ) first_sale,
row_number() 
	over(partition by ProductName order by SaleDate) rw
from ProductSales
)
select  ProductName, SaleAmount, 
		first_sale,
		SaleAmount-first_sale diffirent
from cte
where rw<>1

--11.
with cte as (
select *,
lag(SaleAmount) over(partition by ProductName order by SaleDate) previous_sale
from ProductSales
)
select SaleID, ProductName, SaleAmount from cte
where SaleAmount - previous_sale>0

--12.
select *,
	(select sum(SaleAmount) from ProductSales p2 
			where p1.SaleDate>= p2.SaleDate) closing_balance
from ProductSales p1

--13.
select ProductName, SaleDate, SaleAmount,
cast(avg(SaleAmount) over(order by saleDate 
			rows between 2 preceding 
				and current row) as decimal(10,2)) avg_last_3
from ProductSales


--14.
with cte as(
select *,
(select avg(SaleAmount) from ProductSales) avg_Amount
from ProductSales
)
select ProductName, SaleAmount, avg_Amount, 
		cast(abs(SaleAmount - avg_Amount) as decimal(5,2)) diffirence
from cte

--15.
with cte as (
select *,
row_number() over(partition by salary order by salary) rw
from Employees1
) select EmployeeID, Name from cte 
where salary in (select salary from cte where rw =2)

--16.
with cte as (
select *,
row_number() over (partition by Department order by Salary desc) rw
from Employees1
)
select salary from cte
where rw<=2

--17.
with cte as (
select *,
row_number() over (partition by Department order by Salary ) rw
from Employees1
)
select Name, Department, Salary from cte
where rw =1

--18.
select distinct Department,
sum(Salary) over(partition by Department) total_Salary
from Employees1

--19.
select Department, sum(salary) from Employees1
group by Department

--20.
select Department , 
	cast(avg(Salary) as decimal(7,2)) avg_salary 
from Employees1
group by Department

--21
with cte as(
select * ,
cast(avg(Salary) over(partition by Department) as decimal(7,2)) avg_salary
from Employees1
)
select Name, Department, 
	salary, abs(Salary - avg_salary) diffirence
from cte

--22
select Name, Department, Salary, 
cast(avg(salary) over (order by  EmployeeID
	rows between 1 preceding and 1 following) as decimal(10,2)) moving_avg_salary
from Employees1

--23.
with cte as (
select *,
row_number() over (order by HireDate desc) rw
from Employees1
)
select sum(salary) Total_salary from cte
where rw <= 3
