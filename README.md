# Superstore SQL Project

## Overview
This project is a structured SQL analysis of the **United States Superstore Sales** dataset. The dataset contains detailed records of customer orders, including sales, profits, discounts, product categories, and shipping details. Using **SQL queries**, we explore key business insights such as customer segmentation, sales performance, the impact of discounts, shipping efficiency, and more.

The project is structured into different SQL files for **database schema creation, data insertion, and query execution**. The queries are designed to uncover meaningful insights and can be used for reporting and business intelligence purposes.

## Project Structure
**Superstore-SQL-Project**

`README.md`  *(Project documentation)*

`database_schema.sql`  *(SQL script to create database tables)*

`data_insertion.sql`  *(SQL script to insert sample data into tables)*

`queries.sql`  *(Collection of SQL queries for data analysis)*

`output_screenshots`  *(Folder containing query results screenshots)*

## Data Source
The dataset used in this project comes from **[Kaggle: United State Superstore Sales](https://www.kaggle.com/datasets/abiodunonadeji/united-state-superstore-sales)**. It contains sales records, customer details, product categories, and shipping information, making it an excellent dataset for SQL-based analysis.

## SQL Analysis and Key Insights
The project consists of **15 structured SQL queries**, each aimed at analyzing different aspects of the business. Below is an overview of the key insights:

1. Top Customers by Sales
We identify the top 5 customers contributing the most revenue. This helps in understanding high-value customers and strategizing loyalty programs accordingly.

2. Impact of Discounts on Profitability
This analysis categorizes discount levels and evaluates how they affect overall profit. The key takeaway is that excessive discounting can diminish profitability, necessitating an optimized discount strategy.

3. Most Popular Product Category
By analyzing the total number of orders per category, we determine which category receives the highest demand, assisting in inventory planning and marketing strategies.

4. Average Shipping Duration
We calculate the average time taken from order placement to shipment. This metric is crucial in assessing supply chain efficiency and customer satisfaction.

5. Monthly Sales Growth Analysis
Tracking monthly sales trends allows businesses to spot seasonal demand patterns, optimize stock levels, and strategize promotions.

6. Seasonal Sales & Profit Trends
By segmenting sales and profits into Winter, Spring, Summer, and Autumn, we identify seasonal demand variations. This insight aids in marketing campaigns and stock preparation.

7. Most Profitable Customers
We determine the top customers based on total profit contributions, ensuring businesses can focus on high-value clients for personalized services.

8. Low-Selling but Profitable Products
This analysis pinpoints products that have low sales volume but generate significant profit, highlighting potential opportunities for better promotions.

9. States with High Discounts and Losses
Identifying regions where high discounts lead to losses helps businesses revise their pricing and discount strategies to maintain profitability.

10. Best-Selling Categories and Subcategories
This breakdown helps in assessing which subcategories perform the best within each category, allowing for refined marketing efforts.

11. Sales Performance by Day of the Week
Analyzing daily sales trends identifies peak sales days, which can be leveraged for targeted promotions and inventory management.

12. Impact of Shipping Modes on Sales & Profits
Different shipping modes affect customer experience and business profitability. Understanding which mode is most efficient ensures better logistics planning.

13. Effect of Delivery Time on Sales & Profits
This analysis determines whether fast or slow deliveries have a correlation with revenue and profit, influencing logistics optimizations.

14. Top 10 Regions with the Most VIP Customers
By categorizing customers into VIP, Regular, and Occasional, we identify the regions with the most high-value clients for targeted business growth.

15. Customer Segmentation Analysis
We classify customers based on their purchasing behavior and analyze their sales volume, profit contribution, average order value, and discount reception. This insight is essential for tailored customer engagement strategies.

## How to Use
1. **Set up the database:**
   - Execute `database_schema.sql` to create the required tables.
   - Execute `data_insertion.sql` to populate the tables with data.

2. **Run the queries:**
   - Open `queries.sql` in your SQL editor (e.g., DBeaver, MySQL Workbench).
   - Execute individual queries to explore insights.

3. **Review outputs:**
   - Check the results for business trends and actionable insights.
   - Compare with the screenshots stored in `output_screenshots/`.

## Tools Used
- **Database Management System:** MySQL / PostgreSQL (compatible with most SQL databases)
- **SQL Editor:** DBeaver
- **Data Source:** Kaggle

## Conclusion
This project showcases **real-world SQL analysis** on a retail dataset, covering a wide range of business insights. It helps in understanding customer behavior, optimizing sales strategies, and improving business decision-making through SQL queries.

Feel free to explore the queries, modify them, or use them for further analysis.

## Author
**Fatemeh Rajaei Nesheli**

## License
This project is open-source and free to use under the MIT License.

---
For any questions or suggestions, feel free to reach out!


