-------Using SQL Server------


--1. Select all records in table �Employees� whose lastname starts with �Sah�

select * from employees
where last_name LIKE 'Sah%';

--2. Select 10 employees who were hired between 1stJune,2021 to 15thFebruary 2022.Start retrieving from the 4th record in the table.

select * from employees
WHERE hire_date BETWEEN '2021-06-01' AND '2022-02-15'
order by employee_id OFFSET 3 rows;


--3.Find distinct top5 salary values(onlysalarycolumn),using alias for column as �Top5 salaries�

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

--6.Find all the first_name that start with the letter �A�,and find all the last_name that have �TH� in the 2nd and 3rd positions.

select first_name, last_name
from employees
where first_name LIKE 'A%' and last_name LIKE '_TH%';