--Using Sql Server--

--For the given schema, write SQL queries to perform the following:

--1. From the following tables write a SQL query to find the details of an employee. Return full name, email, salary, Department Name, postal code, and City.

SELECT CONCAT(e.first_name, ' ', e.last_name) AS [full name], e.email, e.salary, d.department_name as [Department Name], l.postal_code, l.city as City
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id;

--2. From the following tables write a SQL query to find the departments whose location is in "Jammu Kashmir" or "Jharkhand". Return Department Name, state_province, street_address.
select d.department_name as [Department Name],l.state_province,l.street_address
from departments d INNER JOIN locations l
on d.location_id=l.location_id
where l.state_province in ('Jammu Kashmir', 'Jharkhand');

--3. From the following tables write a SQL query to find the count of employees present in different jobs whose average salary is greater than 10,000. Return all the jobs with employee count, Job Name, and average salary.
SELECT COUNT(j.job_id) AS [employee count],j.job_title as [Job Name], AVG(e.salary) AS [average salary]
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
GROUP BY j.job_title
HAVING AVG(e.salary) > 10000;

--4. From the following table write a SQL query to find all the first names and last names in both dependents and employees tables Return the duplicate records as well and order the records in descending order of the last name column.
select first_name,last_name from employees
union all 
select first_name, last_name from dependents
order by last_name desc;


--5. From the following table write a SQL query to list every employee that has a manager with the name of his or her manager.

SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name, CONCAT(m.first_name, ' ', m.last_name) AS manager_name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;


--6. Find the departments that have more than 5 employees earning a salary greater than 50,000 and are located in either New York or California. Include the department name. location, and the number of employees meeting the criteria

SELECT d.department_name as [department name], l.state_province as [location], COUNT(e.employee_id) as [number of employees]
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
INNER JOIN locations l ON d.location_id = l.location_id
WHERE e.salary > 50000
AND l.state_province IN ('New York', 'California')
GROUP BY d.department_name, l.state_province
HAVING COUNT(e.employee_id) > 5;

--7. List any employees who have dependents and have a job title that includes the word "manager, and sort the results by department name in ascending order.
SELECT e.employee_id, e.first_name, e.last_name, j.job_title, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN dependents d2 ON e.employee_id = d2.employee_id
JOIN jobs j on e.job_id=j.job_id
WHERE j.job_title LIKE '%manager%'
ORDER BY d.department_name ASC;

--8. Add a column in the dependent table called "city" depicting their current location of stay. Find all employees who have been hired in the past 3 years and have dependents living in a city that is different from the city they work in (if I work in Kolkata, then my dependent should not be in Kolkata) Additionally, only include employees whose salary is greater than the average salary of their job title(suppose, my job_title is "developer" and the salary is 80k, and the average salary under the same job_title "developer is 70k), and whose manager's job title includes the word 'director Finally, include the department name and location of each employee, and sort the results by department name in ascending order

ALTER TABLE dependents
ADD city VARCHAR(255);

UPDATE dependents
SET city = 'Florida'
WHERE dependent_id=11;

UPDATE dependents
SET city = 'New York'
WHERE dependent_id=12;

UPDATE dependents
SET city = 'California'
WHERE dependent_id=13;

UPDATE dependents
SET city = 'Washington'
WHERE dependent_id=14;

UPDATE dependents
SET city = 'Kolkata'
WHERE dependent_id=15;

SELECT e.employee_id, e.first_name, e.hire_date, e.salary, j.job_title, dpt.department_name, l.city AS work_city, d.city AS dependent_city
FROM employees e
JOIN dependents d ON e.employee_id = d.employee_id
JOIN jobs j ON e.job_id = j.job_id
JOIN departments dpt ON e.department_id = dpt.department_id
JOIN locations l ON dpt.location_id = l.location_id
WHERE 
d.city != l.city -- employees hired in the past 3 years
AND e.hire_date >= DATEADD(YEAR, -3, GETDATE())  -- dependents living in a different city than their workplace
AND e.salary > (SELECT AVG(salary) FROM employees WHERE j.job_id = e.job_id)-- employees whose salary is greater than the average salary of their job title
AND j.job_title IN (SELECT job_title FROM jobs WHERE job_title LIKE '%director%') -- employees whose manager's job title includes the word 'director'
ORDER BY dpt.department_name ASC;
