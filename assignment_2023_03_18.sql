--MYSQL


--1. Creating the Schema
CREATE TABLE jobs
(
    job_id INT PRIMARY KEY,
    job_title VARCHAR(255),
    min_salary FLOAT NOT NULL CHECK(min_salary>1000), --Min_salary must be greater than 1000
    max_salary FLOAT NOT NULL
);
CREATE TABLE regions
(
    region_id INT PRIMARY KEY,
    region_name VARCHAR(255)
);
CREATE TABLE countries
(
    country_id INT PRIMARY KEY,
    country_name VARCHAR(20),
	region_id INT,
	FOREIGN KEY(region_id) REFERENCES regions(region_id)
);
CREATE TABLE locations
(
	location_id INT PRIMARY KEY,
    street_address VARCHAR(255),
	postal_code varchar(10), --Max length of postal_code should be 10
	city varchar(20),
	state_province varchar(50),
	country_id INT,
	FOREIGN KEY(country_id) REFERENCES countries(country_id)
);
CREATE TABLE departments
(
	department_id INT PRIMARY KEY,
    department_name VARCHAR(20),
	location_id INT,
	FOREIGN KEY(location_id) REFERENCES locations(location_id)
);	
CREATE TABLE employees
(
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL, --First_name should not be null
	last_name VARCHAR(255) NOT NULL, --Last_name should not be null
	email varchar(50) NOT NULL,
	phone_number varchar(20) NOT NULL,
	hire_date DATE,
	job_id INT FOREIGN KEY(job_id) REFERENCES jobs(job_id),
	salary FLOAT NOT NULL,
	manager_id INT NOT NULL,
	department_id INT,
	FOREIGN KEY(department_id) REFERENCES departments(department_id)
);
CREATE TABLE dependents
(
	departmnet_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	relationship VARCHAR(20),
	employee_id INT,
	FOREIGN KEY(employee_id) REFERENCES employees(employee_id)
);

--2. INSERT 5 ROWS IN JOBS TABLE

INSERT INTO jobs
VALUES ('101','Architect', '2000','20000'),
	   ('102','Secretary', '5000','40000'),
	   ('103','Data Entry Clerk', '3000','30000'),
	   ('104','Sales Manager', '7000','60000'),
	   ('105','Project Manager', '5000','50000');

--2. INSERT 5 ROWS IN REGIONS TABLE

INSERT INTO regions
VALUES('21','California'),
	  ('31','Alberta'),
	  ('41','Aargau'),
	  ('51','West Bengal'),
	  ('61','Queensland');

--2. INSERT 5 ROWS IN COUNTRIES TABLE

INSERT INTO countries
VALUES('121','United States','21'),
	  ('131','Canada','31'),
	  ('141',' Switzerland','41'),
	  ('151','India','51'),
	  ('161','Australia','61');
	 
----2. INSERT 5 ROWS IN LOCATIONS TABLE

INSERT INTO locations
VALUES('1','123 Main St','482031','San Francisco','California','121'),
	  ('2','156 Main St','364838',' Toronto','Canada','131'),
	  ('3','786 Main St','974832','Geneva','Switzerland','121'),
	  ('4','209 Main St','700009','Kolkata','India','121'),
	  ('5','675 Main St','924742','Sydney','Australia','121');

--2. INSERT 5 ROWS IN DEPARTMENTS TABLE
	  	 
INSERT INTO departments
VALUES('1','Marketing','2'),
	  ('2','HR','4'),
	  ('3','Sales','3'),
	  ('4','Customer Support','1'),
	  ('5','IT','4');

--2. INSERT 10 ROWS IN EMPLOYEES TABLE

INSERT INTO Employees
VALUES('1001','SUSHMA','NATH','sushmanath03@gmail.com','6385030739','2020-05-13','103','29482','23','5');
	  ('1002','ALIVIA','CHAKRABORTY','chakrabortyalivia1987@gmail.com','9894849234','2022-07-09','101','10482','25','4'),
	  ('1003','ARNAB','SEN','arnabsen@gmail.com','98403837493','2019-07-09','102','35482','10','3'),
	  ('1004','SOMA','DAS','dassoma76@gmail.com','6583946583','2016-09-09','101','17002','19','5'),
	  ('1005','SOVAN','PAUL','sovanpaul1989@gmail.com','8909746583','2022-08-11','103','26482','30','2'),
	  ('1006','KIRAN','MAITY','kiranmaity720@gmail.com','25537494595','2015-02-01','104','59482','98','1'),
	  ('1007','NISHITH','ROY','nishithroy@gmail.com','48302848593','2021-05-03','102','33482','7','5'),
	  ('1008','BIBEK','DUBEY','bibekdubey@gmail.com','3829038495','2022-07-09','103','20482','13','3'),
	  ('1009','DIVYA','SHAKSHI','shashidivya562@gmail.com','9403940566','2011-03-04','105','45002','5','5'),
	  ('1010','SHADAB','AHAMED','shadab67ahamed@gmail.com','68403948593','2022-04-02','101','15002','2','4');

--2. INSERT 5 ROWS IN DEPENDENTS TABLE

INSERT INTO dependents
VALUES('11','SONIA','DAS','MOTHER','1004'),
	  ('12','NIBEDITA','ROY','MOTHER','1007'),
	  ('13','NIL','SEN','FATHER','1003'),
	  ('14','SONIA','BIBI','MOTHER','1010'),
	  ('15','SUMAN','PAUL','FATHER','1005');


--3.a. Column: In departments table, add a new field ‘manager_name’ of type VARCHAR
ALTER TABLE departments ADD manager_name VARCHAR(255);
--3.b. REMOVE field max_salary from jobs. 
ALTER TABLE jobs DROP COLUMN max_salary;
--3.c.In the locations table, rename postal_code column to pincode.
ALTER TABLE locations RENAME COLUMN postal_code TO pincode;



