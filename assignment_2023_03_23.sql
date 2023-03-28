--using sql server--

--Questions:
--1) Find all the departments where the minimum salary is less than 2000.

SELECT department_name FROM departments WHERE department_id IN(
  SELECT department_id
  FROM employees
  where department_id in
  (select department_id from 
			(SELECT DISTINCT department_id, 
			(SELECT MIN(salary) 
			FROM employees e2 
			WHERE e2.department_id = e1.department_id) AS min_salary
			FROM employees e1) t1 WHERE min_salary<2000)
);

--2) Find all the countries where no employees exist.

SELECT country_name
FROM countries
WHERE country_id NOT IN
	( SELECT country_id
	  FROM locations
	  WHERE location_id NOT IN
		  (SELECT department_id
		   FROM departments
		   WHERE department_id NOT IN
				(select department_id from employees)
		  )
	)
;

--3) From the following tables write a query to find all the jobs, having at least 2 employees in a single department.(don’t use joins)

select job_title from jobs where job_id in
(select distinct job_id from employees where department_id in
(SELECT department_id from (SELECT distinct department_id,(SELECT count(employee_id) 
			FROM employees e2 
			WHERE e2.department_id = e1.department_id) AS num_employee
			FROM employees e1) t1
where num_employee>=2)
)
;

--4)From the following tables write a query to find all the countries, having cities with all the city names starting with 'a'.(don’t use joins)

select country_name from countries where country_id in(SELECT DISTINCT l1.country_id
FROM locations l1
WHERE not EXISTS (
    SELECT *
    FROM locations l2
    WHERE l2.country_id = l1.country_id
    AND LEFT(l2.city, 1) != 'a'
	)
);

--5)From the following tables write a query to find all the departments, having no cities.

select department_name from departments where location_id in(select location_id from locations where city=null);