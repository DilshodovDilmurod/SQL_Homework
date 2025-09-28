--1.
select * from #Sales s
where exists (select * from #Sales where year(s.SaleDate) = 2024 
										and month(s.SaleDate) = 3 
										and s.Quantity>1)
--2.
select top (1) Product, 
		(select sum(Quantity * Price) from #Sales s2 where s2.Product = s1.Product) Total_revenue
from #sales s1
order by Total_revenue desc

--3.
select* from #sales
select  distinct Product,
(select sum(quantity* price) from #Sales s1 where s1.product = s2.Product) Total_revenue
from #sales s2
order by Total_revenue desc
offset 1 rows fetch next 1 rows only;

--4.

select Product, month(SaleDate) SaleMonth,
(select sum(s2.quantity * s2.Price) from #Sales s2  
		where s2.Product = s1.Product 
		and month(s2.SaleDate) = month(s1.SaleDate))
from #Sales s1
group by s1.Product, month(s1.SaleDate)
order by s1.Product, SaleMonth

--5.
select CustomerName 
from #Sales c1
where exists (select 1 from #Sales c2 
		where c1.CustomerName = c2.CustomerName 
		and c1.Product = c2.Product 
		and c1.Price != c2.Price)

--6.

select Name, Apple, Orange, Banana
from Fruits
pivot(
count(fruit) 
for Fruit in([Apple], [Orange], [Banana])
) pvt
order by pvt.Name

--7.

select f.ParentId, fm.ChildID
from Family f
cross join Family fm
where f.ParentId < fm.ChildID
order by f.ParentId

--8.

select CustomerID, OrderID, DeliveryState from #Orders
where CustomerID in (select CustomerID from #Orders where DeliveryState ='CA') 
					and DeliveryState = 'TX'
--9.

update #residents
set address = address + 'name='+fullname
where address not like '%name=%'

--10.

with RecursiveRoutes as(
select DepartureCity, ArrivalCity, Cost,
 cast(DepartureCity + '->' + ArrivalCity as varchar(max)) as route
from #Routes
where DepartureCity = 'Tashkent'
union all
select r.DepartureCity, r.ArrivalCity, rr.Cost+r.Cost,
		route +'->'+ r.ArrivalCity
from #Routes r
join RecursiveRoutes  rr on rr.ArrivalCity = r.DepartureCity 
),
cheaper as(
select top 1 'chep' as type , route, cost 
from RecursiveRoutes 
where ArrivalCity ='Khorezm'
order by cost 
), expensive as
(
select top 1 'expensive' as type , route, cost 
from RecursiveRoutes 
where ArrivalCity ='Khorezm'
order by cost desc
)

select * from cheaper
union all
select * from expensive -- respect 

--11.

with cte as(
select * ,
DENSE_RANK() over (order by r1.vals) as rank_group
from #RankingPuzzle as r1
)
select Id, vals, 
case when vals <> 'Product' then concat('Product ', rank_group)
end as my_gr
from cte
order by id

--12.

with cte as (
select *, 
(select avg(SalesAmount) from #EmployeeSales e2 where e2.Department = e1.Department) avg_salary
from #EmployeeSales e1
)
select EmployeeName from cte
where SalesAmount > avg_salary

--13.

select e1.EmployeeName , SalesMonth
from #EmployeeSales e1
where exists
(select 1 from 
	(
	select salesMonth, max(SalesAmount) as SalesAmount 
	from #EmployeeSales
	group by SalesMonth
	) e2 
		where e1.SalesMonth = e2.SalesMonth 
		 and e1.SalesAmount = e2.SalesAmount ) 

--14.

SELECT DISTINCT e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT 1
    FROM (SELECT DISTINCT SalesMonth FROM #EmployeeSales) m
    WHERE NOT EXISTS ( SELECT 1 FROM #EmployeeSales es
        WHERE es.EmployeeName = e.EmployeeName
          AND es.SalesMonth = m.SalesMonth )
);

--15.

with cte as(
select *,
(select avg(Price) from Products) as avg_price
from Products
)
select * from cte
where Price> avg_price

--16.

with cte as(
select *,
(select max(Stock) from Products) max_Stock
from Products
)
select Name, Stock, max_Stock from cte
where Stock< max_Stock

--17.

select name 
from Products
where Category = (select distinct Category 
					from Products where name = 'Laptop') 
	and name <> 'Laptop'

--18.

select name 
from Products 
where Price > (select min(Price) from Products
				where category = 'Electronics')

--19.

select name
from Products p1
where price > (select avg(price) from Products p2 where p2.Category = p1.Category)

--20.

select p.Name
from Orders o
left join Products p on o.ProductID = p.ProductID 

--21.

select name
from Orders o
join Products p on o.ProductID = p.ProductID
where quantity > (select avg(quantity) from Orders)

--22.

select name
from Products p
left join Orders o 
on p.ProductID = o.ProductID
where o.ProductID is null

--23.

with cte as(
select ProductID, sum(quantity) total_Quantity,
row_number() over (order by sum(quantity) desc) rw
from Orders
group by ProductID
)
select name
from cte
join Products p on cte.ProductID = p.ProductID 
where rw=1
