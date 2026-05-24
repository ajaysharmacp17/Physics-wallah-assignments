create database Product;
use product;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3, 3, 2, '2024-01-10'),
(4, 4, 1, '2024-01-11');

select * from products;
select * from sales;

-- Q6. Write a CTE to calculate the total revenue for each product 
-- (Revenues = Price × Quantity), and return only products where  revenue > 3000.
-- Ans.

with Total_Revenue as (
select P.ProductID, P.ProductName, P.Price, S.Quantity, ( P.price * S.Quantity) as Revenue
from Products P
join Sales S
on P.ProductID = S.ProductID )
select * from Total_Revenue
where Revenue > 3000;

-- Q7. Create a view named vw_CategorySummary that shows: Category, TotalProducts, AveragePrice.
-- Ans. 

create view vw_CategorySummary as
select Category, count(ProductID) as TotalProducts,
avg(price) as AveragePrice 
from Products
group by category;

select * from vw_CategorySummary;

-- Q8. Create an updatable view containing ProductID, ProductName, and Price. 
-- Then update the price of ProductID = 1 using the view.
-- Ans.

	create view ProductPriceView as
    select ProductID, ProductName, Price 
    from Products;
    
update ProductPriceView 
set Price = 1500
where ProductID = 1;

select * from ProductPriceView;

-- Q9. Create a stored procedure that accepts a category name and returns all products belonging to that category.
-- Ans.
 
 Delimiter //
 
 create procedure ProductBycategory (
 in Category_name varchar(50)
 )
 begin
 select * from Products
 where Category = Category_name;
 end //
 Delimiter ;
 
 call ProductBycategory('Electronics') ;
 
 -- Q10. Create an AFTER DELETE trigger on the Products table that archives deleted product rows into a newtable ProductArchive .
 -- The archive should store ProductID, ProductName, Category, Price, and DeletedAt timestamp.
 -- Ans.
 
 delimiter //
 
 create trigger AfterProductDelete 
 after delete on Products
 for each row 
 begin
 insert into ProductArchive (
 ProductID, ProductName, Category, Price, DeletedAt 
 )
 values (Old.ProductID, Old.ProductName, Old.Category, Old.Price, Now());
 end //
 delimiter //
 
 
 
 
 
 