


-- Running some queries on our database.



-- Complete details of Customer;
select * from customer;


-- 1.> Names of Customers who have taken loan
select concat(c.f_name,' ',c.l_name) as NAMES from customer as c inner join loan as l on c.cust_id = l.cust_id;


-- 2.> Names of Employers who manages themseleves;  ~ unary relation
select concat(f_name,' ',l_name) as NAME from employee where managed_by is NULL;


-- 3.> Names of Customer  who have not taken loan
select * from customer where f_name not in (select c.f_name from customer as c inner join loan as l on c.cust_id = l.cust_id);



-- 4.> list of employers who manages customers
select concat(c.f_name,' ',c.l_name) as customer_name,concat(e.f_name,' ',e.l_name) as managed_by_employer from customer as c 
inner join employee as e on c.emp_id = e.emp_id;



select * from customer;
select * from branch;


-- 5.> Customers who have taken loan from outside the city they live

select concat(c.f_name,' ',c.l_name) as NAME,c.cust_id,c.city as he_lives_at,b.city as has_taken_loan_from from loan as l 
inner join branch as b on l.branch_id = b.branch_id
inner join customer as c on c.cust_id = l.cust_id where c.city != b.city;


-- 6.> Customers who have taken more than one loan

select * from customer where cust_id = (select cust_id from loan group by cust_id having count(cust_id) > 1);


-- 7.> customers who have not given any payment of loan

select concat(f_name,' ',l_name) as Name from customer where cust_id in 
(select cust_id from loan where cust_id not in
(select cust_id from loan as l inner join loan_payments as p on l.loan_id = p.loan_id));


-- 8.> Maximum loan amount ~ who have taken

select concat(f_name,' ',l_name) as Name from customer where cust_id = 
(select cust_id from loan where loan_amount = 
(select loan_amount from loan order by loan_amount desc limit 0,1));


select cust_id,loan_amount from loan;
select * from account;


 -- Harsh Raj has taken maximum loan and still hasnt given any payment 😲😲 he can do it i know 🙁
 
 
-- 9.> Accounts which are not active
 
 
 select * from account where account_status = 'Not-Active';
 
 -- 10.> Account having opening balance less than 5000
 
 select * from account where opening_balance < 5000;
 
 
 -- 11.> Branch_name which has given more than 1 loans
 
 select distinct (branch_name) , count(loan_id) from loan as l inner join branch as b on l.branch_id = b.branch_id 
 group by branch_name having
 count(loan_id) > 1;
 
 
 
 -- 12.>  Ordering Customers according to their number of loan_payments;
 
 select distinct l.loan_id,l.cust_id,count(lp.payment_no) as no_of_payments from loan as l
inner join loan_payments as lp on l.loan_id = lp.loan_id group by l.loan_id order by no_of_payments ;


-- 13.> second highest loan amount

select * from loan l1 where 2 = (select count(distinct(loan_amount)) from loan l2 where l2.loan_amount>=l1.loan_amount);
select max(loan_amount) from loan where loan_amount not in (select max(loan_amount) from loan);







select f_name as name from customer;
select upper(f_name) from customer;

-- unique value of city
select distinct city from customer;

select  city from customer group by city;

select substring(f_name,1,3) from customer;

select * from customer where f_name = 'Harsh';
select instr(f_name,'S') as index_of_s from customer where f_name = 'Harsh';

select rtrim(f_name) from customer ;
select ltrim(f_name) from customer;

select distinct city,length(city) as length_of_character from customer;
select replace(city,'a','A') from customer;

select upper(concat(f_name,' ',l_name)) as NAME from customer;

select * from customer order by city;

select * from customer order by city , address desc;

select * from customer where f_name in('Harsh','Shubham');

select * from customer where f_name not in('Harsh','Shubham');

select * from customer where f_name not like '%a%';
select * from customer where f_name like '%a';

select * from customer where year(date_of_birth) = 2002 and month(date_of_birth) = 08;

-- count of customer who lives in patna
select city, count(*) from customer group by city ;

select city,count(*) from customer group by city having city = 'Patna';


select city,count(*) from customer group by city order by city desc;
select city,count(*) from customer group by city order by count(*) ;

select city from customer where mod(emp_id,2) != 0;
select city from customer where mod(emp_id,2) <> 0;

-- creating clone of a table
create table loan_Clone like loan;
insert into loan_Clone select * from loan;

select * from loan;

-- finding intersection between loan and loan_clone using inner join
select * from loan inner join loan_Clone using (loan_id);

-- finding minus 
-- using left join
select loan.* from loan left join loan_Clone using(loan_id) where loan_Clone.loan_id = NULL;


select curdate();
select now();

select * from loan order by loan_amount desc;
select * from loan order by loan_amount desc limit 5;

-- 1st highest loan_amount
select * from loan order by loan_amount desc limit 0,1;

-- 2nd highest loan_amount
select * from loan order by loan_amount desc limit 1,1;

-- 5th highest loan_amount;

select loan_amount from loan l1 
where 4 = (
select count(distinct(loan_amount)) from loan l2
where  l2.loan_amount >= l1.loan_amount
);

-- list of people with having same loan_amount
select * from loan l1,loan l2 where l1.loan_amount = l2.loan_amount and l1.cust_id != l2.cust_id;

select loan_amount from loan;

-- second highest loan amount
select * from loan l1 where 2 = (select count(distinct(loan_amount)) from loan l2 where l2.loan_amount>=l1.loan_amount);
select max(loan_amount) from loan where loan_amount not in (select max(loan_amount) from loan);



-- union 
select * from loan 
union
select * from loan;