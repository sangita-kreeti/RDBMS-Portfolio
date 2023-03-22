create database d5
use d5
create table dbo.Student
(
	Roll numeric(4),
	Fname varchar(10),
	Lname varchar(10),
	City varchar(12),
	Pincode numeric(6)
)

insert into Student values
(1001,'AMIT','MONDOL','KOLKATA',700015),
(1002,'RUMKI','BALA','KOLKATA',700020),
(1003,'KUNAL','CHANDA','SILIGURI',750058),
(1004,'ASHA','PATRA','',721320),
(1005,'SANJEEV','DAS','ASANSOL',713024),
(1006,'IPSHITA','DUTTA','SILIGURI',750050),
(1007,'AJAY','SINGH','KOLKATA',700015),
(1008,'JOY','CHATERJEE','',713024),
(1009,'SWEATA','PAUL','BARDWAN',713075),
(1010,'MOUSUMI','DAS','MEDINIPUR',721425)

select * from Student
select * from Student where City = ''
select Roll,Fname,Lname from Student where Pincode=700015 or Pincode=700020
select Roll,Fname,City from Student where Pincode=700015 and Lname='SINGH'
select Roll,Fname,City from Student where Pincode!=700015
select Roll,Fname,Lname from Student where Pincode>700015 and Pincode<700030
select Roll,Fname,City from Student where Fname like 'A%'
select Roll,Fname,City from Student where Fname=