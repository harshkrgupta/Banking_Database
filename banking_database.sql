

-- BANKING SYSTEM


-- ~~ first lets see the ER daigram of our banking system 😊


create database if not exists banking_details;


use banking_details;


create table customer(
cust_id varchar(6) not null primary key,
f_name varchar(30) not null,
l_name varchar(30) not null,
date_of_birth date not null ,
gender varchar(10) not null,
address varchar(255) not null,
occupation varchar(10),
contact_no varchar(10) not null,
emp_id int,
CONSTRAINT emp_cust_fk FOREIGN KEY(emp_id) REFERENCES  employee(emp_id) on delete cascade
);

alter table customer add city varchar(15);

alter table customer modify occupation varchar(100);


-- relation ~ customer borrows loan


create table branch(
branch_id int not null primary key,
branch_name varchar(255),
ifsc_code varchar(11),  -- ifsc code is 11 character code
city varchar(50) not null,
address varchar(255) not null
);

-- customer borrows loan


create table loan(
loan_amount int,
loan_id int not null primary key,
branch_id int,
cust_id varchar(6),
CONSTRAINT loan_bid_fk FOREIGN KEY(branch_id) REFERENCES  branch(branch_id) on delete cascade,
CONSTRAINT loan_custid_fk FOREIGN KEY(cust_id) REFERENCES  customer(cust_id) on delete cascade
);




-- relation ~ loan originated by branch
-- customer A have account B in branch C



create table account(
account_no int primary key,
cust_id varchar(6),
branch_id int,
account_type varchar(10),
accont_status varchar(10),
account_opening_date date,
opening_balance int(7),
CONSTRAINT account_custid_fk FOREIGN KEY(cust_id) REFERENCES customer(cust_id) on delete cascade,
CONSTRAINT account_bid_fk FOREIGN KEY(branch_id) REFERENCES branch(branch_id)  on delete cascade
);


alter table account rename column accont_status to account_status;



-- relation ~ loan has loan payments



create table loan_payments(
loan_id int,
payment_no int primary key,
payment_amount int ,
payment_date date,
CONSTRAINT loan_id_fk FOREIGN KEY(loan_id) REFERENCES loan(loan_id)
);


-- relation ~ customer managed by employee
-- relation ~ employee manages employee


-- unary relation
create table employee(
emp_id int primary key,
managed_by int default null,
start_date date,
f_name varchar(23),
l_name varchar(23),
contact_no varchar(10),
CONSTRAINT employee_ibfk_1 FOREIGN KEY (managed_by) REFERENCES employee(emp_id) on delete cascade
);

drop table employee ;

drop database if exists banking_details;


desc customer;
desc account;
desc loan;
desc loan_payments;
desc branch;


-- considering it for 10 customers
-- putting in some random values to run queries.


select * from customer;



insert into customer values
(cust_id,f_name,l_name,date_of_birth,gender,address,occupation,contact_no,emp_id,city),
('CHR669','Harsh','Raj','2000-10-23','Male','Kurthoul','Student','7634915669',1,'Patna'),
('CSK148','Shubham','Kumar','2003-05-02','Male','Dupulwa','WorksAtDVT','8114566148',1,'Patna'),
('CRK225','Rishab','Kumar','2000-12-30','Male','Adityapur','SoftwareIntern','9145126225',3,'Jamshedpur'),
('CRS854','Raj','Singh','2002-02-07','Male','Ramapuram','Broker','8294713854',5,'Chennai'),
('CRR589','Riya','Rajput','2003-02-07','Female','Noida 12','HR Executive','8242857589',5,'Delhi'),
('CPS749','Priya','Singh','2003-02-23','Female','Kandi','School Teacher','8499582749',4,'Hyderabad'),
('CRG242','Rounak','Gupta','2002-08-30','Male','Bairiya','Cricketer','8234223242',3,'Motihari'),
('CSK747','Sunidhi','Kumari','2001-03-07','Female','Hauz Khas','Student','8948275747',3,'Delhi'),
('CAK929','Abhishek','Kumar','2003-07-21','Male','Ashthawan','Teacher','9374937929',3,'Nalanda'),
('CRR747','Ravi','Raj','2002-09-24','Male','Mithapur','Army officer','8485475747',2,'Patna');



insert into employee values
(emp_id,managed_by,start_date,f_name,l_name,contact_no),
('001',NULL,'2002-03-09','Ravish','Raj','8394739208'),
('005',NULL,'2002-06-10','Harsh','Kumar','8394736457'),
('002','001','2003-09-21','Sonam','Kapoor','8374902374'),
('003','002','2004-07-19','Singheswaram','Pandey','8399870908'),
('004','003','2004-09-21','Punit','Kumar','9836452799');



SET SQL_SAFE_UPDATES = 1;
delete from employee;
select * from employee;

desc customer;

select * from employee;
select * from customer;


insert into branch values
(branch_id,branch_name,ifsc_code,city,address),
(1,'Mithapur','MITHA838','Patna','Mithapur Patna'),
(2,'Adityapur','ADITY101','Jamshedpur','Adityapur Jamshedpur'),
(3,'Hauz Khas','HAUZK847','Delhi','Hauz Khas Delhi'),
(4,'Bypass','BYPAS389','Motihari','Bypass Motihari'),
(5,'Kandi','KANDI820','Hyderabad','Kandi Hyderabad');


insert into loan values
(loan_amount,loan_id,branch_id,cust_id),
(100000,1,3,'CRR589'),
(550000,2,3,'CAK929'),
(76000,3,4,'CRG242'),
(890000,4,1,'CHR669'),
(25000,5,4,'CAK929');

insert into loan_payments values
(loan_id,payment_no,payment_amount,payment_date),
(2,1,100000,'2020-02-19'),
(2,2,100000,'2020-03-04'),
(3,3,10000,'2020-04-09'),
(1,4,50000,'2019-04-21'),
(1,5,1000,'2019-03-22');


desc account;

insert into account values
(account_no,cust_id,branch_id,account_type,account_status,account_opening_date,opening_balance),
(87625,'CAK929',4,'Savings','Active','2012-03-21',10000),
(67576,'CRR747',1,'Recuring','Active','2020-03-09',30000),
(29373,'CSK747',3,'Current','Active','2018-04-23',35000),
(67598,'CRG242',4,'Recuring','Active','2017-08-09',10000),
(23567,'CPS749',1,'Savings','Not-Active','2015-07-26',50000),
(56886,'CRR589',3,'Current','Not-Active','2020-09-23',20000),
(98759,'CRS854',1,'Savings','Active','2017-08-23',25000),
(56498,'CRK225',5,'Savings','Active','2018-09-30',45000),
(89986,'CSK148',1,'Recurring','Not-Active','2015-02-27',4500),
(56909,'CHR669',1,'Recuring','Active','2019-05-28',10000);



select * from account;
select * from branch;
select * from customer;
select * from employee;
select * from loan;
select * from loan_payments;













