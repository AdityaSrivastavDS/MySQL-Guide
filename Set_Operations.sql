use university;

-- Table A
CREATE TABLE employees_A (
    emp_id INT,
    name VARCHAR(50)
);

INSERT INTO employees_A VALUES
(1, 'John'),
(2, 'Alice');

-- Table B
CREATE TABLE employees_B (
    emp_id INT,
    name VARCHAR(50)
);

INSERT INTO employees_B VALUES
(2, 'Alice'),
(3, 'Bob');



#union: combines the results of two or more table and remove the duplicates.
select name 
from employees_A
union
select name
from employees_B;



#Union All: combines the results of two or more tables but include duplicates as well.
select * from employees_A
union all
select * from employees_B;

/*Use Cases of Union and Union all:
1. union is used when we wanted straightforward and clear outputs without any replication.
2. union all used when we wanted complete results and don't wanted to miss any information as it returns duplicates also.*/


/*Intersect: The INTERSECT operator finds common rows between two SELECT queries. MySQL does not support INTERSECT directly,
but it can be emulated using an INNER JOIN or EXISTS.*/

#Query to find common employees in table employees_A and employees_B
SELECT name
FROM employees_A
WHERE name IN (
    SELECT name
    FROM employees_B
);


/*except or minus(Emulated): The EXCEPT operator returns rows from the first query that are not present in the second query. 
MySQL does not support EXCEPT directly, but it can be emulated using a LEFT JOIN or NOT IN.*/

#Query to find employees in employees_A but not in employees_B
SELECT name
FROM employees_A
WHERE name NOT IN (
    SELECT name
    FROM employees_B
);

