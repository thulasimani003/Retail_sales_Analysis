# Retail Sales Analysis - SQL Project

## Project Overview
This project focuses on analyzing retail sales data using SQL. It involves database setup, data exploration, cleaning, and performing various analytical queries to gain insights into sales trends, customer behavior, and business performance.

## Database Setup
1. **Create Database**
   ```sql
   CREATE DATABASE Retail_sales_Analysis;
   USE Retail_sales_Analysis;
   ```

2. **Create Table**
   ```sql
   CREATE TABLE retail_sales(
       transactions_id INT PRIMARY KEY,
       sale_date DATE,
       sale_time TIME,
       customer_id INT,
       gender VARCHAR(20),
       age INT,
       category VARCHAR(40),
       quantity INT,
       price_per_unit FLOAT,
       cogs FLOAT,
       total_sale FLOAT
   );
   ```

## Data Exploration & Cleaning
- **Total sales count:**
  ```sql
  SELECT COUNT(*) AS Total_sales FROM retail_sales;
  ```
- **Unique customers count:**
  ```sql
  SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;
  ```
- **Check for NULL values:**
  ```sql
  SELECT * FROM retail_sales WHERE
      transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR
      customer_id IS NULL OR gender IS NULL OR age IS NULL OR
      category IS NULL OR quantity IS NULL OR price_per_unit IS NULL OR
      cogs IS NULL OR total_sale IS NULL;
  ```
- **Delete NULL values (if any found):**
  ```sql
  DELETE FROM retail_sales WHERE
      transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR
      customer_id IS NULL OR gender IS NULL OR age IS NULL OR
      category IS NULL OR quantity IS NULL OR price_per_unit IS NULL OR
      cogs IS NULL OR total_sale IS NULL;
  ```

## Data Analysis & Insights
1. **Retrieve all sales on a specific date**
   ```sql
   SELECT * FROM retail_sales WHERE sale_date='2022-11-05';
   ```
2. **Find transactions where the category is 'Clothing' and quantity > 4 in Nov 2022**
   ```sql
   SELECT * FROM retail_sales
   WHERE category='Clothing' AND DATE_FORMAT(sale_date, '%Y-%m')='2022-11' AND quantity>=4;
   ```
3. **Total sales per category**
   ```sql
   SELECT category, SUM(total_sale) AS Total_Sales, COUNT(*) AS Total_Orders FROM retail_sales GROUP BY category;
   ```
4. **Average age of customers in 'Beauty' category**
   ```sql
   SELECT ROUND(AVG(age),2) AS Average_age FROM retail_sales WHERE category='Beauty';
   ```
5. **Transactions where total sale > 1000**
   ```sql
   SELECT * FROM retail_sales WHERE total_sale > 1000;
   ```
6. **Total transactions by gender in each category**
   ```sql
   SELECT gender, category, COUNT(transactions_id) AS Total_Transactions FROM retail_sales GROUP BY gender, category ORDER BY category;
   ```
7. **Average sale per month & best-selling month per year**
   ```sql
   SELECT year, month, avg_sale, monthly_rank FROM (
       SELECT
           DATE_FORMAT(sale_date, '%Y') AS year,
           DATE_FORMAT(sale_date, '%m') AS month,
           AVG(total_sale) AS avg_sale,
           RANK() OVER (
               PARTITION BY DATE_FORMAT(sale_date, '%Y')
               ORDER BY total_sale DESC
           ) AS monthly_rank
       FROM retail_sales
       GROUP BY DATE_FORMAT(sale_date, '%Y'), DATE_FORMAT(sale_date, '%m')
   ) AS ranked_sales;
   ```
8. **Top 5 customers based on total sales**
   ```sql
   SELECT customer_id, SUM(total_sale) AS Total_sales FROM retail_sales
   GROUP BY customer_id ORDER BY Total_sales DESC LIMIT 5;
   ```
9. **Number of unique customers per category**
   ```sql
   SELECT category, COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales GROUP BY category;
   ```
10. **Order count by shift (Morning, Afternoon, Evening)**
    ```sql
    WITH hourly_sales AS (
        SELECT *,
            CASE
                WHEN HOUR(sale_time) < 12 THEN 'Morning'
                WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
                ELSE 'Evening'
            END AS shift
        FROM retail_sales
    )
    SELECT shift, COUNT(*) AS total_orders FROM hourly_sales GROUP BY shift;
    ```

## Technologies Used
- **Database:** MySQL
- **Query Language:** SQL
- **Tool:** MySQL Workbench

## Future Improvements
- Implement **stored procedures** for automation.
- Use **Power BI or Tableau** for visualization.
- Optimize queries for **better performance**.

---
📌 **Author:** Thulasimani V 
📧 **Contact:** thulasiv658@gmail.com 
🌟 **GitHub:**  https://github.com/thulasimani003


