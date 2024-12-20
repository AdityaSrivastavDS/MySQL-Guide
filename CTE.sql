use university;

create table employees(
          emp_id int auto_increment primary key,
          name varchar(200),
          department char(60),
          salary int
          );
          
insert into employees(name, department, salary)
values
      ('John',	'IT' ,5000),
      ('Alice' ,'HR' ,4000),
      ('Bob' ,'IT'	,6000),
      ('Mary'	,'Sales' ,4500);
      
      
/*CTE: is a temporary result set defined within the execution scope of a single SELECT, INSERT, UPDATE, or DELETE statement. 
It improves readability and allows you to reuse the result in the same query.*/

#Find employees from the IT department with a salary above the average
with avg_salary as(
      select avg(salary) as avg_salary
      from employees
      where department = 'IT'
)
select name, salary
from employees, avg_salary
where department = 'IT' and salary > avg_salary.avg_salary;