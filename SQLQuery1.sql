CREATE DATABASE TechShop;
USE TechShop;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255)
);
GO
INSERT INTO Customers (CustomerName, Email, Phone, Address) VALUES
('Anita', 'anita@example.com', '555-1234', '123 Main St'),
('Ana',  'ana@example.com', '555-5678', '456 Oak St'),
('Charu',  'charu@example.com', '555-8765', '789 Pine St'),
('Durga',  'durga@example.com', '555-4321', '321 Elm St'),
('Isha',  'isha@example.com', '555-5555', '654 Cedar St'),
('Joe',  'joe@example.com', '555-9876', '987 Spruce St'),
('Neethu',  'neethu@example.com', '555-1111', '159 Maple St'),
('Ravi',  'ravi@example.com', '555-2222', '753 Birch St'),
('Sri',  'sri@example.com', '555-3333', '852 Ash St'),
('Hari', 'hari@example.com', '555-4444', '951 Poplar St');
GO
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
);
GO
INSERT INTO Products (ProductName, Category, Price) VALUES
('Laptop', 'Electronics', 1200.00),
('Smartphone', 'Electronics', 800.00),
('Tablet', 'Electronics', 500.00),
('Headphones', 'Accessories', 150.00),
('Keyboard', 'Accessories', 70.00),
('Mouse', 'Accessories', 50.00),
('Monitor', 'Electronics', 300.00),
('Printer', 'Electronics', 200.00),
('Router', 'Electronics', 120.00),
('Webcam', 'Accessories', 90.00);
GO
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);
GO
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-09-01', 1300.00),
(2, '2024-09-02', 800.00),
(3, '2024-09-03', 600.00),
(4, '2024-09-04', 150.00),
(5, '2024-09-05', 450.00),
(6, '2024-09-06', 1200.00),
(7, '2024-09-07', 800.00),
(8, '2024-09-08', 350.00),
(9, '2024-09-09', 400.00),
(10, '2024-09-10', 900.00);
GO
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);
GO
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 1200.00),
(1, 5, 1, 70.00),
(2, 2, 1, 800.00),
(3, 3, 1, 500.00),
(3, 6, 1, 50.00),
(4, 4, 1, 150.00),
(5, 7, 1, 300.00),
(5, 10, 1, 90.00),
(6, 1, 1, 1200.00),
(7, 2, 1, 800.00);
GO
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    Stock INT,
    LastUpdated DATE,
    CONSTRAINT FK_Inventory_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);
GO
INSERT INTO Inventory (ProductID, Stock, LastUpdated) VALUES
(1, 100, '2024-09-01'),
(2, 150, '2024-09-01'),
(3, 200, '2024-09-01'),
(4, 250, '2024-09-01'),
(5, 180, '2024-09-01'),
(6, 300, '2024-09-01'),
(7, 220, '2024-09-01'),
(8, 130, '2024-09-01'),
(9, 175, '2024-09-01'),
(10, 190, '2024-09-01');
GO
--task 2 
--retriving names and email of all customers
SELECT CustomerName, Email
FROM Customers;

--Listing all orders with their order dates and corresponding customer names
SELECT Orders.OrderID, Orders.OrderDate, Customers.CustomerName
FROM Orders 
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

--Inserting a new customer record into the "Customers" table
INSERT INTO Customers (CustomerName, Email, Phone, Address)
VALUES ('Ananth', 'ananth@example.com', '555-9999', '101 River St');

--Updating the prices of all electronic gadgets in the "Products" table by increasing them by 10%
UPDATE Products
SET Price = Price * 1.10
WHERE Category = 'Electronics';

-- Deleting a specific order and its associated order details 
DELETE FROM OrderDetails
WHERE OrderID = 5;
DELETE FROM Orders
WHERE OrderID = 5;

--Inserting a new order into the "Orders" table
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (1, '2024-09-20', 250.00);

--Updating the contact information of a specific customer
UPDATE Customers
SET Email = 'new.email@example.com', Address = '123 Updated St'
WHERE CustomerID = 3;

-- Recalculating and updating the total cost of each order in the "Orders" table
UPDATE Orders
SET TotalAmount = (
    SELECT SUM(OrderDetails.Quantity * OrderDetails.UnitPrice)
    FROM OrderDetails
    WHERE OrderDetails.OrderID = Orders.OrderID
);

--Deleting all orders and associated order details for a specific customer
DELETE FROM OrderDetails
WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = 2);

DELETE FROM Orders
WHERE CustomerID = 2;

--Inserting a new electronic gadget product into the "Products" table
INSERT INTO Products (ProductName, Category, Price)
VALUES ('Smartwatch', 'Electronics', 250.00);

--Updating the status of a specific order
ALTER TABLE Orders
ADD Status VARCHAR(50); 

UPDATE Orders
SET Status = 'Shipped'
WHERE OrderID = 1;

--Calculating and updating the number of orders placed by each customer in the "Customers" table
ALTER TABLE Customers
ADD NumberofOrders INT;

UPDATE Customers
SET NumberOfOrders = (
    SELECT COUNT(*)
    FROM Orders
    WHERE Orders.CustomerID = Customers.CustomerID
);



