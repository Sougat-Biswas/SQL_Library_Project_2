## Library Management System (SQL Project)
# Project Overview
# Project Title: Library Management System
Level: Beginner
Database: library_project
This project demonstrates SQL skills for managing a library database. It covers creating tables, inserting records, and performing queries to simulate real-world library operations such as issuing books, tracking returns, and analyzing usage.
The project is ideal for beginners who want hands-on practice with SQL queries that reflect actual business operations in a library system.
## Objectives
Database Setup: Create and populate tables for books, members, employees, branches, issued books, and return status.
CRUD Operations: Perform basic SQL operations — Insert, Update, Delete.
Exploratory Queries: Retrieve records and answer practical library-related questions.
Business Analysis: Use SQL to track issued books, overdue returns, and rental income.
## Project Structure
1. Database Setup
Database Creation: The project begins with creating a database named library_project.
## Table Creation: Tables include:

books (book details)
members (library members)
employees (library staff)
branch (branch details)
issued_status (issued books)
return_status (returned books)
Sample Data Insertion: Insert initial records into all tables for analysis and testing.
## 2. Core Tasks & Queries

## Task 1. Insert a New Book Record
```
INSERT INTO books(isbn, book_title, rental_price, status, author, publisher, category)```
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.', 'Classic');

```
## Task 2. Update an Existing Member’s Address
```
UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';
```

## Task 3. Delete a Record from Issued Status 
```
DELETE FROM issued_status
WHERE issued_id = 'IS121';
```

Task 4. Retrieve Books Issued by a Specific Employee
SELECT issued_book_name
FROM issued_status
WHERE issued_emp_id = 'E101';
Task 5. List Members Who Have Issued More Than One Book
SELECT issued_emp_id, COUNT(issued_id) AS total_book_issued
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(issued_id) > 1;
Task 6. Create a Summary Table (CTAS)
CREATE TABLE books_cnt AS
SELECT b.isbn, b.book_title,
       COUNT(ist.issued_id) AS no_of_issued
FROM books b
JOIN issued_status ist
ON b.isbn = ist.issued_book_isbn
GROUP BY 1,2;
Task 7. Retrieve All Books in a Specific Category
SELECT book_title, category
FROM books
ORDER BY category;
Task 8. Find Total Rental Income by Category
SELECT b.category, SUM(b.rental_price)
FROM books b
JOIN issued_status ist
ON b.isbn = ist.issued_book_isbn
GROUP BY b.category
ORDER BY 2 DESC;
Task 9. List Members Registered in the Last 720 Days
SELECT *
FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '720 days';
Task 10. List Employees with Branch Manager’s Details
SELECT e1.emp_id, b.branch_id, b.manager_id, e2.emp_name AS manager_name
FROM employees e1
JOIN branch b ON e1.branch_id = b.branch_id
JOIN employees e2 ON b.manager_id = e2.emp_id
ORDER BY e1.emp_name DESC;
Task 11. Create a Table of Books Above Price Threshold
CREATE TABLE book_price_morethan_seven AS
SELECT book_title, rental_price, category
FROM books
WHERE rental_price > 7
ORDER BY rental_price DESC;
Task 12. Retrieve Books Not Yet Returned
SELECT DISTINCT ist.issued_book_name, ist.issued_date, rst.return_date
FROM issued_status ist
LEFT JOIN return_status rst
ON ist.issued_id = rst.issued_id
WHERE rst.return_id IS NULL;
Task 13. Identify Members with Overdue Books
(Assuming 30-day return period)
SELECT m.member_name, ist.issued_book_name, ist.issued_date,
       CURRENT_DATE - ist.issued_date AS days_overdue
FROM issued_status ist
JOIN members m ON ist.issued_member_id = m.member_id
LEFT JOIN return_status rst ON ist.issued_id = rst.issued_id
WHERE rst.return_id IS NULL
  AND CURRENT_DATE - ist.issued_date > 30;
Data Analysis & Findings
Book Management: Easy tracking of available books, categories, and rental prices.
Member Insights: Identify active members who borrow multiple books.
Employee Performance: Monitor which employees issue the most books.
Financials: Calculate rental income per category.
Operational Monitoring: Detect overdue books and pending returns.
Reports
Issued Books Report: Track books issued per employee and member.
Rental Income Report: Category-wise revenue summary.
Overdue Books Report: Members with pending/overdue returns.
Branch Report: Employee and branch manager mapping.
Conclusion
This project serves as a beginner-friendly SQL case study for managing a library system. It covers database setup, CRUD operations, advanced queries, and business insights. The findings help understand library operations, member behavior, and financial performance.
