# Library Management System

## Overview

The Library Management System is designed to manage the information about books, customers, employees, and transactions within a library. This repository contains the database schema and SQL scripts to set up and populate the database tables for the system.

## Table of Contents

- [Features](#features)
- [Database Schema](#database-schema)
- [Setup Instructions](#setup-instructions)
- [Queries and Examples](#queries-and-examples)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Branch Management**: Tracks branches, their managers, addresses, and contact information.
- **Employee Management**: Manages employees, their roles, salaries, and branch assignments.
- **Book Management**: Maintains information about books, including titles, authors, categories, rental prices, and availability status.
- **Customer Management**: Manages customers, their registration details, and borrowing history.
- **Transaction Tracking**: Logs issued and returned books with associated dates and customers.
  
## Database Schema

### Branch

- `Branch_no`: Primary key, identifies each branch uniquely.
- `Manager_Id`: ID of the branch manager.
- `Branch_address`: Address of the branch.
- `Contact_no`: Contact number of the branch.

### Employee

- `Emp_Id`: Primary key, ID of the employee.
- `Emp_name`: Name of the employee.
- `Position`: Role or position of the employee.
- `Salary`: Salary of the employee.
- `Branch_no`: Foreign key referencing `Branch.Branch_no`.

### Books

- `ISBN`: Primary key, unique identifier for each book.
- `Book_title`: Title of the book.
- `Category`: Category or genre of the book.
- `Rental_Price`: Rental price of the book.
- `Status`: Availability status ('yes' or 'no').
- `Author`: Author of the book.
- `Publisher`: Publisher of the book.

### Customers

- `Customer_Id`: Primary key, ID of the customer.
- `Customer_name`: Name of the customer.
- `Customer_address`: Address of the customer.
- `Reg_date`: Registration date of the customer.

### IssueStatus

- `Issue_Id`: Primary key, ID of the issue status.
- `Issued_cust`: Foreign key referencing `Customers.Customer_Id`.
- `Issued_book_name`: Name of the book issued.
- `Issue_date`: Date when the book was issued.
- `Isbn_book`: Foreign key referencing `Books.ISBN`.

### ReturnStatus

- `Return_Id`: Primary key, ID of the return status.
- `Return_cust`: Foreign key referencing `Customers.Customer_Id`.
- `Return_book_name`: Name of the book returned.
- `Return_date`: Date when the book was returned.
- `Isbn_book2`: Foreign key referencing `Books.ISBN`.

## Setup Instructions

To set up the Library Management System database:

1. **Clone Repository**: Clone this repository to your local machine.

   ```bash
   git clone https://github.com/your_username/library-management-system.git
   ```

2. **Database Setup**: Import the SQL scripts into your MySQL database management tool (e.g., MySQL Workbench).

   - Run the `create_database.sql` script to create the `library` database.
   - Run the SQL scripts for each table (`create_tables.sql`) to create the necessary tables.
   - Run the SQL scripts for data insertion (`insert_data.sql`) to populate tables with sample data.

3. **Configuration**: Modify database connection parameters in your application if necessary.

## Queries and Examples

### Sample Queries

1. Retrieve the book title, category, and rental price of all available books:

   ```sql
   SELECT Book_title, Category, Rental_Price
   FROM Books
   WHERE Status = 'yes';
   ```

2. List the employee names and their respective salaries in descending order of salary:

   ```sql
   SELECT Emp_name, Salary
   FROM Employee
   ORDER BY Salary DESC;
   ```

3. Retrieve the book titles and the corresponding customers who have issued those books:

   ```sql
   SELECT b.Book_title, c.Customer_name
   FROM IssueStatus i
   JOIN Books b ON i.Isbn_book = b.ISBN
   JOIN Customers c ON i.Issued_cust = c.Customer_Id;
   ```

## Contributing

Contributions are welcome! If you have suggestions, feature requests, or bug reports, please open an issue or create a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to customize the sections and details according to your specific project requirements and preferences. Ensure to update the paths and names of SQL scripts (`create_database.sql`, `create_tables.sql`, `insert_data.sql`) to match your actual implementation. This README template provides a structured approach to document your Library Management System project on GitHub effectively.
