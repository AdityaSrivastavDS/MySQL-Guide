use university;

#Window Functions
/*Window functions, introduced in MySQL 8.0, perform calculations across a set of rows related to the current row within a result
set. Unlike aggregate functions, window functions do not collapse rows; they return a value for each row.*/

#Key Features
/*1.Perform calculations across a subset of data (partition or window).
2.Do not alter the number of rows in the result set.
3.Often used for ranking, cumulative totals, running averages, and other analytics./*

#Components of a Window Function
/*A window function consists of the following parts:

1.Function Name: E.g., ROW_NUMBER(), RANK(), SUM().
2.OVER Clause: Defines the window (set of rows) for the function.
3.PARTITION BY Clause (Optional): Divides the data into partitions.
4.ORDER BY Clause (Optional): Specifies the order of rows within each partition.*/


#Common Window Functions:--
/*1.Aggregate Functions as Window Functions:-
•SUM(), AVG(), MIN(), MAX(), COUNT()
Perform aggregate calculations over a window of rows.

2.Ranking Functions:-
•ROW_NUMBER(): Assigns a unique rank to rows.
•RANK(): Assigns ranks; ties get the same rank, with gaps.
•DENSE_RANK(): Similar to RANK() but no gaps in ranking.
•NTILE(n): Divides rows into n buckets.

3.Value Functions:-
•FIRST_VALUE(), LAST_VALUE(): Return the first or last value in a window.
•NTH_VALUE(): Returns the nth value in a window.

4.Offset Functions:-
•LEAD(): Accesses a subsequent row's value.
•LAG(): Accesses a preceding row's value.
*/


#Use Cases:-
/*
1.Analytics and Reporting: Ranking, cumulative sums, and running totals for dashboards.
2.Comparative Analysis: Comparing a row’s value with others in the dataset.
3.Data Cleaning: Identifying duplicates or rows based on ranking.
4.Time-Series Analysis: Calculating moving averages and trends.
*/

#Advantages:-
/*
1.Flexible Analytics: Perform complex calculations without collapsing rows.
2.Performance: Faster and more efficient than equivalent subqueries.
3.Readable Queries: Simplifies code for analytical queries.
4.Comprehensive Toolset: Wide variety of functions (ranking, offsets, aggregates).
*/

#Disadvantages:-
/*
1.Complexity: Requires understanding of OVER, PARTITION BY, and window frames.
2.Performance Impact: Can be slower with large datasets or improper indexing.
3.Limited in Older MySQL Versions: Available only in MySQL 8.0+.
*/

#Frame Clauses:-
/*
Control the subset of rows included in the window.

1.ROWS BETWEEN:
•Limits rows based on physical row positions.
•Example: ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING.

2.RANGE BETWEEN:
•Limits rows based on value ranges.
•Example: RANGE BETWEEN 10 PRECEDING AND CURRENT ROW.
*/

#Practical Implementation of Window Functions

#Table 1
CREATE TABLE sales_data (
    sales_id INT AUTO_INCREMENT PRIMARY KEY,
    region VARCHAR(50),
    salesperson VARCHAR(100),
    sales_date DATE,
    sales_amount DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO sales_data (region, salesperson, sales_date, sales_amount)
VALUES
('North', 'Alice', '2024-12-01', 500.00),
('North', 'Alice', '2024-12-02', 450.00),
('North', 'Bob', '2024-12-01', 300.00),
('North', 'Bob', '2024-12-03', 700.00),
('South', 'Charlie', '2024-12-01', 800.00),
('South', 'Charlie', '2024-12-02', 950.00),
('South', 'David', '2024-12-01', 200.00),
('South', 'David', '2024-12-03', 500.00),
('East', 'Eve', '2024-12-01', 400.00),
('East', 'Eve', '2024-12-02', 300.00),
('East', 'Frank', '2024-12-01', 600.00),
('East', 'Frank', '2024-12-03', 750.00),
('West', 'Grace', '2024-12-01', 1000.00),
('West', 'Grace', '2024-12-02', 1100.00),
('West', 'Heidi', '2024-12-01', 900.00),
('West', 'Heidi', '2024-12-03', 850.00);

#Table 2
CREATE TABLE stud (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    subject VARCHAR(50),
    score INT,
    exam_date DATE
);
-- Insert sample data
INSERT INTO stud (name, subject, score, exam_date)
VALUES
('Alice', 'Math', 85, '2024-12-01'),
('Alice', 'Science', 90, '2024-12-02'),
('Bob', 'Math', 75, '2024-12-01'),
('Bob', 'Science', 88, '2024-12-02'),
('Charlie', 'Math', 92, '2024-12-01'),
('Charlie', 'Science', 89, '2024-12-02'),
('David', 'Math', 66, '2024-12-01'),
('David', 'Science', 72, '2024-12-02'),
('Eve', 'Math', 80, '2024-12-01'),
('Eve', 'Science', 85, '2024-12-02'),
('Frank', 'Math', 70, '2024-12-01'),
('Frank', 'Science', 78, '2024-12-02');

#Table 3
CREATE TABLE emp (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(50),
    emp_name VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO emp (department, emp_name, hire_date, salary)
VALUES
('HR', 'Alice', '2020-01-15', 55000.00),
('HR', 'Bob', '2019-07-20', 60000.00),
('Finance', 'Charlie', '2021-03-10', 65000.00),
('Finance', 'David', '2018-08-25', 72000.00),
('Engineering', 'Eve', '2017-05-15', 80000.00),
('Engineering', 'Frank', '2022-02-01', 75000.00),
('Sales', 'Grace', '2016-11-30', 67000.00),
('Sales', 'Heidi', '2019-04-12', 69000.00),
('Marketing', 'Ivan', '2015-06-18', 73000.00),
('Marketing', 'Jack', '2023-01-20', 60000.00);



#Tables Overview:-
/*
1.sales_data:
•Columns: sales_id, region, salesperson, sales_date, sales_amount
•Use cases: Running totals, ranking sales by region, comparing sales trends.

2.stud:
•Columns: student_id, name, subject, score, exam_date
•Use cases: Ranking students, calculating averages, analyzing performance.

3.emp:
•Columns: emp_id, department, emp_name, hire_date, salary
•Use cases: Ranking employees, calculating cumulative salaries, analyzing hiring trends.
*/


#Calculate running total of sales 
select region, salesperson, sales_date, sales_amount,
      sum(sales_amount) over (partition by region order by sales_date) as running_total
from sales_data;


#Rank Students by Score
select name, subject, score,
       rank() over (partition by subject order by score desc) as ranked
from stud;


#Calculate Employees Cumulative Salary
select department, emp_name, salary,
      sum(salary) over (partition by department order by hire_date) as cumulative_salary
from emp;  #cumulative salary means that total amount of money earned by an individual over a specific period


#Identify top performers in each region without gaps in ranks
select region, salesperson, sales_date, sales_amount,
      dense_rank() over (partition by region order by sales_amount desc) as top_ranks
from sales_data;      


#Divide salespeople into quartiles based on sales performance.
#ntile(n): Divides rows into n equal groups, assigning a number to each group.
select salesperson, sales_amount,
      ntile(4) over (partition by sales_amount desc) as quartile
from sales_data;


#Compare a salesperson’s current day sales to the next day.
#lead(): Accesses data from the next row in the same result set.
select salesperson, sales_date, sales_amount,
      lead(sales_amount, 1) over (partition by salesperson order by sales_date) as next_day_sales
from sales_data;


#Analyze the day-over-day change in sales.
#lag(): Accesses data from the previous row in the same result set.
select salesperson, sales_date, sales_amount,
       lag(sales_amount, 1) over (partition by salesperson order by sales_date) as previous_day_sales
from sales_data;


#Find the first sale amount for each region.
#first_value: Returns the first value in an ordered partition.
select region, salesperson, sales_date, sales_amount,
       first_value(sales_amount) over (partition by region order by sales_date) as first_sale
from sales_data;


#Find the last sale amount for each region.
#last_value: Returns the last value in an ordered partition.
select region, salesperson, sales_date, sales_amount,
       last_value(sales_amount) over (partition by region order by sales_date rows between unbounded preceding and unbounded following) as last_sales
from sales_data;



#Calculate cumulative sales for each salesperson.
#Running Total (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
SELECT salesperson, sales_date, sales_amount,
       SUM(sales_amount) OVER (PARTITION BY salesperson ORDER BY sales_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM sales_data;


#Calculate a moving average of sales over the last three days.
#Moving Average (ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
SELECT salesperson, sales_date, sales_amount,
       AVG(sales_amount) OVER (PARTITION BY salesperson ORDER BY sales_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM sales_data;


#Combine Multiple Window Functions to get deeper insights
SELECT region, salesperson, sales_date, sales_amount,
       SUM(sales_amount) OVER (PARTITION BY region ORDER BY sales_date) AS running_total,
       RANK() OVER (PARTITION BY region ORDER BY sales_amount DESC) AS ranks,
       LEAD(sales_amount) OVER (PARTITION BY region ORDER BY sales_date) AS next_day_sales,
       LAG(sales_amount) OVER (PARTITION BY region ORDER BY sales_date) AS previous_day_sales
FROM sales_data;


