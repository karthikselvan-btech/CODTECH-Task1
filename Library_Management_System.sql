create database if not exists Library_Management_System;
use Library_Management_System;

CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Genre VARCHAR(50),
    PublicationYear INT,
    Quantity INT DEFAULT 1
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(15),
    JoinDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    BorrowDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ReturnDate DATE,
    Status ENUM('Borrowed', 'Returned') DEFAULT 'Borrowed',
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- 1. Insert Data

-- Insert into Books:
INSERT INTO Books (Title, Author, Genre, PublicationYear, Quantity) 
VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, 5),
('1984', 'George Orwell', 'Dystopian', 1949, 3),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 4);

-- Insert into Members:
INSERT INTO Members (FirstName, LastName, Email, PhoneNumber) 
VALUES 
('Karthik', 'Selvan', 'karthik.selvan@example.com', '1234567890'),
('Vimalan', 'Selvam', 'vimalan.selvam@example.com', '0987654321');

-- Insert into Transactions:
INSERT INTO Transactions (MemberID, BookID, BorrowDate) 
VALUES 
(1, 1, '2024-12-01'),
(2, 2, '2024-12-05');


-- 2. Retrieve Data

-- Get all books:
SELECT * FROM Books;

-- Find books by a specific author:
SELECT * FROM Books WHERE Author = 'George Orwell';

-- List all borrowed books:
SELECT 
    T.TransactionID, B.Title, M.FirstName, M.LastName, T.BorrowDate 
FROM 
    Transactions T
JOIN 
    Books B ON T.BookID = B.BookID
JOIN 
    Members M ON T.MemberID = M.MemberID
WHERE 
    T.Status = 'Borrowed';
 
 
    -- 3. Update Data
    
    -- Update the quantity of a book:
    UPDATE Books 
SET Quantity = Quantity - 1 
WHERE BookID = 1 AND Quantity > 0;

-- Mark a book as returned:
UPDATE Transactions 
SET Status = 'Returned', ReturnDate = '2024-12-27' 
WHERE TransactionID = 1;

UPDATE Transactions 
SET Status = 'Returned', ReturnDate = '2024-12-29' 
WHERE TransactionID = 2;

-- 4. Delete Data

-- Delete a member:
DELETE FROM Members 
WHERE MemberID = 2;

-- Remove a book
DELETE FROM Books 
WHERE BookID = 3;







