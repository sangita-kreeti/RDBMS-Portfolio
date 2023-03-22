CREATE TABLE jobs
(
    job_id INT PRIMARY KEY,
    job_title VARCHAR(255),
    min_salary FLOAT NOT NULL CHECK(min_salary>1000),
    max_salary FLOAT NOT NULL
)
CREATE TABLE regions
(
    region_id INT PRIMARY KEY,
    region_name VARCHAR(255),
)
CREATE TABLE countries
(
    country_id INT PRIMARY KEY,
    country_name VARCHAR(20),
	region_id INT,
	FOREIGN KEY(region_id) REFERENCES regions(region_id)
)
CREATE TABLE locations
(
	location_id INT PRIMARY KEY,
    street_address VARCHAR(255),
	postal_code varchar(10),
	city varchar(20),
	state_province varchar(50),
	country_id INT,
	FOREIGN KEY(country_id) REFERENCES countries(country_id)
)
CREATE TABLE departments
(
	department_id INT PRIMARY KEY,
    department_name VARCHAR(20),
	location_id INT,
	FOREIGN KEY(location_id) REFERENCES locations(location_id)
)	
CREATE TABLE employees
(
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	email varchar(50) NOT NULL,
	phone_number varchar(20) NOT NULL,
	hire_date DATE,
	job_id INT FOREIGN KEY(job_id) REFERENCES jobs(job_id),
	salary FLOAT NOT NULL,
	manager_id INT NOT NULL,
	department_id INT,
	FOREIGN KEY(department_id) REFERENCES departments(department_id)
)
CREATE TABLE dependents
(
	departmnet_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	relationship VARCHAR(20),
	employee_id INT,
	FOREIGN KEY(employee_id) REFERENCES employees(employee_id)
)


INSERT INTO jobs
VALUES ('101','Architect', '2000','20000'),
	   ('102','Secretary', '5000','40000'),
	   ('103','Data Entry Clerk', '3000','30000'),
	   ('104','Sales Manager', '7000','60000'),
	   ('105','Project Manager', '5000','50000');

INSERT INTO regions
VALUES('21','California'),
	  ('31','Alberta'),
	  ('41','Aargau'),
	  ('51','West Bengal'),
	  ('61','Queensland');

INSERT INTO countries
VALUES('121','United States','21'),
	  ('131','Canada','31'),
	  ('141',' Switzerland','41'),
	  ('151','India','51'),
	  ('161','Australia','61');
	 
INSERT INTO locations
VALUES('1','123 Main St','482031','San Francisco','California','121'),
	  ('2','156 Main St','364838',' Toronto','Canada','131'),
	  ('3','786 Main St','974832','Geneva','Switzerland','121'),
	  ('4','209 Main St','700009','Kolkata','India','121'),
	  ('5','675 Main St','924742','Sydney','Australia','121');

	  	 
INSERT INTO departments
VALUES('1','Marketing','2'),
	  ('2','HR','4'),
	  ('3','Sales','3'),
	  ('4','Customer Support','1'),
	  ('5','IT','4');

INSERT INTO Employees
VALUES('1001','SUSHMA','NATH','sushmanath03@gmail.com','6385030739','2020-05-13','103','29482','23','5'),
	  ('1002','ALIVIA','CHAKRABORTY','chakrabortyalivia1987@gmail.com','9894849234','2022-07-09','101','10482','25','4'),
	  ('1003','ARNAB','SEN','arnabsen@gmail.com','98403837493','2019-07-09','102','35482','10','3'),
	  ('1004','SOMA','DAS','dassoma76@gmail.com','6583946583','2016-09-09','101','17002','19','5'),
	  ('1005','SOVAN','PAUL','sovanpaul1989@gmail.com','8909746583','2022-08-11','103','26482','30','2'),
	  ('1006','KIRAN','MAITY','kiranmaity720@gmail.com','25537494595','2015-02-01','104','59482','98','1'),
	  ('1007','NISHITH','ROY','nishithroy@gmail.com','48302848593','2021-05-03','102','33482','7','5'),
	  ('1008','BIBEK','DUBEY','bibekdubey@gmail.com','3829038495','2022-07-09','103','20482','13','3'),
	  ('1009','DIVYA','SHAKSHI','shashidivya562@gmail.com','9403940566','2011-03-04','105','45002','5','5'),
	  ('1010','SHADAB','AHAMED','shadab67ahamed@gmail.com','68403948593','2022-04-02','101','15002','2','4');

INSERT INTO dependents
VALUES('11','SONIA','DAS','MOTHER','1004'),
	  ('12','NIBEDITA','ROY','MOTHER','1007'),
	  ('13','NIL','SEN','FATHER','1003'),
	  ('14','SONIA','BIBI','MOTHER','1010'),
	  ('15','SUMAN','PAUL','FATHER','1005');


ALTER TABLE departments ADD manager_name VARCHAR(255);
ALTER TABLE jobs DROP COLUMN max_salary;
ALTER TABLE locations RENAME COLUMN postal_code TO pincode;

drop table employees
drop table departments
drop table locations
drop table countries
drop table regions
drop table jobs
drop table dependents

select * from employees
select * from departments
select * from locations
select * from countries
select * from regions
select * from jobs
select * from dependents


-------Using SQL Server------


--1. Select all records in table “Employees” whose lastname starts with ‘Sah’

select * from employees
where last_name LIKE 'Sah%';

--2. Select 10 employees who were hired between 1stJune,2021 to 15thFebruary 2022.Start retrieving from the 4th record in the table.

select * from employees
WHERE hire_date BETWEEN '2021-06-01' AND '2022-02-15'
order by employee_id OFFSET 3 rows;


--3.Find distinct top5 salary values(onlysalarycolumn),using alias for column as “Top5 salaries”

select distinct top 5 salary as [Top5 salaries] from employees;

--4.Find first_name, last_name and email of employees from the employees table where salary lies between 25000 to 45000.

select first_name, last_name,email
from employees
where salary between 25000 and 45000;

--5.Write a query to find first_name, manager_id and salary where the department_id is 101 and sort the result in ascending order of salary.

select first_name, manager_id, salary
from employees
where department_id=101
order by salary asc;

--6.Find all the first_name that start with the letter “A”,and find all the last_name that have “TH” in the 2nd and 3rd positions.

select first_name, last_name
from employees
where first_name LIKE 'A%' and last_name LIKE '_TH%';


--1. Write the query to get the department and department wise total(sum) salary, display it in ascending order according to salary.

select d.department_name,sum(salary) as [total salary]
from employees as e,departments as d
where e.department_id=d.department_id
GROUP BY d.department_name
order by sum(salary) asc;

--2. Write the query to get the department, total no. employee of each department, total(sum) salary with respect to department from "Employee" table.
select d.department_name,count(e.department_id) as [employee no],sum(salary) as [total salary]
from employees as e,departments as d
where e.department_id=d.department_id
GROUP BY d.department_name;

--3. Get department wise maximum salary from "Employee" table order by salary ascending

select d.department_name,max(salary) as [highest salary] 
from employees as e, departments as d
where e.department_id=d.department_id
group by d.department_name
order by max(salary) asc;

--4. Write a query to get the departments where average salary is more than 60k

select d.department_name,avg(salary) as [avg salary] 
from employees as e, departments as d
where e.department_id=d.department_id
group by d.department_name
having avg(salary)>50000
order by avg(salary) asc;

--5. Write down the query to fetch department name assign to more than one Employee

select d.department_name,count(e.department_id)
from employees as e, departments as d
where e.department_id=d.department_id
group by d.department_name
having count(e.department_id)>2;


--6. Write a query to show department_name and assigned To where assigned To will be "One candidate" if its assigned to only one employee otherwise "Multiple candidates"

SELECT 
    d.department_name,
	case	
		when count(e.department_id) > 1 THEN 'One candidate'
		ELSE 'Multiple candidates'
	end AS assigned_to
		
From employees as e, departments as d
where e.department_id=d.department_id
group by d.department_name;