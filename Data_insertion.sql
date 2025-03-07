
-- Insert data into Customers table
-- This query inserts distinct customer data from the source table into the Customers table.
INSERT INTO Customers (Customer_ID, Customer_Name, Segment, Country, City, State, Region, Postal_Code)
SELECT DISTINCT Customer_ID, Customer_Name, Segment, Country, City, State, Region, Postal_Code
FROM superstore;

-- Insert data into Products table
-- This query inserts distinct product data from the source table into the Products table.
INSERT INTO Products (Product_ID, Product_Name, Category, Sub_Category)
SELECT DISTINCT Product_ID, Product_Name, Category, Sub_Category
FROM superstore;

-- Insert data into Orders table
-- This query inserts order data, converting the order date to the correct format and mapping to the Orders table.
INSERT INTO Orders (Order_ID, Order_Date, Customer_ID)
SELECT DISTINCT Order_ID, 
       STR_TO_DATE(Order_Date, '%m/%d/%Y'),  -- Convert to date format
       Customer_ID
FROM superstore;

-- Insert data into OrderDetails table
-- This query inserts order detail data, creating a sequential OrderDetail_ID and mapping to the OrderDetails table.
INSERT INTO OrderDetails (OrderDetail_ID, Order_ID, Product_ID, Sales, Quantity, Discount, Profit)
SELECT ROW_NUMBER() OVER (ORDER BY Order_ID) AS OrderDetail_ID, -- Creating a unique identifier sequentially
       Order_ID, 
       Product_ID, 
       Sales, 
       Quantity, 
       Discount, 
       Profit
FROM superstore;

-- Insert data into Shipping table
-- This query inserts shipping data, creating a sequential Shipping_ID and converting the ship date to the correct format.
INSERT INTO Shipping (Shipping_ID, Order_ID, Ship_Date, Ship_Mode)
SELECT ROW_NUMBER() OVER (ORDER BY Order_ID) AS Shipping_ID, -- Creating a unique identifier sequentially
       Order_ID, 
       STR_TO_DATE(Ship_Date, '%m/%d/%Y'), -- Convert to date format
       Ship_Mode
FROM superstore;
