use University;

#Table1: student
CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    class_id INT
);

INSERT INTO student (student_id, name, age, class_id)
VALUES 
(1, 'John', 15, 101),
(2, 'Alice', 14, 102),
(3, 'Bob', 15, 101),
(4, 'Mary', 14, NULL),
(5, 'Tom', 16, 103);


#Table2: classes
CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50),
    teacher_id INT
);

INSERT INTO classes (class_id, class_name, teacher_id)
VALUES 
(101, 'Math', 201),
(102, 'Science', 202),
(103, 'English', 203),
(104, 'History', 204);


#Table3: teachers
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(50),
    subject VARCHAR(50)
);

INSERT INTO teachers (teacher_id, name, subject)
VALUES 
(201, 'Mr. Smith', 'Mathematics'),
(202, 'Ms. Johnson', 'Physics'),
(203, 'Mrs. Brown', 'English Literature'),
(204, 'Mr. Green', 'History');


select * from student;

select * from classes;

select * from teachers;




#Inner Join/Simple Join: return only rows whose matching values are in both the tables

#Simple inner join
select s.name, s.age, c.class_name
from student as s
inner join classes as c
on s.class_id = c.class_id;

#Inner join with condition
select s.name, s.age, c.teacher_id
from student as s
inner join classes as c
on s.class_id = c.class_id
where s.age > 15;



#Left Outer Join/Left Join: return all rows from left table and the only matchable values from right table
#Remember that position of table in inner join not matters but in left or right join it matters

#Simple left join
select c.class_name, t.name
from classes as c
left join teachers as t
on c.teacher_id = t.teacher_id;



#Right Outer Join/Right Join: return all rows from right table and only matchable rows from left table
SELECT s.name AS student_name, c.class_name
FROM student as s
RIGHT JOIN classes as c
ON s.class_id = c.class_id;



#Cross Join: returns the Cartesian product of the two tables. Every row in the first table is combined with every row in the second table.
SELECT s.name AS student_name, teachers.name AS teacher_name
FROM student as s
CROSS JOIN teachers;   #Pair each student with each teacher.


#Natural Join:  is a type of join that automatically joins tables based on columns with the same name and datatype.
SELECT classes.class_name, teachers.name AS teacher_name
FROM classes
NATURAL JOIN teachers;  #Combine classes and teachers based on teacher_id (use NATURAL JOIN if the columns have the same name in both tables).



/*Full Outer Join: This join is combination of left outer join and right outer join.
MySQL don't support direct full outer join like PostgreSQL, thus we use union to join left and right outer join to form 
full outer join */

select c.class_name, t.name
from classes as c
left join teachers as t
on c.teacher_id = t.teacher_id
union
SELECT s.name AS student_name, c.class_name
FROM student as s
RIGHT JOIN classes as c
ON s.class_id = c.class_id;



