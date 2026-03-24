-- Creating Dabase Structure --

create database fnp_sales_data;

use fnp_sales_data;

create table customers(
	customer_id varchar(5) primary key,
    customer_name varchar(50) not null,
    city varchar(50) not null,
    contact_number varchar(15) not null,
    email_id varchar(100) not null,
    gender varchar(10) not null,
    address varchar(200) not null
);

create table products(
	product_id int primary key,
    product_name varchar(50) not null,
    category varchar(50) not null,
    price int not null,
    occasion varchar(30) not null
);

-- drop table products;

create table orders(
	order_id int primary key,
    customer_id varchar(5) not null,
    product_id int not null,
    quantity int not null,
    order_date varchar(15) not null,
    order_time time not null,
    delivery_date varchar(15) not null,
    delivery_time time not null,
    location varchar(50) not null,
    occasion varchar(30) not null,
    foreign key(customer_id) references customers(customer_id),
    foreign key(product_id) references products(product_id)
);

-- Quering the tables

select * from customers;

select * from products;

select * from orders;

-- Transforming Data
alter table orders add column order_date2 date after order_date;

update orders set order_date2 = str_to_date(order_date, "%d-%m-%Y");

alter table orders drop column order_date;

alter table orders rename column order_date2 to order_date;

alter table orders add column delivery_date2 date after delivery_date;

update orders set delivery_date2 = str_to_date(delivery_date, "%d-%m-%Y");

alter table orders drop column delivery_date;

alter table orders rename column delivery_date2 to delivery_date;

-- SELECT 
--    products.product_name AS 'Product Name',
  --  products.price AS 'Product Price',
    -- orders.quantity AS 'Ordered Qunatity',
    -- orders.quantity * products.price AS 'Total Amount'
-- FROM
   --  products
     --   JOIN
    -- orders ON products.product_id = orders.product_id;

alter table orders add column total_amount float; 

UPDATE products
        JOIN
    orders ON products.product_id = orders.product_id 
SET 
    orders.total_amount = products.price * orders.quantity;


-- Answers to find

# Q1. Find the total revenue generated across all the products.
SELECT 
    SUM(total_amount) AS 'Total Revenue Generated'
FROM
    orders;

# Q2. Find the average of customers spending on products.
SELECT 
    ROUND(AVG(total_amount), 2) AS 'Average Customer Spending'
FROM
    orders;
    
# Q3. Calculate the average time taken in days for orders to deliver.
-- SELECT 
--     ROUND(DATEDIFF(delivery_date, order_date),2) 
--     AS 'Average Delivery Time taken in Days'
-- FROM
--     orders;

SELECT 
    ROUND(AVG(DATEDIFF(delivery_date, order_date)),2) 
    AS 'Average Delivery Time taken in Days'
FROM
    orders;
    
# Q4. List total revenue generated month by month.
SELECT 
    MONTHNAME(order_date) AS 'Month',
    SUM(total_amount) AS 'Total Revenue'
FROM
    orders
GROUP BY MONTHNAME(order_date) , MONTH(order_date)
ORDER BY MONTH(order_date);
    
# Q5. Determine which 10 products are giving the most revenue.
SELECT 
    products.product_name AS 'Product Name',
    SUM(orders.total_amount) AS 'Total Revenue'
FROM
    products
        JOIN
    orders ON products.product_id = orders.product_id
GROUP BY products.product_name
ORDER BY SUM(orders.total_amount) DESC
LIMIT 10;

-- Determine second top 10 products which are giving the most revenue.
SELECT 
    products.product_name AS 'Product Name',
    SUM(orders.total_amount) AS 'Total Revenue'
FROM
    products
        JOIN
    orders ON products.product_id = orders.product_id
GROUP BY products.product_name
ORDER BY SUM(orders.total_amount) DESC
LIMIT 10 offset 10;

# Q6. Calculate which product categories gave what revenue.
SELECT 
    products.category AS Product_Category,
    SUM(orders.total_amount) AS 'Total Revenue'
FROM
    products
        JOIN
    orders ON products.product_id = orders.product_id
GROUP BY Product_Category;

# Q7. List which 10 cities are placing the highest number of orders.
SELECT 
    customers.city AS `Customer City`,
    COUNT(orders.order_id) AS `Number of Orders`
FROM
    customers
        JOIN
    orders ON customers.customer_id = orders.customer_id
GROUP BY `Customer City`
ORDER BY `Number of Orders` DESC
LIMIT 10;

# Q8. Find the average revenue by morning, afternoon and evening.
SELECT 
    CASE
        WHEN order_time < '12:00:00' THEN 'Morning'
        WHEN order_time < '18:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS `Time of Day`,
    ROUND(AVG(total_amount), 2) AS `Average Revenue`
FROM
    orders
GROUP BY `Time of Day`;

# Q9. Compare the total revenue generated from different occasions.
SELECT 
    occasion, SUM(total_amount) AS `Total Revenue`
FROM
    orders
GROUP BY occasion;

# Q10. Find out which products are most popular during specific occasions.
select
*
from
(SELECT 
	orders.occasion AS `Occasion`,
    products.product_name AS `Product Name`,
    SUM(total_amount) AS `Total Revenue`,
    dense_rank() over(partition by orders.occasion order by SUM(total_amount) desc) as `Product Rank`
FROM
    products
        JOIN
    orders ON products.product_id = orders.product_id
GROUP BY `Product Name` , `Occasion`) as `Products Rank by Occasions`
where `Product Rank` <= 5;

with `Products Rank by Occasions` as (
	SELECT 
		orders.occasion AS `Occasion`,
		products.product_name AS `Product Name`,
		SUM(total_amount) AS `Total Revenue`,
		dense_rank() over(partition by orders.occasion order by SUM(total_amount) desc) as `Product Rank`
	FROM
		products
			JOIN
		orders ON products.product_id = orders.product_id
	GROUP BY `Product Name` , `Occasion`
)select * from `Products Rank by Occasions` where `Product Rank` <= 5;