1.
1.1
select distinct 
case when col1 < col2 then col2 else col1 end as col1,
case when col1 < col2 then col1 else col2 end as col2
from InputTbl
1.2
select distinct
iif(col1<col2, col2, col1)  as first_cond,
iif(col1< col2, col1, col2) as second_cond
from inputtbl
2
delete from TestMultipleZero
where A=0 and B=0 and D=0 and C=0
3.
select * from section1
where id%2=1
4.
select * from section1
where id = (select min(id) from section1)
5.
select * from section1
where id = (select max(id) from section1)
6.
select * from section1
where name like 'b%'
7.
select * from ProductCodes 
where Code like '%[_]%'
