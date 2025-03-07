
-- 1. Find the top 5 customers based on total sales.
-- This query identifies the highest-spending customers in terms of total sales.

SELECT C.Customer_ID, C.Customer_Name, SUM(OD.Sales) AS Total_Sales
FROM Customers C
JOIN Orders O ON C.Customer_ID = O.Customer_ID
JOIN OrderDetails OD ON O.Order_ID = OD.Order_ID
GROUP BY C.Customer_ID, C.Customer_Name
ORDER BY Total_Sales DESC
LIMIT 5;


-- 2. Examining the effect of discounts on profits.
-- This query categorizes discounts into different levels and analyzes their impact on average profit.

SELECT 
    CASE 
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount BETWEEN 0.01 AND 0.1 THEN 'Low Discount (0-10%)'
        WHEN Discount BETWEEN 0.1 AND 0.3 THEN 'Medium Discount (10-30%)'
        ELSE 'High Discount (>30%)'
    END AS Discount_Category,
    ROUND(AVG(Profit), 2) AS Avg_Profit
FROM OrderDetails
GROUP BY Discount_Category
ORDER BY Avg_Profit DESC;


-- 3. Identify the most popular product category.
-- This query finds the category with the highest number of orders.

SELECT P.Category, COUNT(OD.Product_ID) AS Total_Orders
FROM OrderDetails OD
JOIN Products P ON OD.Product_ID = P.Product_ID
GROUP BY P.Category
ORDER BY Total_Orders DESC
LIMIT 1;

-- 4. Calculate the average shipping duration.
-- This query determines the average number of days between order date and shipping date.

SELECT ROUND(AVG(DATEDIFF(S.Ship_Date, O.Order_Date)), 2) AS Avg_Shipping_Days
FROM Orders O
JOIN Shipping S ON O.Order_ID = S.Order_ID;

-- 5. Monthly sales growth review.
-- This query calculates total sales for each month to track sales trends over time.

SELECT 
    DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
    SUM(Sales) AS Total_Sales
FROM Orders O
JOIN OrderDetails OD ON O.Order_ID = OD.Order_ID
GROUP BY Order_Month
ORDER BY Order_Month;

-- 6. Review sales and profits based on the seasons of the year.
-- This query groups sales and profits by season to identify seasonal trends in revenue.

SELECT 
    CASE 
        WHEN MONTH(O.Order_Date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(O.Order_Date) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(O.Order_Date) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Autumn'
    END AS Season,
    ROUND(SUM(OD.Sales), 2) AS Total_Sales,
    ROUND(SUM(OD.Profit), 2) AS Total_Profit,
    COUNT(DISTINCT O.Order_ID) AS Order_Count
FROM Orders O
JOIN OrderDetails OD ON O.Order_ID = OD.Order_ID
GROUP BY Season
ORDER BY Total_Sales DESC;

-- 7. Identify the top 10 most profitable customers.
-- This query finds the customers who contribute the most profit to the company.

SELECT C.Customer_ID, C.Customer_Name, 
       ROUND(SUM(OD.Profit), 2) AS Total_Profit
FROM Customers C
JOIN Orders O ON C.Customer_ID = O.Customer_ID
JOIN OrderDetails OD ON O.Order_ID = OD.Order_ID
GROUP BY C.Customer_ID, C.Customer_Name
ORDER BY Total_Profit DESC
LIMIT 10;

-- 8. Identify low-selling but profitable products.
-- This query finds products that have been sold in low quantities but still generate high profit.

SELECT P.Product_ID, P.Product_Name, 
       SUM(OD.Quantity) AS Total_Quantity_Sold,
       ROUND(SUM(OD.Profit), 2) AS Total_Profit
FROM Products P
JOIN OrderDetails OD ON P.Product_ID = OD.Product_ID
GROUP BY P.Product_ID, P.Product_Name
HAVING SUM(OD.Quantity) < 50  -- Low-selling products
ORDER BY Total_Profit DESC
LIMIT 10;

-- 9. Identify states where high discounts have caused losses.
-- This query finds states where high discounts have resulted in negative profit.

SELECT C.State,
       ROUND(AVG(OD.Discount) * 100, 2) AS Avg_Discount_Percentage,
       ROUND(SUM(OD.Profit), 2) AS Total_Profit
FROM Customers C
JOIN Orders O ON C.Customer_ID = O.Customer_ID
JOIN OrderDetails OD ON O.Order_ID = OD.Order_ID
GROUP BY C.State
HAVING Total_Profit < 0  -- Only states that have lost money
ORDER BY Avg_Discount_Percentage desc;

-- 10. Review the best-selling categories and their subcategories.
-- This query ranks categories and subcategories by sales and profit, including subtotals using ROLLUP.

SELECT 
    COALESCE(P.Category, 'TOTAL') AS Category, 
    COALESCE(P.Sub_Category, 'SUBTOTAL') AS Sub_Category, 
    ROUND(SUM(OD.Sales), 2) AS Total_Sales,
    ROUND(SUM(OD.Profit), 2) AS Total_Profit
FROM Products P
JOIN OrderDetails OD ON P.Product_ID = OD.Product_ID
GROUP BY P.Category, P.Sub_Category WITH ROLLUP
ORDER BY Total_Sales DESC;

-- 11. Analyze sales performance on different days of the week.
-- This query calculates total sales for each day of the week to find peak sales days.

SELECT 
    DAYNAME(Order_Date) AS Day_of_Week,
    ROUND(SUM(OD.Sales), 2) AS Total_Sales
FROM Orders O
JOIN OrderDetails OD ON O.Order_ID = OD.Order_ID
GROUP BY Day_of_Week
ORDER BY Total_Sales DESC;

-- 12. Analyze the impact of shipping mode on sales and profits.
-- This query evaluates how different shipping methods affect total sales and profits.

SELECT 
    S.Ship_Mode,
    ROUND(SUM(OD.Sales), 2) AS Total_Sales,
    ROUND(SUM(OD.Profit), 2) AS Total_Profit
FROM Shipping S
JOIN Orders O ON S.Order_ID = O.Order_ID
JOIN OrderDetails OD ON O.Order_ID = OD.Order_ID
GROUP BY S.Ship_Mode
ORDER BY Total_Sales DESC;

-- 13. Analyze the impact of delivery time on sales and profits.
-- This query explores whether faster or slower deliveries correlate with sales and profitability.

SELECT 
    Avg_Shipping_Days,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM (
    SELECT 
        DATEDIFF(S.Ship_Date, O.Order_Date) AS Avg_Shipping_Days,
        OD.Sales,
        OD.Profit
    FROM Orders O
    JOIN Shipping S ON O.Order_ID = S.Order_ID
    JOIN OrderDetails OD ON O.Order_ID = OD.Order_ID
) AS ShippingData
GROUP BY Avg_Shipping_Days
ORDER BY Avg_Shipping_Days;

-- 14. Identify the top 10 regions with the highest number of VIP customers.
-- This query finds regions with the most VIP customers (those with total sales above £5000).

WITH CustomerTypes AS (
    SELECT 
        C.Customer_ID,
        C.State,
        CASE 
            WHEN SUM(OD.Sales) >= 5000 THEN 'VIP Customer'
            WHEN SUM(OD.Sales) BETWEEN 1000 AND 4999 THEN 'Regular Customer'
            ELSE 'Occasional Customer'
        END AS Customer_Type
    FROM Customers C
    JOIN Orders O ON C.Customer_ID = O.Customer_ID
    JOIN OrderDetails OD ON O.Order_ID = OD.Order_ID
    GROUP BY C.Customer_ID, C.State
)
SELECT 
    State,
    Customer_Type,
    COUNT(Customer_ID) AS Customer_Count
FROM CustomerTypes
GROUP BY State, Customer_Type
having customer_type= 'VIP Customer'
ORDER BY Customer_Count DESC
limit 10 ;

-- 15. Customer analysis based on customer categories.
-- This query categorizes customers into VIP, Regular, and Occasional groups and analyzes their sales, profits, and discounts.

WITH CustomerTypes AS (
    SELECT 
        C.Customer_ID,
        CASE 
            WHEN SUM(OD.Sales) >= 5000 THEN 'VIP Customer'
            WHEN SUM(OD.Sales) BETWEEN 1000 AND 4999 THEN 'Regular Customer'
            ELSE 'Occasional Customer'
        END AS Customer_Type,
        ROUND(SUM(OD.Sales), 2) AS Total_Sales,
        ROUND(SUM(OD.Profit), 2) AS Total_Profit,
        COUNT(DISTINCT O.Order_ID) AS Total_Orders,
        ROUND(AVG(OD.Discount) * 100, 2) AS Avg_Discount
    FROM Customers C
    JOIN Orders O ON C.Customer_ID = O.Customer_ID
    JOIN OrderDetails OD ON O.Order_ID = OD.Order_ID
    GROUP BY C.Customer_ID
)
SELECT 
    Customer_Type,
    COUNT(Customer_ID) AS Customer_Count,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales,
    ROUND(SUM(Total_Profit), 2) AS Total_Profit,
    ROUND(AVG(Total_Orders), 2) AS Avg_Orders_Per_Customer,
    ROUND(AVG(Avg_Discount), 2) AS Overall_Avg_Discount,
    ROUND(SUM(Total_Sales) / SUM(Total_Orders), 2) AS Avg_Order_Value
FROM CustomerTypes
GROUP BY Customer_Type
ORDER BY Total_Sales DESC;













