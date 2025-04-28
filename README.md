# 📚 Bookstore Management Database Project

## Overview
This project provides a simple **Bookstore Database Management System** built using SQL. It handles data for **Books**, **Customers**, and **Orders**.

The project includes:
- CSV files to populate the database (`Books.csv`, `Customers.csv`, `Orders.csv`).
- SQL queries for performing various operations (`Queries.sql`).


## Files Description
- **Data**
  - **Books.csv**: Contains information about books such as Title, Author, Genre, and Price.
  - **Customers.csv**: Contains customer information like Name, Email, and Location.
  - **Orders.csv**: Represents order transactions linking customers to the books they purchased, along with purchase dates and quantities.
- **Queries.sql**: Contains SQL scripts for creating tables, inserting data, and executing important queries like:
  - Fetching customer orders
  - Getting bestselling books
  - Revenue reports
  - Data analysis tasks

## How to Use
1. Create a new database using your preferred SQL platform (e.g., MySQL, PostgreSQL, SQLite).
2. Import the CSV files into your database.
3. Run the SQL queries provided in `Queries.sql` to create tables, insert data, and execute operations.

> **Tip**: Some SQL platforms (like MySQL Workbench or pgAdmin) allow direct CSV imports into tables.

## Requirements
- SQL Database (e.g., MySQL, PostgreSQL, SQLite)
- Basic understanding of SQL commands (CREATE, INSERT, SELECT, JOIN, etc.)

## Possible Extensions
- Add authentication for customers.
- Include order tracking and shipment details.
- Analyze customer behavior and book popularity trends.
- Build a front-end web app connected to this database.

