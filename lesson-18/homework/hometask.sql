
1.

create view MonthlySales as
(
select p.ProductID, 
		sum(s.Quantity) as TotalQuantity, (sum(s.Quantity) * p.Price) as TotalRevenue
from Sales s
join Products p on s.ProductID = p.ProductID
group by p.ProductID, p.Price
)
select * from MonthlySales

2.

create view vw_ProductSalesSummary as
(
select s.ProductID, ProductName, Category, 
		(select sum(quantity) from sales s1 where s1.ProductID = s.ProductID)* p.Price as CountQuantity
from sales s
join Products p on s.ProductID = p.ProductID
group by  s.ProductID, ProductName, Category, p.Price
)
select * from vw_ProductSalesSummary

3.

CREATE FUNCTION fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS VARCHAR(500)
AS
BEGIN
    DECLARE @Revenue VARCHAR(500);

    WITH cte AS (
        SELECT 
            s.ProductID, 
            p.ProductName, 
            p.Category, 
            SUM(s.Quantity) * p.Price AS CountQuantity
        FROM sales s
        JOIN Products p ON s.ProductID = p.ProductID
        WHERE s.ProductID = @ProductID
        GROUP BY s.ProductID, p.ProductName, p.Category, p.Price
    )
    SELECT @Revenue = CAST(CountQuantity AS VARCHAR(500))
    FROM cte;

    RETURN @Revenue;
END;

select dbo.fn_GetTotalRevenueForProduct(1)

4.

create function fn_GetSalesByCategory(@Category VARCHAR(50))
returns table
as 
return
(
	with cte as (
	select s.ProductID, ProductName, Category, (select sum(quantity) from sales s2 where s2.ProductID = s.ProductID) TotalQuantity
			,(select sum(quantity) from sales s1 where s1.ProductID = s.ProductID)* p.Price as  TotalRevenue
	from sales s
	join Products p on s.ProductID = p.ProductID
	where Category = @Category
	group by  s.ProductID, ProductName, Category, p.Price
	)
	select ProductName, TotalQuantity, TotalRevenue from cte
)
select* from  dbo.fn_GetSalesByCategory('Electronics')

5.

CREATE FUNCTION fn_IsPrime(@Check_Prime INT)
RETURNS varchar(50)
AS
BEGIN
    DECLARE @num INT = 2, @res varchar(20) = 'yes';

    IF @Check_Prime < 2
        RETURN 'no'; -- 0 va 1 tub emas

    WHILE @num <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @num = 0
        BEGIN
            SET @res = 'no';
            BREAK;
        END
        SET @num = @num + 1;
    END

    RETURN @res;
END;

select dbo.fn_IsPrime(47)

6.
declare @start int = 5, @end int = 10
create function  fn_GetNumbersBetween( @start int, @end int)
returns table 
as
return
(
with cte as(
select @start as num 
union all 
select num + 1 as num from cte
where num < @end
)
select * from cte
)
select * from dbo. fn_GetNumbersBetween(5, 18)

7.
create table salary (id int , salary int)
insert into salary values (1, 100), (2, 200), (3,300)

declare @num int =5
create function getNthHighestSalary(@num int)
returns table
return (
with cte as(
select *,
dense_rank() over(order by salary desc) as rw
from salary
)
select salary from cte
where rw = @num
)
select * from dbo.getNthHighestSalary(3)

8.

with cte2 as(
select accepter_id, count(accepter_id) count_id from RequestAccepted
group by accepter_id
)
, cte as(
select requester_id, count(requester_id) count_id from RequestAccepted
group by requester_id
), cte3 as(
select coalesce(requester_id, accepter_id) id, isnull(cte.count_id,0)+ ISNULL(cte2.count_id, 0) num ,
row_number() over(order by isnull(cte.count_id,0)+ ISNULL(cte2.count_id, 0) desc ) rw
from cte
full join cte2 on cte.requester_id = cte2.accepter_id
)
select id, num from cte3
where rw =1

9.

create view  vw_CustomerOrderSummary as(
select o.customer_id, c.name, count(order_id) total_orders, sum(amount) Total_amount, max(order_date) last_order_date
from Orders o
join Customers c on o.customer_id = c.customer_id
group by o.customer_id, c.name
)
select * from vw_CustomerOrderSummary

10.

select [RowNumber],
 LAST_VALUE(TestCase) IGNORE NULLS OVER (ORDER BY [RowNumber] 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) 
from Gaps
