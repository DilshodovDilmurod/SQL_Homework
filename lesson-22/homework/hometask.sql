--1.
select total_amount,
sum(total_amount) over(order by order_date) RUNNING_TOTAL
from sales_data

--2.
select distinct product_category,
count(sale_id) over (partition by product_category) cnt_per_category
from sales_data

--3.
select distinct product_category,
max(total_amount) over(partition by product_category) max_total_amount
from sales_data

--4.
select distinct product_category,
min(unit_price) over(partition by product_category) min_unit_price
from sales_data

--5.
select total_amount,
cast(avg(total_amount) over (order by order_date 
	rows between 1 preceding and 1 following) as decimal(10,2)) avg_3_days
from sales_data

--6.
select distinct region,
sum(total_amount) over(partition by region) total_amount_per_reg
from sales_data

--7.
with cte as(
select distinct customer_id, customer_name, 
sum(total_amount) over(partition by customer_id) total_amount
from sales_data
)
select *, 
dense_rank() over(order by total_amount desc) reating
from cte

--8.
with cte as(
select *,
lag(total_amount) over(partition by customer_id
			order by order_date) previous_sales
from sales_data 
)
select customer_id, customer_name, total_amount, 
	previous_sales, total_amount- previous_sales differences
from cte
where previous_sales is not null

--9.
with cte as(
select product_name, product_category, unit_price,
dense_rank() over (partition by product_category order by unit_price desc) ds
from sales_data
)
select distinct product_name, product_category, unit_price from cte
where ds<=3

--10.
select region, order_date, total_amount,
sum(total_amount) over(partition by region order by order_date ) 
from sales_data

--11.
select distinct product_category, 
sum(total_amount) over(partition by product_category 
		order by product_category) total_amount_per_category
from sales_data

--12.
create table ids (id int)
insert into ids values (1), (2), (3), (4),(5)
select id,
sum(id) over(order by id) SUMPreValues
from ids

--13.
select value,
sum(value) over(order by value 
		rows between 1 preceding and current row) [Sum of Previous]
from OneColumn

--14.
with cte as(
select customer_id,customer_name,  product_category,
count(product_category) over(partition by customer_id order by product_category ) cnt_category
from sales_data
), cte2 as(
select* ,
dense_rank() over(partition by customer_name order by product_category) ds
from cte
)
select Customer_id, customer_name
from cte2
where ds>=2

--15.
with cte as (
select customer_id, customer_name, region, total_amount, 
sum(total_amount) over(partition by customer_id) sum_amount_per_cust,
avg(total_amount) over (partition by region ) avg_sale_reg
from sales_data
)
select distinct customer_name 
from cte
where sum_amount_per_cust > avg_sale_reg

--16.
with cte as(
select customer_id, total_amount, region,
sum(total_amount) over (partition by region order by customer_id)  sum_sale_per_custid
from sales_data
) 
select distinct customer_id, sum_sale_per_custid, region,
dense_rank() over(partition by region order by sum_sale_per_custid desc) reating
from cte
order by region 

--17.
select customer_id,customer_name, total_amount,
sum(total_amount) over(partition by customer_id 
		order by order_date) total_amount_per_custid
from sales_data

--18.
with cte as(
select distinct month(order_date) months,
sum(total_amount) over(partition by month(order_date)) total_amount_per_month
from sales_data
), cte2 as(
select* ,
lag(total_amount_per_month) over (partition by months order by months) previous_val
from cte
)
select months ,
total_amount_per_month - previous_val differences
from cte2

--19.
select customer_id, customer_name
from (
	select
		customer_id,
		customer_name,
		total_amount,
		lag(total_amount) over (partition by customer_id order by order_date) previous_sale
	from sales_data
	) as t
where total_amount > previous_sale

--20.
select distinct product_name
from (
	select
		product_name,
		unit_price,
		avg(unit_price) over(order by product_name) avg_unit_price
	from sales_data
	) t
where unit_price > avg_unit_price

--21.
select 
    Id,
    Grp,
    Val1,
    Val2,
    case 
        when row_number() over(partition by Grp order by Id) = 1 
        then sum(Val1 + Val2) over(partition by Grp) 
    end as Tot
from MyData

---22.

select ID, sum(Cost) Total_Cost,
case when min(Quantity) = max(Quantity) then min(Quantity)
else sum(Quantity) end as totalquanity
from TheSumPuzzle
group by ID


--23.
with ordered as (
    select SeatNumber,
           lag(SeatNumber) over(order by SeatNumber) as prev_seat
    from Seats
),
gaps as (
    select 
        prev_seat + 1 as GapStart,
        SeatNumber - 1 as GapEnd
    from ordered
    where prev_seat is not null
      and SeatNumber - prev_seat > 1
)
select * from (
    -- boshlanishidan oldingi gap
    select 1 as GapStart, min(SeatNumber)-1 as GapEnd
    from Seats
    union all
    -- ichki gaplar
    select GapStart, GapEnd from gaps
) q
where GapStart <= GapEnd
order by GapStart;
