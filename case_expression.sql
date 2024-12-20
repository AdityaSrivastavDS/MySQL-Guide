use University;

#create employee table
create table employee(
       cust_id int auto_increment primary key,
       cust_name varchar(200),
       salary int,
       bonus int
       );
       
insert into employee(cust_name, salary, bonus)
values
      ('Aditya',34000,2000),
      ('Rahul',32000,1000),
      ('Anupriya',43000,3600),
      ('Ishika',56000,3200),
      ('Ankit',12000,500),
      ('Mahir',68000,6800);
      

#Categorize employees as high, low, medium on the basis of their salary
select *,
case
    when salary between 20000 and 50000 then 'Medium'
    when salary > 51000 then 'High'
    else 'low'
end as salary_category
from employee;




