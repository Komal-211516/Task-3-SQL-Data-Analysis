-- CREATE TABLES

CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY,
    CustomerName TEXT,
    City TEXT
);

CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY,
    ProductName TEXT,
    Category TEXT,
    Price REAL
);

CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    CustomerID INTEGER,
    ProductID INTEGER,
    Quantity INTEGER,
    OrderDate TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- INSERT CUSTOMER DATA

INSERT INTO Customers VALUES
(1, 'Rahul', 'Hyderabad'),
(2, 'Priya', 'Bangalore'),
(3, 'Aman', 'Mumbai'),
(4, 'Sneha', 'Chennai'),
(5, 'Kiran', 'Delhi'),
(6, 'Neha', 'Pune');


-- INSERT PRODUCT DATA

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Mouse', 'Electronics', 800),
(103, 'Keyboard', 'Electronics', 1500),
(104, 'Chair', 'Furniture', 5000),
(105, 'Desk', 'Furniture', 9000),
(106, 'Notebook', 'Stationery', 100),
(107, 'Pen', 'Stationery', 50);


-- INSERT ORDER DATA

INSERT INTO Orders VALUES
(1001, 1, 101, 1, '2026-01-10'),
(1002, 1, 102, 2, '2026-01-12'),
(1003, 2, 104, 1, '2026-01-15'),
(1004, 2, 106, 5, '2026-01-20'),
(1005, 3, 105, 1, '2026-02-05'),
(1006, 3, 103, 2, '2026-02-08'),
(1007, 4, 101, 1, '2026-02-15'),
(1008, 4, 107, 10, '2026-02-18'),
(1009, 5, 102, 3, '2026-03-01'),
(1010, 5, 104, 2, '2026-03-05'),
(1011, 1, 105, 1, '2026-03-10'),
(1012, 2, 103, 1, '2026-03-15');


-- SELECT

SELECT *
FROM Customers;


-- WHERE

SELECT *
FROM Customers
WHERE City = 'Hyderabad';


-- ORDER BY

SELECT ProductName, Category, Price
FROM Products
ORDER BY Price DESC;


-- SUM

SELECT SUM(Quantity) AS Total_Quantity
FROM Orders;


-- AVG

SELECT AVG(Quantity) AS Average_Quantity
FROM Orders;


-- GROUP BY

SELECT
    CustomerID,
    SUM(Quantity) AS Total_Quantity
FROM Orders
GROUP BY CustomerID;


-- INNER JOIN

SELECT
    Customers.CustomerName,
    Products.ProductName,
    Orders.Quantity
FROM Orders
INNER JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
INNER JOIN Products
    ON Orders.ProductID = Products.ProductID;


-- LEFT JOIN

SELECT
    Customers.CustomerName,
    Orders.OrderID
FROM Customers
LEFT JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID;


-- RIGHT JOIN

SELECT
    Customers.CustomerName,
    Orders.OrderID
FROM Customers
RIGHT JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID;


-- SUBQUERY

SELECT
    ProductName,
    Price
FROM Products
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
);


-- CREATE VIEW

CREATE VIEW Customer_Order_Summary AS
SELECT
    Customers.CustomerName,
    Customers.City,
    SUM(Orders.Quantity) AS Total_Quantity
FROM Customers
INNER JOIN Orders
    ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID;


-- USE VIEW

SELECT *
FROM Customer_Order_Summary;


-- CREATE INDEX

CREATE INDEX idx_orders_customer
ON Orders(CustomerID);


-- CHECK INDEX

PRAGMA index_list('Orders');


-- PRODUCT SALES ANALYSIS

SELECT
    Products.ProductName,
    Products.Category,
    Products.Price,
    SUM(Orders.Quantity) AS Total_Quantity,
    SUM(Orders.Quantity * Products.Price) AS Total_Sales
FROM Orders
INNER JOIN Products
    ON Orders.ProductID = Products.ProductID
GROUP BY Products.ProductID
ORDER BY Total_Sales DESC;


-- CUSTOMER SALES ANALYSIS

SELECT
    Customers.CustomerName,
    SUM(Orders.Quantity * Products.Price) AS Total_Sales
FROM Orders
INNER JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
INNER JOIN Products
    ON Orders.ProductID = Products.ProductID
GROUP BY Customers.CustomerID
ORDER BY Total_Sales DESC;