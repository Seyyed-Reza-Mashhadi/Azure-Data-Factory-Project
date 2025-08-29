-- ===============================================
-- Dropping tables to ensure a clean slate
-- ===============================================
DROP TABLE IF EXISTS dbo.FactSales;
DROP TABLE IF EXISTS dbo.DimCustomers;
DROP TABLE IF EXISTS dbo.DimEmployees;
DROP TABLE IF EXISTS dbo.DimProducts;

-- ===============================================
-- Dimension Tables
-- ===============================================

-- Customer Dimension
CREATE TABLE dbo.DimCustomers (
    CustomerID INT PRIMARY KEY,
    FirstName NVARCHAR(100),
    MiddleInitial NVARCHAR(10),
    LastName NVARCHAR(100),
    FullName NVARCHAR(250),
    Address NVARCHAR(250),
    CityID INT,
    CityName NVARCHAR(100),
    Zipcode NVARCHAR(20),
    CountryID INT,
    CountryName NVARCHAR(100),
    CountryCode NVARCHAR(10)
);

-- Employee Dimension
CREATE TABLE dbo.DimEmployees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(100),
    MiddleInitial NVARCHAR(10),
    LastName NVARCHAR(100),
    FullName NVARCHAR(250),
    BirthDate DATETIME2,
    Gender NVARCHAR(10),
    HireDate DATETIME2,
    AgeYears FLOAT,
    ExperienceYears FLOAT,
    CityID INT,
    CityName NVARCHAR(100),
    Zipcode NVARCHAR(20),
    CountryID INT,
    CountryName NVARCHAR(100),
    CountryCode NVARCHAR(10)
);

-- Product Dimension
CREATE TABLE dbo.DimProducts (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(200),
    Price DECIMAL(18,2),
    Class NVARCHAR(50),
    ModifyDate DATETIME2,
    Resistant NVARCHAR(10),
    IsAllergic NVARCHAR(10),
    VitalityDays INT,
    CategoryID INT,
    CategoryName NVARCHAR(100)
);

-- ===============================================
-- Fact Table
-- ===============================================
CREATE TABLE dbo.FactSales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT, 
    CustomerID INT,  
    ProductID INT,  
    Quantity INT,
    Discount DECIMAL(5,2),
    TotalPrice DECIMAL(18,2),
    SalesDate DATETIME2,
    TransactionNumber NVARCHAR(70),

    -- Foreign Keys
    CONSTRAINT FK_Sales_Employee FOREIGN KEY (EmployeeID) REFERENCES dbo.DimEmployees(EmployeeID),
    CONSTRAINT FK_Sales_Customer FOREIGN KEY (CustomerID) REFERENCES dbo.DimCustomers(CustomerID),
    CONSTRAINT FK_Sales_Product FOREIGN KEY (ProductID) REFERENCES dbo.DimProducts(ProductID)
);
