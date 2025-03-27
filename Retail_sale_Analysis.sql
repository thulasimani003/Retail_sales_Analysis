-- database setup
create database Retail_sales_Analysis;
use Retail_sales_Analysis;
create table retail_sales(
	transactions_id int primary key,
	sale_date date,
	sale_time time,
	customer_id	int,
    gender varchar(20),
	age int,	
    category varchar(40),
	quantity int,
	price_per_unit float,
	cogs float,
	total_sale float);
select * from retail_sales;
-- data exploration and Cleaning

-- finding the Total sales
select count(*) as Total_sales from retail_sales;

-- finding the Total number of unique customers
select count(distinct customer_id) as total_customers from retail_sales;

-- checking for any null values
select * from retail_sales where 
transactions_id is null or	
sale_date is null or 
sale_time is null or 
customer_id is null or	
gender is null or
age	is null or 
category is null or
quantity is null or
price_per_unit is null or
cogs is null or	
total_sale is null;

-- if found any null values , Deleting the null values
Delete from retail_sales where 
transactions_id is null or	
sale_date is null or 
sale_time is null or 
customer_id is null or	
gender is null or
age	is null or 
category is null or
quantity is null or
price_per_unit is null or
cogs is null or	
total_sale is null;

-- Data Analysis and Findings

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05':
select * from retail_sales where sale_date='2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
select * from retail_sales where category='Clothing' and date_format(sale_date,'%Y-%m')='2022-11' and quantity>=4;

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
select category,sum(total_sale) as Total_Sales,count(*) as Total_Orders from retail_sales group by category;

-- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select round(avg(age),2) as Average_age from retail_sales where category='Beauty';

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from retail_sales where total_sale>1000;

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select 
gender,category,count(transactions_id) as Total_Transactions from retail_sales 
group by gender,category
 order by category;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select year, month, avg_sale, monthly_rank
from(
    select 
        DATE_FORMAT(sale_date, '%Y') as year,
        DATE_FORMAT(sale_date, '%m') as month,
        avg(total_sale) as avg_sale,
        rank() over (
            partition by DATE_FORMAT(sale_date, '%Y') 
            order by (total_sale) desc 
        ) as monthly_rank
    from retail_sales
    group by DATE_FORMAT(sale_date, '%Y'), DATE_FORMAT(sale_date, '%m')
) as ranked_sales;

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales :
select customer_id,sum(total_sale) as Total_sales from retail_sales
 group by customer_id 
 order by Total_sales desc
 limit 5;
 
 -- 9. Write a SQL query to find the number of unique customers who purchased items from each category.:
 select category,count(distinct customer_id) as total_customers from retail_sales 
 group by category;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with hourly_sales
as(
select *,
case 
when hour(sale_time)<12 then 'Morning'
when hour(sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift
from retail_sales)
select shift,count(*) as total_orders from hourly_sales
group by shift;







