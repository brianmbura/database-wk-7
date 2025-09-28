-- Question 1: Achieving 1NF (First Normal Form) 🛠️
-- Original table: ProductDetail(OrderID, CustomerName, Products)
-- Problem: Products column contains multiple values (comma-separated).
-- Solution: Transform into 1NF so that each row has a single product.

-- Step 1: Create a new normalized table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Step 2: Insert data in 1NF form (splitting multi-valued Products)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Now each row has a single product (1NF achieved).

-- ============================================================
-- Question 2: Achieving 2NF (Second Normal Form) 🧩
-- Original table: OrderDetails(OrderID, CustomerName, Product, Quantity)
-- Problem: CustomerName depends only on OrderID (partial dependency).
--          Violates 2NF since (OrderID, Product) is the composite key.
-- Solution: Split into two tables to remove partial dependency.

-- Step 1: Create Orders table (to hold OrderID → CustomerName relationship)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create OrderProducts table (to hold OrderID + Product + Quantity)
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert normalized data
INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

INSERT INTO OrderProducts (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Now:
-- - Orders table stores OrderID → CustomerName
-- - OrderProducts table stores OrderID + Product + Quantity
-- This removes partial dependency, achieving 2NF.
