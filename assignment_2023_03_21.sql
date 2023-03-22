------sql server--------

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