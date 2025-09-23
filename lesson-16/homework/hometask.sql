--easy Tasks
1.
with cte as
(
select 1 as num 
union all 
select num + 1 as num from cte 
where num< 1000
)
select * from cte 
OPTION (MAXRECURSION 0);
2.
with cte as
(
select distinct EmployeeID, 
		(select sum(salesAmount) from Sales s2 where s2.EmployeeID = s1.EmployeeID) Totalamount 
from Sales s1
)
select cte.EmployeeID, Employees.FirstName, Employees.LastName, cte.Totalamount
from cte
join Employees on cte.EmployeeID = Employees.EmployeeID
3.
with cte as
(
select avg(Salary) Avg_salary from Employees
)
select * from cte
4.
select * from Products
;with cte as(
select distinct ProductID, (select max(SalesAmount) from Sales s2 where s2.ProductID = s1.ProductID)as Max_Amount from Sales s1
)
select Products.ProductName, cte.Max_Amount
from cte
join Products on Products.ProductID = cte.ProductID
5.
with cte as
(
select 1 as num 
union all
select num * 2 as num from cte
where num * 2 < 1000000
)
select * from cte
6.
with cte as
(
select distinct(EmployeeID), 
		(select count(SalesID) from Sales s2 where s2.EmployeeID = s1.EmployeeID) as count_sales 
from Sales s1
where (select count(SalesID) from Sales s2 where s2.EmployeeID = s1.EmployeeID)> 5
)
select e.FirstName, e.LastName, cte.count_sales
from cte 
join Employees e on e.EmployeeID= cte.EmployeeID
7.
select * from Products
;with cte as(
select distinct ProductID, (select sum(SalesAmount) from Sales s2 where s2.ProductID = s1.ProductID)as Total_Amount from Sales s1
--where (select sum(SalesAmount) from Sales s2 where s2.ProductID = s1.ProductID)> 500
)
select Products.ProductName, cte.Total_Amount
from cte
join Products on Products.ProductID = cte.ProductID
8.
with cte as
(
select *,(select avg(salary) from Employees) as avg_salary from Employees
)
select * from cte
where Salary > avg_salary

--medium Tasks
1.
with cte as
(
select distinct(EmployeeID), 
		(select count(SalesID) from Sales s2 where s2.EmployeeID = s1.EmployeeID) as count_sales 
from Sales s1
)
select top(5) e.FirstName, e.LastName, cte.count_sales
from cte 
join Employees e on e.EmployeeID= cte.EmployeeID
2.
select * from Products
with cte as 
(
select s.ProductID id, s.SalesAmount salesAmount , p.CategoryID Category
from Sales s
left join Products p on s.ProductID = p.ProductID
)
select Category, sum(salesAmount) TotalAmount from cte
group by Category
3.
declare @max_num int;
select @max_num =max(number)  from Numbers1
;with cte as( 
select 1 as num, 1 as factor
union all
select num + 1 as num , (num +1) * factor as factor from cte
where num<@max_num
)
select Numbers1.Number, cte.factor 
from cte
right join Numbers1 on Numbers1.Number = cte.num
4.
;WITH CTE AS(
SELECT ID, LEFT(STRING,1) AS MY_CHAR, 1 AS CHECKER, STRING, 
(SELECT MAX(LEN(STRING)) FROM Example) AS MAX_LEN FROM Example
union all
SELECT ID, SUBSTRING(STRING, CHECKER +1,1) AS MY_CHAR, CHECKER + 1 AS CHECKER,
STRING, MAX_LEN
FROM CTE
WHERE CHECKER < MAX_LEN
)
SELECT * FROM CTE
ORDER BY ID

5.
with cte as
(
select sum(SalesAmount) as now_month_sales from Sales
where month(SaleDate) = month(getdate())
group by SaleDate
)
select now_month_sales from cte

;with cte2 as
(
select  sum(SalesAmount) as last_month_sales from Sales
where month(SaleDate) = month(getdate())-1
group by SaleDate
)
select last_month_sales from cte2

select cte.now_month_sales - cte2.last_month_sales

6.
with cte as
(
select EmployeeID, 
(select sum(SalesAmount) from Sales s2 where s2.EmployeeID = s1.EmployeeID and month(saledate) in (1, 2, 3)) as bir,
(select sum(SalesAmount) from Sales s2 where s2.EmployeeID = s1.EmployeeID and month(saledate) in (4, 5, 6)) as ikki,
(select sum(SalesAmount) from Sales s2 where s2.EmployeeID = s1.EmployeeID and month(saledate) in (7, 8, 9)) as uch,
(select sum(SalesAmount) from Sales s2 where s2.EmployeeID = s1.EmployeeID and month(saledate) in (10, 11, 12)) as tort 
from Sales s1 
group by EmployeeID
)
select  e.EmployeeID, e.FirstName, e.LastName, cte. bir, cte.ikki, cte.uch, cte.tort
from cte
join Employees e on e.EmployeeID = cte.EmployeeID
where bir> 45000 or ikki > 45000 or uch > 45000 or tort > 45000

--DIFICULT TASKS
1.
DECLARE @num int = 0, @inr int = 1
;with cte as
(
select @num as num, @inr as inr
union all
select num + inr as num , num  as inr from cte
where num < 50
)
select num from cte  -- num ustuni fibonachi qiymatlari 
2.
 
3
with cte as 
(
select 1 as num, cast('1' as varchar(50)) as my_char 
union all 
select num + 1 as num ,  cast((my_char + cast((num+1) as varchar (50))) as varchar(50)) as my_char from cte
where num < 5
)
select * from cte
4.
with cte as
(
select distinct EmployeeID, 
(select sum(salesAmount) from Sales s2 where s2.EmployeeID = s1.EmployeeID and SaleDate >= DATEADD(month, -6, SaleDate)) as total_sales 
from Sales s1
)
select cte.EmployeeID, e.FirstName, e.LastName, cte.total_sales
from cte
left join Employees e on e.EmployeeID = cte.EmployeeID
order by cte.total_sales desc -- most sales boyicha sort qiladi 

5.
select * from RemoveDuplicateIntsFromNames
;WITH SplitData AS
(
    SELECT 
        PawanName,
        Pawan_slug_name,
        LEFT(Pawan_slug_name, CHARINDEX('-', Pawan_slug_name + '-') - 1) AS Prefix,
        RIGHT(Pawan_slug_name, LEN(Pawan_slug_name) - CHARINDEX('-', Pawan_slug_name)) AS NumberPart
    FROM RemoveDuplicateIntsFromNames
)
SELECT 
    PawanName,
    CASE 
        WHEN LEN(NumberPart) = 1 THEN Prefix           
        WHEN NumberPart LIKE REPLICATE(LEFT(NumberPart,1),LEN(NumberPart))
             THEN Prefix + '-' + LEFT(NumberPart,1)             
        ELSE Prefix + '-' + NumberPart                          
    END AS Cleaned_slug_name
FROM SplitData;






















