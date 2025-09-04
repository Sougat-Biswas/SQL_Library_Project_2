SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM members;
SELECT * FROM issued_status;
SELECT * FROM return_status;


-- PROJECT-TASK 

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 
-- 'J.B. Lippincott & Co.')"

INSERT INTO books(isbn, book_title, rental_price, status, author, publisher, category)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.','Classic');
SELECT * FROM books;


--Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';


-- Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

SELECT * FROM issued_status;

DELETE FROM issued_status
WHERE issued_id = 'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status;

SELECT issued_book_name 
FROM issued_status 
WHERE issued_emp_id = 'E101';

-- OR

SELECT *
FROM issued_status 
WHERE issued_emp_id = 'E101';


-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT * FROM issued_status;

SELECT issued_emp_id, 
COUNT(issued_id) as total_book_issued                       --Can be removed afterwards
FROM issued_status
GROUP BY issued_emp_id 
HAVING COUNT(issued_id) > 1;


-- CTAS (Create Table As Select)-
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_count.


CREATE TABLE books_cnt
AS 
(
		SELECT b.isbn,b.book_title,
		COUNT(ist.issued_id) as no_of_issued
		FROM books as b
		JOIN issued_status as ist
		ON b.isbn = ist.issued_book_isbn
		GROUP BY 1,2
);

SELECT * FROM books_cnt
ORDER BY no_of_issued DESC;


-- Data Analysis & Findings:
-- Task 7. Retrieve All Books in a Specific Category:


SELECT book_title,category
FROM books
ORDER BY 2;



-- Task 8: Find Total Rental Income by Category:
SELECT * FROM books;

	    SELECT b.category,SUM(b.rental_price) 
		FROM books as b
		JOIN issued_status as ist
		ON b.isbn = ist.issued_book_isbn
		GROUP BY 1
		ORDER BY 2 DESC;


-- Task 9: List Members Who Registered in the Last 720 Days:
SELECT * FROM members;

SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '720 days'


-- Task 10: List Employees with Their Branch Manager's Name and their branch details:

SELECT * FROM employees;
SELECT * FROM branch;

SELECT e1.emp_id, b.branch_id, b.manager_id, e1.emp_name as manager_name
FROM employees as e1
JOIN branch as b
ON e1.branch_id = b.branch_id
JOIN employees as e2
ON b.manager_id = e2.emp_id
ORDER BY e1.emp_name DESC;


-- Task 11: Create a Table of Books with Rental Price Above a Certain Threshold (7 USD):
DROP TABLE IF EXISTS book_price_morethan_seven;
CREATE TABLE book_price_morethan_seven
AS
SELECT book_title, rental_price,category FROM books
WHERE rental_price > 7
ORDER BY rental_price DESC;

SELECT * FROM book_price_morethan_seven;


-- Task 12: Retrieve the List of Books Not Yet Returned


SELECT DISTINCT ist.issued_book_name, ist.issued_date, rst.return_date
FROM issued_status as ist
LEFT JOIN return_status as rst
ON ist.issued_id = rst.issued_id
WHERE rst.return_id IS NULL


