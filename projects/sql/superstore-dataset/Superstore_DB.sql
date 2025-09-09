-- Creating new database named Superstore_DB
CREATE DATABASE Superstore_DB;
GO

USE Superstore_DB;
GO

-- Checking if the imported files are accurate
SELECT *
FROM [dbo].[Customer_Name]

SELECT *
FROM [dbo].[Orders]

SELECT *
FROM [dbo].[Returns]

SELECT *
FROM [dbo].[Users]

-- =========================================
-- 🔍 DATA VALIDATION & VERIFICATION SCRIPT
-- For Superstore_DB
-- =========================================

-- 📄 1. Check total number of records and preview rows in Orders
SELECT COUNT(*) AS Total_Orders FROM [dbo].[Orders];
SELECT TOP 5 * FROM [dbo].[Orders];

-- 🧪 Check for NULL values in Product_Base_Margin column
SELECT COUNT(*) AS Null_Product_Base_Margin
FROM [dbo].[Orders]
WHERE [Product Base Margin] IS NULL;

-- 📊 Check for duplicate Order_IDs in Orders
SELECT [Order_ID], COUNT(*) AS Frequency
FROM [dbo].[Orders]
GROUP BY [Order_ID]
HAVING COUNT(*) > 1;

-- 📄 2. Check total number of records and preview rows in Customer_Name
SELECT COUNT(*) AS Total_Customers FROM [dbo].[Customer_Name];
SELECT TOP 5 * FROM [dbo].[Customer_Name];

-- 📊 Check for duplicate combinations of Customer_Name and Order_ID (composite key)
SELECT [Customer_Name], [Order_ID], COUNT(*) AS Frequency
FROM [dbo].[Customer_Name]
GROUP BY [Customer_Name], [Order_ID]
HAVING COUNT(*) > 1;

-- 📄 3. Check total number of records and preview rows in Returns
SELECT COUNT(*) AS Total_Returns FROM [dbo].[Returns];
SELECT TOP 5 * FROM [dbo].[Returns];

-- 📊 Check for duplicate Order_IDs in Returns
SELECT [Order_ID], COUNT(*) AS Frequency
FROM [dbo].[Returns]
GROUP BY [Order_ID]
HAVING COUNT(*) > 1;

-- 📄 4. Check total number of records and preview rows in Users
SELECT COUNT(*) AS Total_Users FROM [dbo].[Users];
SELECT TOP 5 * FROM [dbo].[Users];

-- 📊 Check for duplicate Region + Manager combinations
SELECT [Region], [Manager], COUNT(*) AS Frequency
FROM [dbo].[Users]
GROUP BY [Region], [Manager]
HAVING COUNT(*) > 1;

-- ✅ OPTIONAL: Check distinct Region and Manager counts
SELECT COUNT(DISTINCT [Region]) AS Unique_Regions,
       COUNT(DISTINCT [Manager]) AS Unique_Managers
FROM [dbo].[Users];

-- =========================================
-- END OF SCRIPT
-- =========================================

--Updating data types across columns
-- Customer_Name
UPDATE [dbo].[Customer_Name]
SET [Customer_Name] = 0
WHERE [Customer_Name] IS NULL;

ALTER TABLE [dbo].[Customer_Name]
ALTER COLUMN [Customer_Name] NVARCHAR(255) NOT NULL;

UPDATE [dbo].[Customer_Name]
SET [Order_ID] = 0
WHERE [Order_ID] IS NULL;

ALTER TABLE [dbo].[Customer_Name]
ALTER COLUMN [Order_ID] FLOAT NOT NULL;

-- Returns 
UPDATE [dbo].[Returns]
SET [Order_ID] = 0
WHERE [Order_ID] IS NULL;

ALTER TABLE [dbo].[Returns]
ALTER COLUMN [Order_ID] FLOAT NOT NULL;

UPDATE [dbo].[Returns]
SET [Status] = 0
WHERE [Status] IS NULL;

ALTER TABLE [dbo].[Returns]
ALTER COLUMN [Status] NVARCHAR(255) NOT NULL;

--Users
UPDATE [dbo].[Users]
SET [Region] = 0
WHERE [Region] IS NULL;

ALTER TABLE [dbo].[Users]
ALTER COLUMN [Region] NVARCHAR(255) NOT NULL;

UPDATE [dbo].[Users]
SET [Manager] = 0
WHERE [Manager] IS NULL;

ALTER TABLE [dbo].[Users]
ALTER COLUMN [Manager] NVARCHAR(255) NOT NULL;

UPDATE [dbo].[Orders]
SET [Order_ID] = 0
WHERE [Order_ID] IS NULL;

ALTER TABLE [dbo].[Orders]
ALTER COLUMN [Order_ID] FLOAT NOT NULL;

UPDATE [dbo].[Orders]
SET [Region] = 0
WHERE [Region] IS NULL;

ALTER TABLE [dbo].[Orders]
ALTER COLUMN [Region] NVARCHAR(255) NOT NULL;


-- =========================================
-- 🔐 SET PRIMARY KEYS
-- =========================================

-- 1. Orders Table: Add a surrogate key since Order_ID is not unique
ALTER TABLE [dbo].[Orders]
ADD Order_PK_ID INT IDENTITY(1,1);

-- Set it as Primary Key
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT PK_Orders PRIMARY KEY (Order_PK_ID);

-- 2. Customer_Name Table: Composite primary key (Customer_Name + Order_ID)
ALTER TABLE [dbo].[Customer_Name]
ADD CONSTRAINT PK_Customer_Name PRIMARY KEY ([Customer_Name], [Order ID]);

-- 3. Returns Table: Order_ID as Primary Key (since it's unique)
ALTER TABLE [dbo].[Returns]
ADD CONSTRAINT PK_Returns PRIMARY KEY ([Order ID]);

-- 4. Users Table: Composite Primary Key (Region + Manager)
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT PK_Users PRIMARY KEY ([Region], [Manager]);

-- Title: Count of Records in All Tables
SELECT 'Orders' AS Table_Name, COUNT(*) AS Total_Records FROM Orders
UNION ALL
SELECT 'Customer_Name', COUNT(*) FROM Customer_Name
UNION ALL
SELECT 'Returns', COUNT(*) FROM Returns
UNION ALL
SELECT 'Users', COUNT(*) FROM Users;

-- Title: NULL Checks for Critical Columns
SELECT COUNT(*) AS Null_OrderID FROM Orders WHERE Order_ID IS NULL;
SELECT COUNT(*) AS Null_CustomerName FROM Customer_Name WHERE Customer_Name IS NULL;
SELECT COUNT(*) AS Null_Status FROM Returns WHERE Status IS NULL;
SELECT COUNT(*) AS Null_Manager FROM Users WHERE Manager IS NULL;

-- Title: Orders with Matching Customer Name Entries
SELECT cn.Order_ID, cn.Customer_Name
FROM Customer_Name cn
LEFT JOIN Orders o ON cn.Order_ID = o.Order_ID
WHERE o.Order_ID IS NULL;
-- These are customer entries with no matching orders (should be 0 ideally)

-- Title: Returns with Matching Orders
SELECT r.Order_ID
FROM Returns r
LEFT JOIN Orders o ON r.Order_ID = o.Order_ID
WHERE o.Order_ID IS NULL;
-- These are returns that don't link to any orders

-- Title: Duplicate Order_IDs in Orders Table
SELECT Order_ID, COUNT(*) AS Count
FROM Orders
GROUP BY Order_ID
HAVING COUNT(*) > 1
ORDER BY Count DESC;

-- A brief Analysis of Work done so far
Table Name	Description
Orders (8399 rows)	This is the main table with all transactional data — including customer details, products, and sales information. Each Order_ID appears multiple times because a single order can include multiple items. That’s expected in transactional systems.
Customer_Name (3022 rows)	Contains Customer_Name and Order_ID pairs. This may have fewer rows than Orders because it likely only lists unique customers tied to individual orders.
Returns (1079 rows)	Captures only orders that were returned. It’s normal for this to be a small subset of all orders.
Users (13 rows)	Represents managers by region. Each region may have more than one manager, which explains any repetition. This is expected and acceptable.

-- 🔗 Verifying relationship: Orders → Customer_Name
SELECT TOP 10 o.Order_ID, o.Customer_Name, c.Customer_Name
FROM Orders o
JOIN Customer_Name c
    ON o.Order_ID = c.Order_ID
WHERE o.Customer_Name != c.Customer_Name;

-- 🔗 Verifying relationship: Returns → Orders
SELECT TOP 10 r.Order_ID, r.Status, o.Order_ID AS Matched_Order
FROM Returns r
LEFT JOIN Orders o
    ON r.Order_ID = o.Order_ID
WHERE o.Order_ID IS NULL;

-- 🔗 Verifying relationship: Orders.Region → Users.Region
SELECT DISTINCT o.Region
FROM Orders o
LEFT JOIN Users u
    ON o.Region = u.Region
WHERE u.Region IS NULL;

-- =========================================
-- 🔐 A SHORT REPORT / SUMMARY
-- Deliverable 3: Short Report
-- Title: Migration of Superstore Excel Dataset to MSSQL Server — Summary Report
-- =========================================


Overview:
This project involved restoring a dataset from Excel to SQL Server while preserving structure and data integrity. The Excel file contained 4 sheets with interrelated data on orders, customers, returns, and regional managers.

Steps Taken:

Reviewed and understood the data structure across the four sheets.

Created the Superstore_DB database in MSSQL Server.

Imported all tables using the SQL Server Import Wizard without altering datatypes to preserve accuracy.

Set up primary keys and altered column nullability where necessary.

Attempted to enforce foreign key constraints but encountered:

Duplicate Order_ID entries

Null values and datatype mismatches

References to non-unique or nullable columns

Ultimately verified relationships using JOIN queries instead of FK constraints

Challenges & Resolutions:

Null Values in Product_Base_Margin: Left as-is, since removing them could cause data loss.

Duplicate Order_ID Entries: Created a surrogate primary key (Order_PK_ID) for Orders table.

FK Constraint Errors: Resolved by skipping enforcement and validating relationships with select queries.

Naming Conflicts & Typos: Corrected manually during FK checks.

Conclusion:
The database has been successfully restored and structured with logical relationships in place, even though not all were implemented as constraints due to real-world data complexity.

-- =========================================
-- END OF REPORT
-- =========================================

-- =========================================
-- FOUR SQL SYNTAX EXAMPLES
-- =========================================
-- 1. SELECT Query to view data
SELECT * FROM Orders;

-- 2. CREATE TABLE with Primary Key
CREATE TABLE Returns (
    Order_ID VARCHAR(50) NOT NULL PRIMARY KEY,
    Status VARCHAR(50)
);

-- 3. ALTER TABLE to set NOT NULL
ALTER TABLE Customer_Name
ALTER COLUMN Order_ID VARCHAR(50) NOT NULL;

-- 4. INNER JOIN to verify relationships
SELECT c.Customer_Name, o.Order_ID, o.Sales
FROM Customer_Name c
JOIN Orders o ON c.Order_ID = o.Order_ID;

-- =========================================
-- END OF SQL SYNTAX EXAMPLES
-- =========================================
