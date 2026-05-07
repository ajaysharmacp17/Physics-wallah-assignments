create database	abc;

create table Customers (
CustomerID int primary key, CustomerName varchar (50), City varchar (50));

insert into customers values 
( 1, "John Smith", "New York"),
(2, "Mary Johnson", "Chicago"),
(3, "Peter Adams", "Los Angeles"),
(4, "Nancy Miller", "Houston"),
(5, "Robert White", "Miami");

select * from customers;

create table Orders (
OrderID int primary key , CustomerID int, OrderDate date , Amount int);

insert into	Orders values
( 101, 1, "2024-10-01", 250),
( 102, 2, "2024-10-05", 300),
( 103, 1, "2024-10-07", 150),
( 104, 3 , "2024-10-10", 450),
( 105, 6 , "2024-10-12", 400);

select * from Orders;

create table Payments (
PaymentID varchar (10) , CustomerID int, PaymentDate date , Amount int);


insert into	Payments values 
('P001', 1 , "2024-10-02", 250),
('P002', 2 , "2024-10-06", 300),
('P003', 3 , "2024-10-11", 450),
('P004', 4 , "2024-10-15", 200);

select * from Payments;

create table Employees (
EmployeeID int primary key, EmployeeName varchar (50), ManagerID varchar (10));

insert into Employees values
( 1, "Alex Green", NULL),
(2, "Brian Lee", 1),
(3, "Carol Ray", 1),
(4, "David Kim", 2),
(5, "Eva Smith", 2);

select * from Employees;

-- Q.1- Retrieve all customers who have placed at least one order.
-- Ans. 
select distinct customers. * from customers
inner join Orders 
on Customers.CustomerID = Orders.CustomerID;

-- Q.2- Retrieve all customers and their orders, including customers who have not placed any orders.
-- Ans. 

select c. *, o. *
from customers c
left join orders o
on c. CustomerID = o.CustomerID;

-- Q.3- Retrieve all orders and their corresponding customers, including orders placed by unknown customers.
-- Ans.

select c.*, o.*
from Customers c
right join Orders o
on c.CustomerID = o.CustomerID;


-- Q.4- Display all customers and orders, whether matched or not.
-- Ans.
select c.*, o.*
from Customers c
left join Orders o
on c.CustomerID = o.CustomerID

union

select c.*, o.*
from Customers c
right join Orders o
on c.CustomerID = o.CustomerID;

-- Q.5- Find customers who have not placed any orders.
-- Ans. 

select c.*
from Customers c
left join Orders o
on c.CustomerID = o.CustomerID
where o.OrderID is null;

-- Q.6- Retrieve customers who made payments but did not place any orders.
-- Ans.

select distinct c.*
from Customers c
inner join Payments p
on c.CustomerID = p.CustomerID
left join Orders o
on c.CustomerID = o.CustomerID
where o.OrderID is null;

-- Q.7- Generate a list of all possible combinations between Customers and Orders.
-- Ans. 

select c.CustomerName, o.OrderID
from Customers c
cross join Orders o;

-- Q.8- Show all customers along with order and payment amounts in one table.
-- Ans. 

select c.CustomerName,
       o.Amount AS OrderAmount,
       p.Amount AS PaymentAmount
from Customers c
left join Orders o
on c.CustomerID = o.CustomerID
left join Payments p
on c.CustomerID = p.CustomerID;

-- Q.9- Retrieve all customers who have both placed orders and made payments.
-- Ans.

select distinct c.*
from Customers c
inner join Orders o
on c.CustomerID = o.CustomerID
inner join Payments p
on c.CustomerID = p.CustomerID;










