CREATE DATABASE Testing;
USE Testing;

-- CAPSTONE PROJECT Q&A --

-- Question 1:  List all suppliers in the UK --
SELECT * FROM [dbo].[Supplier]
WHERE Country = 'UK';

-- Question 2: List the first name, last name, and city for all customers. Concatenate the first and last name separated by a space and a comma as a single column --
SELECT Concat (FirstName, ', ', LastName) AS [Customer Name], City 
FROM [dbo].[Customer]

-- Question 3: List all customers in Sweden --
SELECT * FROM [dbo].[Customer]
WHERE Country = 'Sweden';

-- Question 4:  List all suppliers in alphabetical order --
SELECT * FROM [dbo].[Supplier]
ORDER BY CompanyName ASC

-- Question 5: List all suppliers with their products --
SELECT 
    s.CompanyName, 
    s.ContactName, 
    p.ProductName
FROM [dbo].[Supplier] s
JOIN [dbo].[Product] p ON s.Id = p.SupplierId;

-- Question 6: List all orders with customers information --
SELECT 
    o.OrderDate, 
    o.OrderNumber, 
    o.CustomerId, 
    c.FirstName, 
    c.LastName, 
    c.City, 
    c.Country, 
    c.Phone
FROM [dbo].[Order] o
JOIN [dbo].[Customer] c ON o.CustomerId = c.Id;

-- Question 7: List all orders with product name, quantity, and price, sorted by order number --
SELECT 
    o.OrderDate, 
    o.OrderNumber, 
    i.Quantity, 
    i.UnitPrice, 
    p.ProductName
FROM [dbo].[Order] o
JOIN [dbo].[OrderItem] i ON o.Id = i.OrderId
JOIN [dbo].[Product] p ON i.ProductId = p.Id
ORDER BY o.OrderNumber;


-- Question 8: Using a case statement, list all the availability of products. When 0 then not available, else available -- 
SELECT 
    p.ProductName,
    SUM(oi.Quantity) AS TotalOrdered,
    CASE 
        WHEN SUM(oi.Quantity) = 0 THEN 'Not Available'
        ELSE 'Available'
    END AS Availability
FROM [dbo].[Product] p
LEFT JOIN [dbo].[OrderItem] oi ON p.Id = oi.ProductId
GROUP BY p.ProductName;

-- Question 9: Using case statement, list all the suppliers and the language they speak. The language they speak should be their country E.g if UK, then English --
SELECT 
    CompanyName,
    Country,
    CASE 
        WHEN Country = 'UK' THEN 'English'
        WHEN Country = 'Germany' THEN 'German'
        WHEN Country = 'France' THEN 'French'
        WHEN Country = 'Italy' THEN 'Italian'
        WHEN Country = 'Spain' THEN 'Spanish'
        ELSE 'Other'
    END AS LanguageSpoken
FROM [dbo].[Supplier];

-- Question 10:  List all products that are packaged in Jars --
SELECT 
    ProductName, 
    Package
FROM [dbo].[Product]
WHERE Package LIKE '%jar%';

-- Question 11: List product name, unit price, and package for products that start with "Ca" --
SELECT 
    ProductName, 
    UnitPrice, 
    Package
FROM [dbo].[Product]
WHERE ProductName LIKE 'Ca%';

-- Question 12: List the number of products for each supplier, sorted high to low
SELECT 
    s.CompanyName, 
    COUNT(p.Id) AS ProductCount
FROM [dbo].[Supplier] s
JOIN [dbo].[Product] p ON s.Id = p.SupplierID
GROUP BY s.CompanyName
ORDER BY ProductCount DESC;

-- Question 13: List the number of customers in each country
SELECT 
    Country, 
    COUNT(Id) AS CustomerCount
FROM [dbo].[Customer]
GROUP BY Country;

-- Question 14: List the number of customers in each country, sorted high to low
SELECT 
    Country, 
    COUNT(Id) AS CustomerCount
FROM [dbo].[Customer]
GROUP BY Country
ORDER BY CustomerCount DESC;

-- Question 15: List the total order amount for each customer, sorted high to low
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    SUM(o.TotalAmount) AS TotalSpent
FROM [dbo].[Customer] c
JOIN [dbo].[Order] o ON c.Id = o.CustomerId
GROUP BY c.FirstName, c.LastName
ORDER BY TotalSpent DESC;

-- Question 16: List all countries with more than 2 suppliers --
SELECT 
    Country, 
    COUNT(Id) AS SupplierCount
FROM [dbo].[Supplier]
GROUP BY Country
HAVING COUNT(Id) > 2;

-- Question 17: List the number of customers in each country (only include countries with more than 10 customers) --
SELECT 
    Country, 
    COUNT(Id) AS CustomerCount
FROM [dbo].[Customer]
GROUP BY Country
HAVING COUNT(Id) > 10;

-- Question 18: List the number of customers in each country (excluding USA), sorted high to low, showing only countries with 9 or more customers --
SELECT 
    Country, 
    COUNT(Id) AS CustomerCount
FROM [dbo].[Customer]
WHERE Country <> 'USA'
GROUP BY Country
HAVING COUNT(Id) >= 9
ORDER BY CustomerCount DESC;

-- Question 19: List customers with average orders between $1000 and $1200 --
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    AVG(o.TotalAmount) AS AvgOrderValue
FROM [dbo].[Customer] c
JOIN [dbo].[Order] o ON c.Id = o.CustomerId
GROUP BY c.FirstName, c.LastName
HAVING AVG(o.TotalAmount) BETWEEN 1000 AND 1200;

-- Question 20: Get the number of orders and total amount sold between Jan 1, 2013 and Jan 31, 2013 --
SELECT 
    COUNT(Id) AS OrderCount,
    SUM(TotalAmount) AS TotalSales
FROM [dbo].[Order]
WHERE OrderDate BETWEEN '2013-01-01' AND '2013-01-31';


-- SQL Capstone Project Report

-- 1. Introduction
-- This capstone project involved analyzing a relational database using Microsoft SQL Server (MSSQL).
-- The goal was to answer 20 business questions using SQL queries to uncover insights about products, customers, orders, and suppliers.

-- 2. Objectives
-- - Strengthen SQL query writing skills.
-- - Extract actionable insights from a real-world style dataset.
-- - Use SQL joins, filtering, aggregations, and conditional logic.
-- - Build a deeper understanding of relational database structures.

-- 3. Tools Used
-- - SQL Server Management Studio (SSMS)
-- - SQL queries including SELECT, JOIN, WHERE, GROUP BY, HAVING, ORDER BY, CASE, LIKE, and aggregate functions.

-- 4. Tables Used
-- - Customer (Id, FirstName, LastName, City, Country, Phone)
-- - Supplier (Id, CompanyName, ContactName, City, Country, Phone, Fax)
-- - Order (Id, OrderDate, CustomerId, TotalAmount)
-- - OrderItem (Id, OrderId, ProductId, UnitPrice, Quantity)
-- - Product (Id, ProductName, SupplierId, UnitPrice, Package, IsDiscontinued)

-- 5. Summary of Work Done
-- A total of 20 business questions were answered. These include:
-- - Listing suppliers from specific countries.
-- - Joining related tables to display combined information (e.g., products with suppliers, orders with customers).
-- - Filtering and sorting data (e.g., top spenders, customers by country).
-- - Using CASE statements for conditional outputs (e.g., language spoken by supplier country).
-- - Using LIKE and string functions to find specific product names or packages.
-- - Aggregating data with COUNT, SUM, and AVG to show order totals, product counts, and customer behavior.

-- 6. Key Concepts Applied
-- - Inner joins to combine related records across multiple tables.
-- - Aggregate functions (SUM, COUNT, AVG) with GROUP BY for summarizing data.
-- - CASE expressions to return custom outputs based on conditions.
-- - HAVING clause to filter grouped data.
-- - LIKE and pattern matching to filter text-based fields.
-- - Sorting and limiting data to focus on specific insights.

-- 7. Challenges Encountered
-- - Understanding which columns to join between tables (e.g., Order.CustomerId with Customer.Id).
-- - Structuring queries with multiple joins and keeping table aliases organized.
-- - Knowing when to use HAVING instead of WHERE for grouped data filtering.

-- 8. Lessons Learned
-- - The importance of mastering table relationships and foreign keys in relational databases.
-- - How to combine multiple SQL techniques to answer complex business questions.
-- - Using SQL to derive clear, business-relevant insights from raw transactional data.

-- 9. Conclusion
-- This project has helped solidify my understanding of SQL fundamentals through practical application.
-- It has given me hands-on experience writing clean and purposeful SQL queries to support data-driven decisions.
-- I am now more confident working with joins, aggregations, and logic in SQL.












