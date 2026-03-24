FNP Sales Data Analysis (SQL Project)

Description:

This project focuses on analyzing sales data from an online gifting platform (FNP) using SQL. The goal is to extract meaningful business insights related to revenue, customer behavior, product performance, and order trends.

Project Overview:

This SQL-based data analysis project explores transactional sales data to answer key business questions such as:

* How much revenue is generated?
* What is the average customer spending?
* Which products perform the best?
* How do sales vary by time, city, and occasion?

The project demonstrates strong SQL skills including joins, aggregations, window functions, and data transformation.

Dataset Information:

The project uses three datasets:

* **customers.csv** → Contains customer details (name, city, contact, etc.)
* **products.csv** → Contains product details (name, category, price, occasion)
* **orders.csv** → Contains transaction data (orders, dates, quantity, delivery info)

Database Schema:

The database consists of three tables:

1. Customers

* customer_id (Primary Key)
* customer_name
* city
* contact_number
* email_id
* gender
* address

2. Products

* product_id (Primary Key)
* product_name
* category
* price
* occasion

3. Orders

* order_id (Primary Key)
* customer_id (Foreign Key)
* product_id (Foreign Key)
* quantity
* order_date
* order_time
* delivery_date
* delivery_time
* location
* occasion
* total_amount

Relationships:

* Orders table connects Customers and Products using foreign keys.

Features:

* Data cleaning and transformation (date formatting)
* Revenue calculation using joins
* Customer spending analysis
* Delivery time analysis
* Monthly revenue tracking
* Product ranking using window functions
* City-wise order analysis
* Time-based revenue insights
* Occasion-based sales insights

Key Business Questions Answered:

1. Total revenue generated across all products
2. Average customer spending
3. Average delivery time (in days)
4. Monthly revenue trends
5. Top 10 revenue-generating products
6. Revenue by product category
7. Top 10 cities by number of orders
8. Revenue by time of day (Morning, Afternoon, Evening)
9. Revenue generated across different occasions
10. Most popular products for each occasion

Sample Insights:

* A small number of products contribute significantly to total revenue.
* Certain occasions (like festivals or special days) drive higher sales.
* Customer ordering behavior varies based on time of day.
* Delivery times impact overall customer experience.

Tech Stack:

* SQL (MySQL)
* CSV files for dataset
* Database design & querying

How to Run the Project:

1. Create a database:
   ```sql
   CREATE DATABASE fnp_sales_data;
   USE fnp_sales_data;
   ```
2. Create tables using the SQL script

3. Import the CSV files into respective tables:

   * customers.csv
   * products.csv
   * orders.csv

4. Run the SQL file:
   `fnp Sales Data Analysis.sql`

5. Execute queries to generate insights

Future Improvements:

* Build an interactive dashboard using Power BI or Tableau
* Automate data ingestion process
* Add advanced analytics (customer segmentation, forecasting)
* Optimize queries for performance

Author:

Nishant Yadav

License:

This project is created for learning and portfolio purposes.
