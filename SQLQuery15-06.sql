create database table1
use table1
create table dbo.employee
(
	EID int,
	ENAME varchar(100),
	GRADE varchar(1),
	AGE int,
	GENDER varchar(1),
	STATES varchar(2),
	SALARY numeric(8,2)
)

insert into employee values
(101,'Goutam Sinha','A',40,'M','BH',50000.00)
insert into employee values
(102,'Srijan Basu','B',30,'M','WB',40000.00)
insert into employee values
(103,'Nandini Apte','A',45,'F','MH',57000.00)
insert into employee values
(104,'Satyen Mumu','B',33,'M','JH',32000.00)
insert into employee values
(105,'Priya Kumari','C',31,'F','JH',25000.00)
insert into employee values
(106,'Vignesh D','D',25,'M','TN',15000.00)
insert into employee values
(107,'Grishma Dasari','D',27,'F','AP',17000.00)

select * from dbo.employee
select ename,grade from employee
select ename,age,gender from employee
select ename,states as location1, age,states as location2 from employee
select eid as [Employee ID] ,ename as [Employee Name] from employee
select ename from employee where states='WB'
select ename from employee where age>=30

select distinct states from employee
select max(age) from employee
select min(age) from employee

select * from employee order by age asc