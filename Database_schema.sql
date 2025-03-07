
-- Create the Customers table
-- This table stores information about customers such as their name, segment, and location.
CREATE TABLE Customers (
    Customer_ID VARCHAR(50) PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Region VARCHAR(50),
    Postal_Code VARCHAR(20)
);

-- Create the Products table
-- This table stores information about products available for sale.
CREATE TABLE Products (
    Product_ID VARCHAR(50) PRIMARY KEY,
    Product_Name VARCHAR(200) NOT NULL,
    Category VARCHAR(50),
    Sub_Category VARCHAR(50)
);

-- Create the Orders table
-- This table records customer orders, including the order date and associated customer.
CREATE TABLE Orders (
    Order_ID VARCHAR(50) PRIMARY KEY,
    Order_Date DATE NOT NULL,
    Customer_ID VARCHAR(50),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE CASCADE
);

-- Create the OrderDetails table
-- This table captures details of each product in an order, including sales, quantity, discount, and profit.
CREATE TABLE OrderDetails (
    OrderDetail_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID VARCHAR(50),
    Product_ID VARCHAR(50),
    Sales DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Quantity INT NOT NULL DEFAULT 1,
    Discount DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    Profit DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID) ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE
);

-- Create the Shipping table
-- This table stores shipping information for each order, including the ship date and shipping method.
CREATE TABLE Shipping (
    Shipping_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID VARCHAR(50),
    Ship_Date DATE NOT NULL,
    Ship_Mode VARCHAR(50),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID) ON DELETE CASCADE
);
