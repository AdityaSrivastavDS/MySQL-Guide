create database University;   #creating database

use University;  #using created database


#Creating a table and defining its schema
create table student(
	   name char(200),
       roll_no int(40),
       dept char(60),
       section varchar(30),
       primary key (roll_no)
       );
       
#Inserting values into table student
INSERT INTO student (name, roll_no, dept, section)
VALUES
    ('Aarav Sharma', 1, 'Computer Science', 'A'),
    ('Ananya Verma', 2, 'Mechanical Engineering', 'B'),
    ('Rohan Gupta', 3, 'Electrical Engineering', 'C'),
    ('Isha Patel', 4, 'Civil Engineering', 'A'),
    ('Karan Singh', 5, 'Computer Science', 'B'),
    ('Meera Nair', 6, 'Mechanical Engineering', 'C'),
    ('Vikram Rao', 7, 'Electrical Engineering', 'A'),
    ('Pooja Desai', 8, 'Civil Engineering', 'B'),
    ('Arjun Mehta', 9, 'Computer Science', 'C'),
    ('Sneha Joshi', 10, 'Mechanical Engineering', 'A'),
    ('Rahul Kumar', 11, 'Electrical Engineering', 'B'),
    ('Priya Reddy', 12, 'Civil Engineering', 'C'),
    ('Nikhil Chawla', 13, 'Computer Science', 'A'),
    ('Simran Kaur', 14, 'Mechanical Engineering', 'B'),
    ('Amit Bhatia', 15, 'Electrical Engineering', 'C'),
    ('Neha Kapoor', 16, 'Civil Engineering', 'A'),
    ('Ravi Malhotra', 17, 'Computer Science', 'B'),
    ('Divya Sharma', 18, 'Mechanical Engineering', 'C'),
    ('Siddharth Jain', 19, 'Electrical Engineering', 'A'),
    ('Tara Iyer', 20, 'Civil Engineering', 'B');
    

#Accessing records from the table
select * from student;


#Accessing data with conditions using where clause

#Single conditions
select * from student
where section = 'A';

select name, roll_no from student 
where dept = 'Computer Science';
 
select name from student
where roll_no between 4 and 6;

#multiple conditions
select * from student
where dept = 'Computer Science' and section = 'B';

select name, roll_no, dept
from student
where section = 'C' and roll_no = 4;


#Accessing specific number of frecords using limit
select * from student
limit 4;


#grouping the able based on columns using group by
#remember that group can only be used when we are using an aggregate function like sum, min etc and that aggregated field should be present in group by
select dept, name, min(roll_no) as roll_no
from student 
group by roll_no;



#using like
select * from student
where name like '%A';    #name that ends with A

select * from student 
where name like 'A%'; #name that starts with A

select * from student 
where name like '%c%';  #name that contains c

select * from student
where name like 'A%a';   #name that starts with A and ends with a

select * from student 
where name like '__v%';   #name whose starting 2nd character is v



#Updating table using alter

alter table student
rename as students;     #renamed the table student as students

select * from students;


#changing name of column section to sec
alter table students
rename column section to sec;      #used column to access columns of the table


#changing the datatype of the fields of table using modify
alter table students
modify column name varchar(200);


#adding new column to the table using add
alter table students
add class varchar(20);

select * from students;



#order by used to arrange data in a particular sequence either ascending or descending
select * from students
order by name asc;     #asc ise used to arrange in ascending order

select name, dept from students
order by dept desc;     #desc is used to arrange in descending order



#view: virtual table, which is created when we wanted to limit the access to specific records or simpliy queries
create view student_info as
select name, dept 
from students 
where dept = 'Computer Science';

select * from student_info;



#trigger: we used to create triggers to execute a sql query whenever any specific event occurs, this is useful for automating queries

-- Step 1: Create a log table to store trigger events
CREATE TABLE student_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    action_type VARCHAR(50),
    student_name VARCHAR(100),
    department VARCHAR(100),
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 2: Create a trigger for INSERT action
DELIMITER //
CREATE TRIGGER after_student_insert
AFTER INSERT ON students
FOR EACH ROW
BEGIN
    INSERT INTO student_log (action_type, student_name, department)
    VALUES ('INSERT', NEW.name, NEW.dept);
END;
//
DELIMITER ;

#insert values in student_info table to check
INSERT INTO students (name, roll_no, dept, sec, class)
VALUES ('Ishika Khanna', 21, 'Computer Science', 'D', '');

select * from student_log;

#Trigger for delete action
DELIMITER //
CREATE TRIGGER after_student_delete
AFTER DELETE ON students
FOR EACH ROW
BEGIN
    INSERT INTO student_log (action_type, student_name, department)
    VALUES ('DELETE', OLD.name, OLD.dept);
END;
//
DELIMITER ;

delete from students
where roll_no = 21;

select * from student_log;

#trigger for update operation
DELIMITER //
CREATE TRIGGER after_student_update
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
    INSERT INTO student_log (action_type, student_name, department)
    VALUES ('UPDATE', CONCAT('OLD: ', OLD.name, ' -> NEW: ', NEW.name),
                    CONCAT('OLD: ', OLD.dept, ' -> NEW: ', NEW.dept));
END;
//
DELIMITER ;



#Note:- Trigger can only be created on base or main table , it cannot be created on views or temporary tables




#Index: Its a data structure in sql which improves the data retrieval speed of SQL Engine
create index info on students (name);

#explain: statement provides insights into the query execution plan, helping identify potential areas for optimization
explain select name, dept
from students
where dept = 'Computer Science';



