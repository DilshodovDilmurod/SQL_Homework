--1.
select Id, Dt, 
case when len(month(Dt)) = 1 then concat('0',cast(month(Dt) as nvarchar(30)))
else cast(month(Dt) as varchar(20)) end [month]
from Dates 

--2.
select  distinct count(Id) over(partition by rID) Distinct_ids,
		rID, sum(max_Vals) over (partition by rID) TotalofMaxVals
		from (
		select * from (
			select distinct Id, rID, 
			max(Vals) over(partition by Id 
					order by rID) max_Vals 
			from MyTabel
	) mytbl
	) tbl  -- solution with derived table

--3.
select Id, Vals from (
select *, len(Vals) len_vals
from TestFixLengths) tbl3
where len_vals between 6 and 10

--4.
select ID, Item, Vals from(
		select *,
		max(Vals) over(partition by ID) max_Vals
		from TestMaximum ) tbl4
where Vals = max_Vals

--5.
select  distinct Id, 
sum(Vals) over(partition by ID) SumOfMax
from(
	select DetailedNumber, Vals, Id from (
			select  *,
			max(Vals) over (partition by Id order by DetailedNumber) max_vals
			from SumOfMax
			) tbl1
	where Vals = max_vals 
) tbl

--6.
select Id, a, b,
case when output = 0 then ''
else cast([output] as varchar(10)) end [output]
from (
	select *,
	a-b [output]
	from TheZeroPuzzle
	) tbl

--7.
select sum(QuantitySold* Unitprice) total_general_amount from Sales

--8.
select avg(UnitPrice) avg_price_of_product from Sales

--9.
select count(SaleID) cnt_Sale from Sales

--10.
select max(QuantitySold) max_Quantity from Sales 

--11.
select distinct Category, 
	sum(QuantitySold) over(partition by Category) sum_ofprod_perCat
from Sales

--12.
select distinct region,
sum(QuantitySold * unitPrice) over(partition by Region ) Total_revenue
from Sales

--13.
with cte as (
select *, 
row_number() over (order by total_revenue_perProd desc) rw
from (
	select distinct Product, 
	sum(QuantitySold * UnitPrice) 
		over(partition by Product) total_revenue_perProd 
	from Sales
) tbl 
)
select  Product from cte
where rw =1

--14.
select saleID, quantitySold, UnitPrice, SaleDate,
sum(QuantitySold * unitPrice) over(order by SaleDate) total_revenue
from Sales

--15.
select Category, Total_revenue*100/Total_general_amount percanteg_ofCat
from (
	select distinct Category,
		(select sum(QuantitySold* Unitprice) total_general_amount from Sales) total_general_amount,
		sum(QuantitySold * unitPrice) over(partition by Category ) Total_revenue
	from Sales
) tbl

--17.
select s.*, c.CustomerName 
from Sales s
join Customers c
on s.CustomerID = c.CustomerID

--18.
select c.CustomerName
from Customers c
left join Sales s
on c.CustomerID = s.CustomerID
where s.CustomerID is null

--19.
select c.CustomerName,
sum(QuantitySold*unitPrice) over(partition by c.CustomerID) total_revenue
from Customers c
join Sales s
on c.CustomerID = s.CustomerID

--20.
with cte as(
select *, 
dense_rank() over(order by total_revenue desc) ds
from (
	select distinct c.CustomerName,
	sum(QuantitySold*unitPrice) over(partition by c.CustomerID) total_revenue
	from Customers c
	join Sales s
	on c.CustomerID = s.CustomerID
	) tbl
)
select CustomerName 
from cte
where ds=1

--21.
select c.CustomerName,
sum(QuantitySold*unitPrice) over(partition by c.CustomerID) total_sales
from Customers c
join Sales s
on c.CustomerID = s.CustomerID

--22.
select ProductName
from Products p
join Sales s
on p.ProductName = s.Product
where s.Quantitysold >= 1 

--23.
select ProductName
from (
select *, 
row_number() over(order by SellingPrice desc) rw 
from Products
) tbl
where rw =1

--24.
select ProductName 
from (
	select *,
	avg(SellingPrice) over(partition by Category ) avg_selling_price
	from Products
	) tbl
where SellingPrice > avg_selling_price
