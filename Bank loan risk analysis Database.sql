				-- Bank loan analysis database
                
	CREATE DATABASE bank_loan_risk;
USE bank_loan_risk;

-- Table 1: Branch
CREATE TABLE branch (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(50),
    city VARCHAR(50),
    region VARCHAR(50)
);

-- Table 2: Loan Officers
CREATE TABLE loan_officers (
    officer_id INT PRIMARY KEY AUTO_INCREMENT,
    officer_name VARCHAR(100),
    branch_id INT,
    experience_years INT,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Table 3: Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    age INT,
    gender ENUM('M','F'),
    city VARCHAR(50),
    income DECIMAL(12,2),
    credit_score INT
);

-- Table 4: Loans
CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    branch_id INT,
    officer_id INT,
    loan_amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    loan_type ENUM('Home','Auto','Personal','Business'),
    start_date DATE,
    duration_months INT,
    status ENUM('Active','Closed','Defaulted'),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
    FOREIGN KEY (officer_id) REFERENCES loan_officers(officer_id)
);

-- Table 5: Payments
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT,
    payment_date DATE,
    emi_amount DECIMAL(10,2),
    paid_on_time BOOLEAN,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

-- Sample Data
INSERT INTO branch (branch_name, city, region) VALUES
('Andheri Central', 'Mumbai', 'West'),
('Connaught Place', 'Delhi', 'North'),
('Park Street', 'Kolkata', 'East'),
('MG Road', 'Bangalore', 'South');

INSERT INTO loan_officers (officer_name, branch_id, experience_years) VALUES
('Rohit Sharma', 1, 6),
('Amit Singh', 2, 8),
('Sneha Rao', 4, 5),
('Priya Das', 3, 7);

INSERT INTO customers (customer_name, age, gender, city, income, credit_score) VALUES
('Arjun Mehta', 32, 'M', 'Mumbai', 85000, 720),
('Neha Jain', 28, 'F', 'Delhi', 70000, 650),
('Rahul Nair', 45, 'M', 'Bangalore', 120000, 780),
('Priya Sen', 36, 'F', 'Kolkata', 95000, 710),
('Karan Patel', 39, 'M', 'Mumbai', 60000, 580),
('Divya Sharma', 30, 'F', 'Delhi', 110000, 760);

INSERT INTO loans (customer_id, branch_id, officer_id, loan_amount, interest_rate, loan_type, start_date, duration_months, status)
VALUES
(1,1,1,500000,8.5,'Home','2023-01-10',120,'Active'),
(2,2,2,200000,12.0,'Personal','2022-06-01',36,'Active'),
(3,4,3,800000,9.0,'Home','2021-04-15',180,'Closed'),
(4,3,4,300000,10.5,'Auto','2022-02-12',60,'Active'),
(5,1,1,150000,14.0,'Personal','2023-05-01',24,'Defaulted'),
(6,2,2,600000,8.0,'Business','2021-12-01',84,'Closed');

INSERT INTO payments (loan_id, payment_date, emi_amount, paid_on_time) VALUES
(1,'2024-12-10',15000,TRUE),
(1,'2025-01-10',15000,TRUE),
(1,'2025-02-10',15000,FALSE),
(2,'2025-01-05',8000,TRUE),
(2,'2025-02-05',8000,TRUE),
(5,'2025-01-20',7000,FALSE),
(5,'2025-02-20',7000,FALSE),
(3,'2023-04-10',10000,TRUE),
(4,'2024-05-10',12000,TRUE),
(4,'2024-06-10',12000,FALSE);