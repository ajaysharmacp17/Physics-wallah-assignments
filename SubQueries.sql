Create Database	Ash_LTD;
use Ash_LTD;

create table Employee
(emp_id int primary key , name varchar(50), department_id varchar(50), salary int);

insert into Employee values
(101, "Abhishek" , "D01", 62000),
(102, "Shubham", "D01", 58000),
(103, "Priya", "D02",67000),
(104, "Rohit", "D02",64000),
(105,"Neha","D03",72000),
(106, "Aman","D03",55000),
(107, "Ravi", "D04",60000),
(108, "Sneha","D04",75000),
(109,"Kiran", "D05",70000),
(110,"Tanuja","D05",65000);

create table Department
(department_id varchar(50), department_name varchar(50), location varchar(50));

insert	into Department values
("D01", "Sales", "Mumbai"),
("D02","Marketing","Delhi"),
("D03","Finance","Pune"),
("D04","HR","Bengaluru"),
("D05","IT","Hyderabad");

create table Sales 
(sale_id int, emp_id int, sale_amount int, sale_date date);

insert into Sales values 
(201,101, 4500, "2025-01-05"),
(202,102,7800,"2025-01-10"),
(203, 103, 6700, "2025-01-14"),
(204, 104, 12000, "2025-01-20"),
(205, 105, 9800, "2025-02-02"),
(206, 106, 10500, "2025-02-05"),
(207, 107, 3200, "2025-02-09"),
(208,108, 5100, "2025-02-15"),
(209, 109, 3900, "2025-02-20"),
(210, 110, 7200, "2025-03-01");

-- Basic Level
-- 1. Retrieve the names of employees who earn more than the average salary of all employees.
-- Ans. 

select name , salary
from employee
where salary > ( select avg(salary) from employee);

-- 2. Find the employees who belong to the department with the highest average salary.
-- Ans. 

select E.name , D.Department_id
from Employee E
join Department D
on E.Department_id = D.Department_id
where E.salary > ( select avg(salary) from employee);

-- 3. List all employees who have made at least one sale.
-- Ans.

select distinct E.name , E.emp_id
from Employee E
Join Sales S
on E.emp_id = S.emp_id;

-- 4. Find the employee with the highest sale amount.
-- Ans.

select E.name , S.sale_amount
from Employee E
join Sales S
on E.emp_id = S.emp_id
where sale_amount = (select max(sale_amount) from sales);

-- 5. Retrieve the names of employees whose salaries are higher than Shubham’s salary.
-- Ans.

select name , salary
from Employee
where salary > (select salary from employee where name = "Shubham");

-- Intermediate Level
-- 1. Find employees who work in the same department as Abhishek.
-- Ans. 

select E.name , E.department_id, D.department_name
from employee E
join Department D
on E.department_id = D.department_id
where E.Department_id = ( select department_id from employee where name = "Abhishek");

-- 2. List departments that have at least one employee earning more than ₹60,000.
-- Ans. 

select distinct D.department_name, E.name as Employees
from employee E
Join Department D
on E.department_id = D.department_id
where E.salary in ( select salary from employee where salary > 60000);

-- 3. Find the department name of the employee who made the highest sale.
-- Ans.

select D.department_name , E.name
from Employee E
join Sales S
on E.emp_id = S.emp_id
join Department D
on E.department_id = D.department_id
where S.sale_amount = (select max(sale_amount) from Sales);

-- 4. Retrieve employees who have made sales greater than the average sale amount.
-- Ans. 

select E.name , S.sale_amount as Averge_sale_amount
from Employee E
join Sales S
on E.emp_id = S.emp_id
where S.sale_amount > (select avg(sale_amount) from Sales);

-- 5. Find the total sales made by employees who earn more than the average salary.
-- Ans. 

select E.name , sum(S.sale_amount) as Total_sales
from Employee E
join Sales S
on E.emp_id = S.emp_id
where E.salary > (select avg(salary) from Employee)
group by E.emp_id, E.name;

-- Advanced Level
-- 1. Find employees who have not made any sales.
-- Ans. 

select E.name
from Employee E
join Sales S
on E.emp_id = S.emp_id
where S.emp_id is null;

-- 2. List departments where the average salary is above ₹55,000.
-- Ans. 

select D.Department_name , avg(E.salary) as Average_salary
from Employee E
join Department D
on E.department_id = D.department_id
group by D.	department_name
having Avg(E.salary) > 55000;

-- 3. Retrieve department names where the total sales exceed ₹10,000.
-- Ans. 

select distinct D.department_name
from Employee E
join Sales S
on E.emp_id = S.emp_id
join Department D
on 	E.department_id = D.department_id
where  S.sale_amount > 10000;

-- 4. Find the employee who has made the second-highest sale.
-- Ans. 

select E.name , S.sale_amount
from Employee E
join Sales S
on E.emp_id = S.emp_id
where S.sale_amount = (	select max(sale_amount) from Sales where sale_amount < (select max(sale_amount) from sales));

-- 5. Retrieve the names of employees whose salary is greater than the highest sale amount recorded.
-- Ans. 

select E.name , E.salary
from Employee E
join Sales S
on E.emp_id = S.emp_id
where E.salary > (select max(sale_amount) from sales);