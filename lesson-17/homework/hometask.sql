1.
with cte as(
select r1.Region Region, r2.Distributor Distributor
from (
select distinct Region as Region from #RegionSales
) r1
cross join (
	select distinct Distributor as Distributor from #RegionSales
	) as r2
)
select cte.Region, cte.Distributor, ISNULL(r.Sales , 0) Sales
from cte
left join 
#RegionSales r on r.Region = cte.Region and r.Distributor = cte.Distributor
2.
with cte as 
(
select e1.managerId, count(e1.name) as count_name
from Employee e1
left join Employee e2 on e1.managerId = e2.id
where e1.managerId is  not null
group by e1.managerId
having count(e1.name) >= 5
)
select Employee.name 
from cte
join Employee on cte.managerId = Employee.Id
3.
select * from Products
select * from Orders

with cte as(
select product_id, sum(unit) total_unit from orders
where year(order_date) = 2020 and month(order_date) = 2
group by product_id
having sum(unit) >= 100
)
select Products.product_name, cte.total_unit
from cte
join Products on cte.product_id = Products.product_id
4.
with cte as(
select top(2) vendor, CustomerID, sum(Count) total_count from Orders
group by Vendor, CustomerID
order by total_count desc
)
select vendor, CustomerID from cte
5.
DECLARE @Check_Prime INT = 113, @num int =2, @res bit = 1;
while @num < sqrt(@Check_Prime)
	begin
		if @Check_Prime % @num =0 
			begin
			set @res = 0
				print('This number is not prime')
				break
			end
		else if @Check_Prime % @num !=0 
			begin
				set @num = @num + 1
			end
	end
if @res = 1 
print ('This number is  prime')

6.
;with cte3 as(
select Device_id, count(distinct Locations) no_of_location, count(Locations) no_of_signals from Device
group by Device_id
), cte as(
select device_id, Locations, count(Locations) count_loc from Device
group by Device_id, Locations
), cte2 as(
select  c1.device_id,  c1.Locations   
from cte c1
where c1.count_loc in (select max(count_loc) from cte c2 where c2.device_id = c1.device_id)
)
select cte2.Device_id, cte3.no_of_location, cte2.Locations max_signal_location, cte3.no_of_signals
from cte2
join cte3 on cte2.Device_id = cte3.Device_id
7.
select EmpID, EmpName, Salary
from Employee e1
where Salary >= (select avg(salary) from Employee e2 where e2.DeptID = e1.DeptID)
8.
select * from Numbers
;with cte as
(
select Tickets.TicketID, count(Numbers.Number) count_number
from Tickets
left join Numbers on Tickets.Number = Numbers.Number
group by TicketID
), cte2 as(
select * ,
case when count_number = 3 then 100
	when count_number<3 and count_number>0 then 10
	else 0 end amount
from cte 
)
select sum(amount) total_win from cte2
9.
select * from Spending
with user_platform as (
    select 
        user_id,
        spend_date,
        sum(case when platform = 'Mobile' then amount else 0 end) as mobile_amount,
        sum(case when platform = 'Desktop' then amount else 0 end) as desktop_amount
    from spending
    group by user_id, spend_date
)
select 
    spend_date,
    sum(case when mobile_amount > 0 and desktop_amount = 0 then 1 else 0 end) as mobile_only_users,
    sum(case when mobile_amount > 0 and desktop_amount = 0 then mobile_amount else 0 end) as mobile_only_amount,
    
    sum(case when desktop_amount > 0 and mobile_amount = 0 then 1 else 0 end) as desktop_only_users,
    sum(case when desktop_amount > 0 and mobile_amount = 0 then desktop_amount else 0 end) as desktop_only_amount,
    
    sum(case when mobile_amount > 0 and desktop_amount > 0 then 1 else 0 end) as both_users,
    sum(case when mobile_amount > 0 and desktop_amount > 0 then mobile_amount + desktop_amount else 0 end) as both_amount
from user_platform
group by spend_date
order by spend_date;

10.
with numbers as (
select 1 as n 
union all
select n +1 as n from Numbers
where n< 100
)
select g.Product, 1 as Quantity
from Grouped g
join Numbers n  on n.n <= g.Quantity
order by g.product

