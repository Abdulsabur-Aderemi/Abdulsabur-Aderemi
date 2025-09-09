# Testing Database
##  1. Introduction

-- This capstone project involved analyzing a relational database using Microsoft SQL Server (MSSQL).

-- The goal was to answer 20 business questions using SQL queries to uncover insights about products, customers, orders, and suppliers.

## 2. Objectives

-- - Strengthen SQL query writing skills.

-- - Extract actionable insights from a real-world style dataset.

-- - Use SQL joins, filtering, aggregations, and conditional logic.

-- - Build a deeper understanding of relational database structures.

## 3. Tools Used

-- - SQL Server Management Studio (SSMS)

-- - SQL queries including SELECT, JOIN, WHERE, GROUP BY, HAVING, ORDER BY, CASE, LIKE, and aggregate functions.

## 4. Tables Used

-- - Customer (Id, FirstName, LastName, City, Country, Phone)

-- - Supplier (Id, CompanyName, ContactName, City, Country, Phone, Fax)

-- - Order (Id, OrderDate, CustomerId, TotalAmount)

-- - OrderItem (Id, OrderId, ProductId, UnitPrice, Quantity)

-- - Product (Id, ProductName, SupplierId, UnitPrice, Package, IsDiscontinued)

## 5. Summary of Work Done

-- A total of 20 business questions were answered. These include:

-- - Listing suppliers from specific countries.

-- - Joining related tables to display combined information (e.g., products with suppliers, orders with customers).

-- - Filtering and sorting data (e.g., top spenders, customers by country).

-- - Using CASE statements for conditional outputs (e.g., language spoken by supplier country).

-- - Using LIKE and string functions to find specific product names or packages.

-- - Aggregating data with COUNT, SUM, and AVG to show order totals, product counts, and customer behavior.

## 6. Key Concepts Applied

-- - Inner joins to combine related records across multiple tables.

-- - Aggregate functions (SUM, COUNT, AVG) with GROUP BY for summarizing data.

-- - CASE expressions to return custom outputs based on conditions.

-- - HAVING clause to filter grouped data.

-- - LIKE and pattern matching to filter text-based fields.

-- - Sorting and limiting data to focus on specific insights.

## 7. Challenges Encountered

-- - Understanding which columns to join between tables (e.g., Order.CustomerId with Customer.Id).

-- - Structuring queries with multiple joins and keeping table aliases organized.

## - Knowing when to use HAVING instead of WHERE for grouped data filtering.

## 8. Lessons Learned

-- - The importance of mastering table relationships and foreign keys in relational databases.

-- - How to combine multiple SQL techniques to answer complex business questions.

-- - Using SQL to derive clear, business-relevant insights from raw transactional data.

## 9. Conclusion

-- This project has helped solidify my understanding of SQL fundamentals through practical application.

-- It has given me hands-on experience writing clean and purposeful SQL queries to support data-driven decisions.

-- I am now more confident working with joins, aggregations, and logic in SQL.

## 10. Screenshots of Queries
<img width="1433" height="736" alt="SQL CAPSTONE SCREENSHOT 1" src="https://github.com/user-attachments/assets/9abcb036-9ece-488c-8790-0ce05c019add" />

<img width="1538" height="834" alt="SQL CAPSTONE SCREENSHOOT 2" src="https://github.com/user-attachments/assets/cb4491e2-c472-4b06-a38c-5e0dd2ab80ad" />
