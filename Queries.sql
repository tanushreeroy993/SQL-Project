-- create database
create database OnlineBookStore;
USE OnlineBookStore;
select database();

-- create table books
drop table if exists books;
create table books(
book_ID serial primary key,
Title varchar(100),
Author Varchar(100),
Genre varchar(50),
Published_Year int,
Price numeric(10,2),
Stock int);

-- create table customers
drop table if exists customers;
create table customers(
customer_ID serial primary key,
Name Varchar(100),
Email varchar(100),
Phone varchar(15),
City varchar(50),
Country varchar(150));

-- create table orders
drop table if exists orders;
create table orders(
order_ID serial primary key,
customer_ID int references customers(customer_ID),
book_ID int references books(book_ID),
Order_Date date,
Quantity INT,
Total_Amount numeric(10,2));

select * from books;
select * from customers;
select * from orders;

SHOW VARIABLES LIKE 'secure_file_priv';

-- Import data into Books table (MySQL syntax)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Books.csv'
INTO TABLE Books
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Book_ID, Title, Author, Genre, Published_Year, Price, Stock);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Customer_ID, Name, Email, Phone, City, Country);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount);

-- 1) Retrive all book in "Fiction" genere:
select * from books where Genre = "Fiction";

-- 2) Find books published before 1950:
select * from books where Published_Year < 1950;

-- 3) List all customers from the Canada
SELECT * FROM customers WHERE Country LIKE '%Canada%';

-- 4) Show orders placed in November 2023
SELECT * FROM orders 
WHERE YEAR(Order_Date) = 2023 
  AND MONTH(Order_Date) = 11;
  
  -- or 
  select * from orders
  where order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available
SELECT sum(Stock) FROM books ;

-- 6) Find the details of the most expensive book
SELECT * FROM books order by Price Desc limit  1;

-- 7) Show all customers who ordered more than 1 quantity of a book
SELECT  *
FROM orders 
where quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20
SELECT *
FROM orders 
Where  Total_Amount > 20;

-- 9) List all genres available in the Books table
SELECT distinct Genre
FROM Books;

-- 10) Find the book with the lowest stock
Select * from books Order by Stock limit 1;

-- 11) Calculate the total revenue generated from all orders
Select sum(Total_Amount) from orders ;

-- Advanced Queries

-- 1) Retrieve the total number of books sold for each genre
Select b.Genre, sum(o.Quantity) as Total_books_sold
from orders o 
join books b
on o.book_ID = b.book_ID  
Group by b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre
Select avg(Price) as Average_Price
from books 
where Genre = "Fantasy";

-- 3) List customers who have placed at least 2 orders
Select c.customer_ID, c.Name , count(c.Name) as Number_of_orders
from orders o 
join customers c
on o.customer_ID = c.customer_ID 
group by c.customer_ID 
having Number_of_orders >= 2;

-- 4) Find the most frequently ordered book
Select b.book_ID,b.Title, count(b.book_ID) as no_of_orders
from orders o 
join books b
on  o.book_ID = b.book_ID
group by b.book_ID
order by  no_of_orders DESC
limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre
select * from books 
where Genre = 'Fantasy' 
order by Price desc 
limit 3;

-- 6) Retrieve the total quantity of books sold by each author
SELECT COALESCE(SUM(o.Quantity), 0) AS TotalSold, b.Author
FROM orders o
JOIN books b ON b.book_ID = o.book_ID
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located
select distinct c.city
from orders o 
join customers c
on o.customer_ID = c.customer_ID
group by o.customer_ID having sum(o.Total_Amount) > 30;

-- 8) Find the customer who spent the most on orders
SELECT c.name, SUM(COALESCE(o.Total_Amount, 0)) AS total_spent
FROM orders o
JOIN customers c ON o.customer_ID = c.customer_ID
GROUP BY o.customer_ID
ORDER BY total_spent DESC
LIMIT 1;

-- 9) Calculate the stock remaining after fulfilling all orders
SELECT 
  b.book_ID,
  b.Title,
  b.Author,
  b.Stock,
  COALESCE(SUM(o.Quantity), 0) AS total_orders,
  b.Stock - COALESCE(SUM(o.Quantity), 0) AS new_stock
FROM books b
LEFT JOIN orders o ON b.book_ID = o.book_ID
GROUP BY b.book_ID
ORDER BY b.book_ID;