1.
select 
left(Name, charindex(',', Name)-1) Name,
substring (Name, charindex(',', Name)+1, len(Name)) Surname
from TestMultipleColumns
2.
select * from TestPercent
where Strs like '%[%]%'
3.
with cte as (
select
	s.Vals as Vals,
	ss.value valuess,
	row_number() over(partition by s.vals order by (select null)) as rw
from Splitter s
cross apply string_split(s.vals, '.') ss 
)
select 
Vals,
	max(case when rw = 1 then valuess end) as Part1,
	max(case when rw = 2 then valuess end) as Part2,
	max(case when rw = 3 then valuess end) as Part3
from cte
group by Vals
4.
select * from testDots
where Vals like '%.%.%.%'
5.
select 
len(texts) - len(REPLACE(texts, ' ', '')) countSpaces
from CountSpaces
6.
select e1.EMPLOYEE_ID, e1.SALARY, e1.MANAGER_ID, e2.SALARY
from Employees e1
join Employees e2 on e1.MANAGER_ID = e2.EMPLOYEE_ID
where e1.SALARY > e2.SALARY
7.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, DATEDIFF(year, HIRE_DATE, getdate()) as service_year
from Employees
where DATEDIFF(year, HIRE_DATE, getdate())> 10 
	and DATEDIFF(year, HIRE_DATE, getdate()) < 15

--Medium tasks
1.
select w2.Id, w2.RecordDate, w2.Temperature
from weather w1
cross join weather w2 
where DATEDIFF(day, w1.RecordDate, w2.RecordDate) = 1 
	and w2.Temperature > w1.Temperature
2.
select player_id, min(event_date) from Activity
group by player_id
3.
declare @my_fruit varchar(50)
select @my_fruit = fruit_list from fruits
select value
from string_split(@my_fruit, ',', 1)
where ordinal = 3
4.
select *,
case when datediff(year, HIRE_DATE, getdate()) =1 then 'New hire'
	 when datediff(year, HIRE_DATE, getdate()) between 1 and 5 then 'Junior'
	 when datediff(year, HIRE_DATE, getdate()) between 5 and 10 then 'Mid-Level'
	 when datediff(year, HIRE_DATE, getdate()) between 10 and 20 then 'Senior'
	 when datediff(year, HIRE_DATE, getdate()) > 20 then 'Veteran' end Level
from Employees
5.
select left(VALS, 1) as numbers from GetIntegers
where VALS like '[0-9]%'
--Dificult Task
1.
SELECT 
    Id,
    SUBSTRING(Vals, CHARINDEX(',', Vals) + 1, 
              CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1)  - CHARINDEX(',', Vals)) 
    + ',' +
    LEFT(Vals, CHARINDEX(',', Vals) - 1) +
    SUBSTRING(Vals, CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1), LEN(Vals))
AS SwappedVals
FROM MultipleVals;

2.
declare @my_str nvarchar(60) = 'sdgfhsdgfhs@121313131',
@checker int = 1, @string nvarchar(80) =''
while @checker <= len(@my_str)
	begin
		set @string  = @string + substring(@my_str, @checker, 1) + ' '
		set @checker = @checker + 1
	end 
select 
	value
from string_split(@string, ' ', 1)
where ordinal < = len(@my_str)

3.
select player_id, device_id
from Activity
where event_date in (select min(event_date) from Activity  group by player_id)
4.
declare @my_str nvarchar(30) = 'rtcfvty34redt', @checker int=1,
@num nvarchar(20) = '', @str nvarchar(20) =''
while @checker < len(@my_str) 
begin
	if ASCII(substring(@my_str, @checker, 1)) between  48 and 57
		set @num = @num + substring(@my_str, @checker, 1)
	else if ASCII(substring(@my_str, @checker, 1)) between 97 and 122
		set @str = @str + substring(@my_str, @checker, 1)
	set @checker = @checker + 1
end
select @num as number, @str as string 
