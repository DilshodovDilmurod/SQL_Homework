--create database lesson18
--use lesson18

1.

;with cte as(
select p.ProductID, 
		sum(s.Quantity) as TotalQuantity, (sum(s.Quantity * p.Price)) as TotalRevenue
from Sales s	
join Products p on s.ProductID = p.ProductID
group by p.ProductID, p.Price
)
select * into #monthlySales  from cte
select * from #monthlySales

2.

alter view vw_ProductSalesSummary as
(
select s.ProductID, ProductName, Category, 
	sum(quantity) *p.Price TotalQuantitySold
from sales s
join Products p on s.ProductID = p.ProductID
group by  s.ProductID, ProductName, Category, p.Price
)
select * from vw_ProductSalesSummary

3.


create function fn_GetTotalRevenueForProduct(@ProductID INT)
returns int
as
begin 
declare @res int;
select  @res = sum(Quantity * Price) 
from sales s
join Products p on s.ProductID = p.ProductID
where s.ProductID = @ProductID
return isnull(@res, 0)
end

select dbo.fn_GetTotalRevenueForProduct(1)

4.

create function fn_GetSalesByCategory(@Category VARCHAR(50))
returns table
as 
return
(
	select ProductName, Category, 
		sum(quantity) *p.Price TotalQuantitySold
	from sales s
	join Products p on s.ProductID = p.ProductID
	where Category = @Category
	group by   ProductName, Category, p.Price
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
create table Employee (id int , salary int)
insert into Employee values (1, 100), (2, 200), (3,300)
declare @num int =5
create function getNthHighestSalary(@num int)
returns table
return (
with cte as(
select *,
dense_rank() over(order by salary desc) as rw
from Employee
)
select salary from cte
where rw = @num
)
select * from dbo.getNthHighestSalary(3)

8.
with cte as(
select requester_id as person , accepter_id as friend
from RequestAccepted
union all
select accepter_id as person, requester_id as friend 
from RequestAccepted
)
select top 1 person as id, count(distinct friend) as total_friend 
from cte
group by person
order by total_friend desc

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
