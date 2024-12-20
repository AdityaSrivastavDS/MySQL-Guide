#we will use our previously created University database
use University;

#Normalization
/*Normalization refers to the process of organizing data.
It involves breaking large tables into smaller, related tables and applying normalization forms(1NF, 2NF, 3NF)
to eliminate anomalies such as update and insert anomalies*/


#orders table to store information about orders placed by customers
create table orders(
      order_id int primary key,
      customer_id int,
      order_date date
      );
      
#customer table to store information related to customer who places orders
create table customer(
       customer_id int primary key,
       customer_name varchar(240)
       );
       
#In the above both tables one column is column which is customer_id which is relating both tables.
#Here we had break down a large table into two simple tables for orders and customers which will simplify the data




#Denormalization
/*the process of intentionally introducing redundancy into a database schema to improve query performance by
reducing the need for joins and aggregations. It is typically applied in read-heavy systems or for optimizing 
reporting and analytics queries*/

create table order_customer(
           order_id int primary key,
           order_date date,
           customer_id int,
           customer_name varchar(200)
           );
           
#In the above table we had combined every information which we usually distributed before in normalization. 