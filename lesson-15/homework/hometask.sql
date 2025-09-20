1.
select * from employees
where salary = (select min(salary) from employees)
2.
select * from products
where price > (select avg(price) from products)
3.
select * from employees
where department_id = (select id from departments where department_name ='Sales')
4.
select * from customers
where customer_id not in (select customer_id from orders)
5.
select 
	product_name, category_id, 
	(select max(price) from  products p2 where p2.category_id = p1.category_id) max_price
from products p1
6.
with cte as (
select e1.name name,
		e1.salary salary, 
		e1.department_id department_id,
		(select avg(salary) from employees e2 where e2.department_id = e1.department_id) as avg_salary 
from employees e1
)
select * from cte
where avg_salary = (select max(avg_salary) from cte)
7.
select *, 
	(select avg(salary) from employees e2 where e2.department_id = e1.department_id) avg_salary 
from employees e1
where e1.salary > (select avg(salary) from employees e2 where e2.department_id = e1.department_id)
8.
select * from students
where student_id in (
		select student_id
		from grades g1 
		where g1.grade  = (select max(grade) from grades g2 where g2.course_id = g1.course_id)
		)
9.
with cte as (
select *,
ROW_NUMBER() over(partition by category_id order by price desc) rw
from products )
select * from cte
where rw =3
10.
with cte as(
select *, 
	(select max(salary) from employees e2 where e2.department_id = e1.department_id) max_dep, 
	(select avg(salary) from employees) avg_salary
from employees e1)

select * from cte
where salary between avg_salary and max_dep
