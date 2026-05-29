create database Sales_Transactions;
use Sales_Transactions;

Create table sales (
Txn_ID int primary key, Customer_ID varchar(50), Customer_Name varchar(50), Product_ID varchar (50), Quantity varchar(50), 
Txn_Amount Int , Txn_Date date , City varchar (50));

insert into sales values (
201, 'C101', 'Rahul Mehta', 'P11', '2', 4000, '2025-12-01', 'Mumbai'),
(202, 'C102', 'Anjali Rao', 'P12', '1', 1500, '2025-12-01', 'Bengaluru'),
(203, 'C101', 'Rahul Mehta', 'P11', '2', 4000, '2025-12-01', 'Mumbai'),
(204, 'C103', 'Suresh Iyer', 'P13', '3', 6000, '2025-12-02', 'Chennai'),
(205, 'C104', 'Neha Singh', 'P14', NULL, 2500, '2025-12-02', 'Delhi'),
(206, 'C105', 'N/A', 'P15', '1', NULL, '2025-12-03', 'Pune'),
(207, 'C106', 'Amit Verma', 'P16', '1', 1800, NULL, 'Pune'),
(208, 'C101', 'Rahul Mehta', 'P11', '2', 4000, '2025-12-01', 'Mumbai');

create table Customers_Master (CustomerID varchar (50), CustomerName varchar(50), City varchar(50));
insert into Customers_Master values 
('C101', 'Rahul Mehta','Mumbai'),
('C102', 'Anjali Rao','Bengaluru'),
('C103', 'Suresh Iyer','Chennai'),
('C104', 'Neha Singh','Delhi');


-- Question 7 : Write an SQL query on Sales_Transactions to list all duplicate keys and their counts using the 
-- business key (Customer_ID + Product_ID + Txn_Date + Txn_Amount ).
-- Ans.  
select Customer_ID , Product_ID , Txn_Date , Txn_Amount, count(*) as Duplicate_Values
from sales
group by Customer_ID , Product_ID , Txn_Date , Txn_Amount
having count(*) > "1" ;

-- Question 8 : Enforcing Referential Integrity Assume the following table: Customers_Master
-- Ans.

select S.Customer_ID
from Sales S
left join Customers_Master C
on S.Customer_ID = C.CustomerID
where C.CustomerID is null;
