1). 
Select Category, Sum(StockQuantity) as NumCat 
from Products
group by Category

2).
Select Category, avg(Price) AvgPrice 
from Products
where Category = 'Electronics'
group by Category

3).
select * 
from Customers
where City like 'L%'

4).
select ProductName 
from Products
where ProductName like '%er'

5).
select * from Customers
where Country like '%A'

6).
select max(Price) maxPrice 
from Products

7). 
select *,
iif (StockQuantity < 30, 'Low Stock', 'Sufficient') as iif
from Products

8). 
select country, sum(CustomerID) numcustomers
from Customers
group by country

9). 
select min(Quantity) minQuantity, max(Quantity) maxQuantity
from Orders

10).
select i.CustomerID
from Orders o
left join Invoices i 
	on o.CustomerID = i.CustomerID
	and year(i.InvoiceDate) =2023 
	and month(i.InvoiceDate) =1
where year(o.OrderDate) = 2023
	and month(o.OrderDate) = 1
	and i.CustomerID is null

11).
select * 
from Products
union all
select * 
from Products_Discounted

12).
select * 
from Products
union 
select * 
from Products_Discounted

13).
select year(OrderDate) year, avg(TotalAmount) avaregeAmount 
from Orders
group by year(OrderDate)

14).
select ProductName, 
case 
	when Price< 100 then 'Low'
	when Price between 100 and 500 then 'Mid'
	when Price>500 then 'High' end pricegroup
from Products

15).
select * 
into Population_Each_Year
from City_population 
pivot (
	sum(population)
	for year 
	in ([2012], [2013])
) as PivotTable;
select * from Population_Each_Year

16).
select  ProductID, sum(SaleID) TotalSales
from Sales
group by ProductID

17).
select ProductName 
from Products
where ProductName like '%oo%'

18).
select *
into Population_Each_City
from city_population
pivot (
sum(population)
for district_name
in ([Bektemir], [Chilonzor], [Yakkasaroy])
) as Pt
select * from Population_Each_City

19).
select top 3 CustomerID, sum(TotalAmount) as Totalsent 
from Invoices
group by CustomerID

20).
select district_id, district_name, year, population
from Population_Each_Year
unpivot(
	population for year in ([2012], [2013])
	) as pvt

21).
select p.ProductName, count(s.SaleID)  from Products p
join Sales s
on p.ProductID = s.ProductID
group by p.ProductName

22).
select district_id, district_name, year, population
from Population_Each_City
unpivot(
	population for district_name in ([Bektemir], [Chilonzor], [Yakkasaroy])
	) as pvt
