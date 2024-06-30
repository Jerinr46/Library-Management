CREATE DATABASE library;
-- Create the 'library' database

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(100),
    Contact_no VARCHAR(15)
);

-- 2. Employee table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(50),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

-- 3. Books table
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(100),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(50),
    Publisher VARCHAR(50)
);

-- 4. Customer table
CREATE TABLE Customers (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(50),
    Customer_address VARCHAR(100),
    Reg_date DATE
);

-- 5. IssueStatus table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(100),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

-- 6. ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(100),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

-- Insert random data into Branch table
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
    (1, 101, '123 Main St', '555-1234'),
    (2, 102, '456 Elm St', '555-5678'),
    (3, 103, '789 Oak St', '555-9876'),
    (4, 104, '321 Pine St', '555-4321'),
    (5, 105, '654 Cedar St', '555-8765');
-- Insert random data into Employee table
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
    (1, 'John Smith', 'Manager', RAND() * 10000 + 50000, 1),
    (2, 'Jane Doe', 'Assistant', RAND() * 5000 + 30000, 2),
    (3, 'Michael Johnson', 'Librarian', RAND() * 4000 + 25000, 1),
    (4, 'Emily Brown', 'Clerk', RAND() * 3000 + 20000, 3),
    (5, 'Daniel Martinez', 'Assistant', RAND() * 5000 + 30000, 2);
-- Insert random data into Customer table
INSERT INTO Customers (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
    (1, 'Alice Johnson', '789 Maple Ave', DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 10) YEAR)),
    (2, 'Bob Smith', '456 Birch St', DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 10) YEAR)),
    (3, 'Carol Williams', '321 Cedar Ln', DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 10) YEAR)),
    (4, 'David Brown', '987 Oak Dr', DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 10) YEAR)),
    (5, 'Emma Garcia', '654 Pine Rd', DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 10) YEAR));
-- Insert random data into Books table
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
    ('978-3-16-148410-0', 'The Great Gatsby', 'Fiction', RAND() * 10 + 100, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
    ('978-0-306-40615-7', '1984', 'Dystopian', RAND() * 8 + 80, 'yes', 'George Orwell', 'Secker & Warburg'),
    ('978-0-8129-7263-5', 'To Kill a Mockingbird', 'Classic', RAND() * 9 + 90, 'yes', 'Harper Lee', 'HarperCollins'),
    ('978-0-451-52360-4', 'The Catcher in the Rye', 'Coming-of-Age', RAND() * 7 + 70, 'yes', 'J.D. Salinger', 'Little, Brown'),
    ('978-1-101-93575-9', 'Pride and Prejudice', 'Romance', RAND() * 11 + 110, 'yes', 'Jane Austen', 'T. Egerton, Whitehall');
-- Insert random data into IssueStatus table
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
    (1, 1, 'The Great Gatsby', DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY), '978-3-16-148410-0'),
    (2, 2, '1984', DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY), '978-0-306-40615-7'),
    (3, 3, 'To Kill a Mockingbird', DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY), '978-0-8129-7263-5'),
    (4, 4, 'The Catcher in the Rye', DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY), '978-0-451-52360-4'),
    (5, 5, 'Pride and Prejudice', DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY), '978-1-101-93575-9');
-- Insert random data into ReturnStatus table

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
SELECT
    i.Issue_Id,
    i.Issued_cust,
    i.Issued_book_name,
    DATE_ADD(i.Issue_date, INTERVAL FLOOR(RAND() * 15) DAY),
    i.Isbn_book
FROM IssueStatus i;
SELECT DISTINCT c.Customer_name
FROM Customers c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
JOIN Books b ON i.Isbn_book = b.ISBN
WHERE b.Rental_Price > 2;

