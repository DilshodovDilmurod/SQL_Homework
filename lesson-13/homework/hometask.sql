1.
select 
concat (EMPLOYEE_ID, '-', FIRST_NAME,' ', LAST_NAME)
from employees
2.
select replace (PHONE_NUMBER, '124', '999')as PHONE_NUMBER  
from EMPLOYEES
3.
select FIRST_NAME, len(FIRST_NAME) as LEN_NAME
from employees
where FIRST_NAME like '[AJM]%'
order by FIRST_NAME
4.
select e1.MANAGER_ID, sum(e1.SALARY) as TOTAL_SALARY
from employees e1
left join employees e2 on e1.MANAGER_ID = e2.EMPLOYEE_ID
where e1.MANAGER_ID!=0
group by e1.MANAGER_ID
5.
select Year1, case 
			when Max1> Max2 and Max1>Max2 then Max1
			when Max2 > Max1 and Max2 > Max3 then Max2
			else Max3 end as heighestValues
from TestMax
6.
select * from cinema
where id%2=1 and description !='boring'
7.
select * from SingleOrder
order by id desc
8.
select * from person
select 
	coalesce( ssn, passportid, itin) first_non_value
from person 

--Medium task
1.
select * from students
select 
	substring (FullName, 1, charindex(' ', FullName)) Firstname,
	substring (FullName, charindex(' ', FullName)+1, 
		charindex(' ', FullName, charindex(' ', FullName)+1) - charindex(' ', FullName)) Middlename,
	right(FullName, len(FullName)- charindex(' ', FullName, charindex(' ', FullName)+1)) Lastname
from students
2.
select * from orders
where CustomerID in( select CustomerID 
	from orders
	where DeliveryState = 'CA') 
and DeliveryState = 'TX' 
3.
select * from DMLTable
SELECT STRING_AGG(String, ' ') 
       WITHIN GROUP (ORDER BY SequenceNumber) AS FullQuery
FROM DMLTable
4.
select concat(FIRST_NAME, ' ', LAST_NAME) FULLNAME from employees
WHERE concat(FIRST_NAME, ' ', LAST_NAME) LIKE '%a%a%a%'
5.
select DEPARTMENT_ID , 
     count(*),
    100 * sum(case when datediff(year,HIRE_DATE,getdate()) >3 then 1 else 0 end)/count(*)
from Employees
group by DEPARTMENT_ID

difficult tasks
1.
select  * from Students
select 
	StudentID,
	grade,
	SUM(grade) over (order by StudentID) as cumulativergrade
from Students
order by StudentID
2.
select s1.StudentName, s2.StudentName
from Student s1
cross join Student s2
where DATEDIFF(day, s1.Birthday, s2.Birthday) = 0 and s1.StudentName < s2.StudentName
3.
select  sum(ps.Score) as score
from PlayerScores ps
cross join PlayerScores py
where (ps.PlayerA = py.PlayerB and ps.PlayerB = py.PlayerA)

4.
declare @my_str varchar(30) = 'dshUgFr54K./K''',
@checker int = 1, @uppercase varchar(30) = '', @lowercase varchar(30) = '', @integers varchar(30) = '',
@other_chars varchar(30) = ''
while @checker <= len(@my_str)
begin
if ASCII(SUBSTRING(@my_str, @checker, 1)) between 48 and 57
  set @integers = @integers + SUBSTRING(@my_str, @checker, 1)
else if ASCII(SUBSTRING(@my_str, @checker, 1)) between 65 and 90
  set @uppercase = @uppercase + SUBSTRING(@my_str, @checker, 1)
else if ASCII(SUBSTRING(@my_str, @checker, 1)) between 97 and 122
  set @lowercase = @lowercase + SUBSTRING(@my_str, @checker, 1)
else
  set @other_chars = @other_chars + SUBSTRING(@my_str, @checker, 1)
set @checker = @checker + 1
end
select @uppercase as uppercase, @lowercase as lowercase, @integers as integers, @other_chars as other_chars
