-- Creates table dbo.SalesData if it doesn't exist, then inserts 10,000 random rows.
-- Review before running. I will not execute this for you.

IF OBJECT_ID(N'dbo.SalesData', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.SalesData
    (
        CustomerID INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(200) NOT NULL,
        Age TINYINT NOT NULL,
        City NVARCHAR(100) NOT NULL,
        PurchaseAmount DECIMAL(10,2) NOT NULL,
        PurchaseDate DATETIME2 NOT NULL
    );
END
GO

SET NOCOUNT ON;
BEGIN TRY
    INSERT INTO dbo.SalesData (Name, Age, City, PurchaseAmount, PurchaseDate)
    SELECT TOP (10000)
        fn.FirstName + N' ' + ln.LastName AS Name,
        CAST(ABS(CHECKSUM(NEWID())) % 60 + 18 AS TINYINT) AS Age, -- 18..77
        ci.City,
        CAST(ROUND(((ABS(CHECKSUM(NEWID())) % 199600) / 100.0) + 5.0, 2) AS DECIMAL(10,2)) AS PurchaseAmount, -- 5.00 .. ~2000.99
        DATEADD(day, - (ABS(CHECKSUM(NEWID())) % 3650), GETDATE()) AS PurchaseDate -- within last ~10 years
    FROM
        (
            SELECT TOP (10000) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
            FROM sys.all_objects a
            CROSS JOIN sys.all_objects b
        ) numbers
    CROSS APPLY (
        SELECT TOP (1) FirstName FROM (VALUES
            (N'James'),(N'Mary'),(N'John'),(N'Patricia'),(N'Robert'),(N'Jennifer'),
            (N'Michael'),(N'Linda'),(N'William'),(N'Elizabeth'),(N'David'),(N'Barbara'),
            (N'Richard'),(N'Susan'),(N'Joseph'),(N'Jessica'),(N'Thomas'),(N'Sarah'),
            (N'Charles'),(N'Karen')
        ) v(FirstName)
        ORDER BY NEWID()
    ) fn
    CROSS APPLY (
        SELECT TOP (1) LastName FROM (VALUES
            (N'Smith'),(N'Johnson'),(N'Williams'),(N'Brown'),(N'Jones'),(N'Garcia'),
            (N'Miller'),(N'Davis'),(N'Rodriguez'),(N'Martinez'),(N'Hernandez'),(N'Lopez'),
            (N'Gonzalez'),(N'Wilson'),(N'Anderson'),(N'Thomas'),(N'Taylor'),(N'Moore'),
            (N'Jackson'),(N'Martin')
        ) v2(LastName)
        ORDER BY NEWID()
    ) ln
    CROSS APPLY (
        SELECT TOP (1) City FROM (VALUES
            (N'New York'),(N'Los Angeles'),(N'Chicago'),(N'Houston'),(N'Phoenix'),
            (N'Philadelphia'),(N'San Antonio'),(N'San Diego'),(N'Dallas'),(N'San Jose'),
            (N'Austin'),(N'Jacksonville'),(N'Fort Worth'),(N'Columbus'),(N'Charlotte'),
            (N'San Francisco'),(N'Indianapolis'),(N'Seattle'),(N'Denver'),(N'Washington')
        ) c(City)
        ORDER BY NEWID()
    ) ci
    ORDER BY numbers.rn;
END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_SEVERITY() AS Severity, ERROR_STATE() AS State,
           ERROR_PROCEDURE() AS ProcedureName, ERROR_LINE() AS Line, ERROR_MESSAGE() AS Message;
END CATCH;
GO

select * from SalesData

SELECT
    City,
    COUNT(*) AS NumPurchases,
    SUM(PurchaseAmount) AS TotalSales,
    AVG(PurchaseAmount) AS AvgSale
FROM dbo.SalesData
GROUP BY City
ORDER BY TotalSales DESC;

SELECT TOP (5)
    City,
    COUNT(*)          AS NumPurchases,
    SUM(PurchaseAmount) AS TotalSales,
    AVG(PurchaseAmount) AS AvgSale
FROM dbo.SalesData
GROUP BY City
ORDER BY TotalSales DESC;



WITH CustomerTotals AS (
    SELECT
        Name,
        City,
        COUNT(*)             AS NumPurchases,
        SUM(PurchaseAmount)  AS TotalPurchases,
        AVG(PurchaseAmount)  AS AvgPurchase
    FROM dbo.SalesData
    GROUP BY Name, City
)
SELECT
    ct.Name,
    ct.City,
    ct.NumPurchases,
    ct.TotalPurchases,
    ct.AvgPurchase
FROM CustomerTotals ct
CROSS JOIN (SELECT AVG(TotalPurchases) AS OverallAvg FROM CustomerTotals) a
WHERE ct.TotalPurchases > a.OverallAvg
ORDER BY ct.TotalPurchases DESC;