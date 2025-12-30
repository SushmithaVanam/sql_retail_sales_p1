DROP TABLE IF EXISTS reatail_sales;
create table retail_sales
(
transactions_id	int PRIMARY KEY,
sale_date date,
sale_time time,	
customer_id	int,
gender	varchar(15),
age	int,
category varchar(20),	
quantiy	int,
price_per_unit float,	
cogs float,
total_sale float
);

select  count(*) from retail_sales;

select * from retail_sales
limit 10;

-- find null values

select  * from retail_sales
where
    transactions_id	is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id	is null
	or
	gender is null
	or
	age	is null
	or
	category is null
	or
	quantiy	is null
	or
	price_per_unit	is null
	or
	cogs is null
	or
	total_sale is null

--delete null values

delete from retail_sales
where
    transactions_id	is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id	is null
	or
	gender is null
	or
	age	is null
	or
	category is null
	or
	quantiy	is null
	or
	price_per_unit	is null
	or
	cogs is null
	or
	total_sale is null

--Explore data

 --how many sales we have

 select count(*) as total_sale from retail_sales
 
select count(*) from retail_sales

--how many unique customers we have
 select count(distinct customer_id) as total_sale from retail_sales

/*data Analysis & Business key problems and answers
question1 
>>Write a SQL query to retreve all columns for sakes made on '2022-11-05'
question 2
>>Write SQL query to retrieve all transactions where the category is "clothing" and  in the moth of nov-2022
question 3
>>Write a SQL query to calculate the total sales(total_sale) for each category
question 4
>>Write SQL query to find the average age of customers who purchased items from "beauty category"
question 5
>>Write SQL query to find transactionswhere total_sale is greater than 1000
question 6
>>Write SQL query to find all trannsactions(transaction_id)made by each gender in each catgeory
question7
>>Write SQL query to calculate the average sale of each month,find out best selling month in year
question 8
>>write SQL quesry to find top 5 customers on highest sales
question 9
>>Write SQL query to find the number of unique customers who purchased items from each category
question 10
>>write SQL query to create each shift and number of orders

*/

--Question 1 >>Write a SQL query to retreve all columns for sakes made on '2022-11-05'

select * from retail_sales
where sale_date = '2022-11-05';

--question 2>>Write SQL query to retrieve all transactions where th category is "clothing" and quantity sold is more than 10  in the moth of nov-2022

select * from retail_sales 
where category = 'Clothing' and
TO_CHAR(sale_date,'YYYY-MM')= '2022-11' AND
Quantiy >=4;

--Question-3 >>Write a SQL query to calculate the total sales(total_sale) for each category

select category,sum(total_sale),count(*) as total_orders from retail_sales
group by category;

--Question 4 >>Write SQL query to find the average age of customers who purchased items from "beauty category"

select avg(age) from retail_sales where category='Beauty';

--Question 5 >>Write SQL query to find transactionswhere total_sale is greater than 1000

select * from retail_sales where total_sale>1000;

--Question 6>>Write SQL query to find all trannsactions(transaction_id)made by each gender in each catgeory

select count(transactions_id),category,gender from retail_sales
group by category,gender;

--Question 7 >>Write SQL query to calculate the average sale of each month,find out best selling month in year
select * from(
select 
extract (Year from sale_date) as Year,
extract (Month from sale_date) as Month,
avg(total_sale) as avg_sale,
rank() over(partition by extract (Year from sale_date) order by avg(total_sale)desc)
from retail_sales
group by 1,2)
where rank =1;

--Question 8 >>write SQL quesry to find top 5 customers on highest sales

select * from retail_sales;

select 
customer_id,
sum(total_sale) as sales
from retail_sales
group by customer_id 
order by 2 desc
limit 5;

--Question 9 >>>>Write SQL query to find the number of unique customers who purchased items from each category

select 
category,
count(distinct customer_id)
from retail_sales
group by 1;

--Question 10 >>write SQL query to create each shift and number of orders

with hourly_sale as 
(
select *,
CASE 
    WHEN extract(hour from sale_time)<12 then 'Morning'
	WHEN extract(hour from sale_time) between 12 and 17 then 'Afternoon'
	WHEN extract(hour from sale_time) between 17 and 20 then 'Evening'
	else 'Night'
 END as sHift
from retail_sales
)
select shift,count(*) as total_orders
from hourly_sale 
group by shift;





	