1.
select p.firstName, p.lastName, a.city, a.state
from Person p
left join Address a on p.personId = a.personId

2.
select e1.name
from Employee e1 
join Employee e2 on e1.managerId = e2.id
where e1.salary > e2.salary

3.
select p1.email
from Person p1
join Person p2 on p1.email = p2.email and p1.id< p2.id
drop table Person
4.
;with CTE as (
	select *,
	ROW_NUMBER() over (partition by email order by id) as rw
	from Person
)
delete from Cte where rw > 1
select id, email from Person

5.
select g.ParentName, g.name
from girls g
left join boys b on g.ParentName = b.ParentName
where b.ParentName is null

6
select custid, sum(freight) totalFreight , 
				min(freight) minfreight 
from TSQL2012.Sales.Orders
where freight>50 
group by custid

7.
select * from cart1
select * from cart2
select c1.Item, c2.Item
from cart1 c1
full join cart2 c2 on c1.Item = c2.Item
order by c1.Item desc

8.
select c.name
from Customers c
left join Orders o on c.id = o.customerId
where o.customerId is null

9.
SELECT 
    s.student_id,
    s.student_name,
    subj.subject_name,
    COUNT(e.student_id) AS attended_exams
FROM Students s
CROSS JOIN Subjects subj
LEFT JOIN Examinations e
    ON s.student_id = e.student_id
	AND subj.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, subj.subject_name
ORDER BY s.student_id, subj.subject_name;
