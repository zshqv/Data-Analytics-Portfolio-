-- Project 1: Bank Loan Risk Analysis



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



			-- LEVEL 1 — Simple Retrieval

SELECT customer_name, age, income
FROM customers;

SELECT * FROM branch
WHERE city = "Mumbai";

SELECT officer_name, branch_id
 FROM loan_officers;
 
 SELECT * FROM customers
 WHERE age BETWEEN 30 and 40;
 
 SELECT * FROM loans
 WHERE status = "active";
 
 SELECT * FROM customers
 WHERE city = "Mumbai" OR "Delhi";
 
 SELECT * FROM customers
 WHERE customer_name LIKE "%P%";
 
 SELECT * FROM payments
 WHERE emi_amount > 10000;
 
 SELECT * FROM customers 
 ORDER BY income DESC;
 
 SELECT * FROM customers 
 LIMIT 3;
 
			-- LEVEL 2 — Filtering & Conditions
            
	SELECT *
FROM customers
WHERE income > 80000 AND credit_score < 700;

SELECT *
FROM loans
WHERE interest_rate BETWEEN 8 AND 10;

SELECT *
FROM payments
WHERE paid_on_time = 0;

SELECT *
FROM loans
WHERE YEAR(start_date) = 2023;

SELECT * FROM customers 
WHERE income < 60000 AND credit_score < 650;

 SELECT *
FROM customers
WHERE city <> 'Delhi';

SELECT DISTINCT loan_type
FROM loans;

 SELECT *
FROM branch
WHERE region <> 'south';

SELECT *
FROM loans
WHERE duration_months = 60;

SELECT *
FROM customers
WHERE income IS NULL;

		-- LEVEL 3 — Aggregation & Grouping
        
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city;

SELECT city, AVG(credit_score) AS average_credit_score
FROM customers
GROUP BY city;

SELECT SUM(loan_amount) AS total_loan_amount
FROM loans
GROUP BY loan_type;

SELECT loan_type, AVG(interest_rate) AS avg_interest_rate
FROM loans
GROUP BY loan_type;

SELECT status, COUNT(*) AS total_loans
FROM loans
GROUP BY status;

SELECT branch_id, MAX(loan_amount) AS max_loan_amount
FROM loans
GROUP BY branch_id;

SELECT loan_id, SUM(emi_amount) AS total_emi_paid
FROM payments
GROUP BY loan_id;

SELECT gender, COUNT(*) AS total_head_count
FROM customers
GROUP BY gender;

			-- LEVEL 4 – Joins:

SELECT
  c.customer_id,
  c.customer_name,
  l.loan_id,
  l.loan_type
FROM customers c
JOIN loans l
  ON c.customer_id = l.customer_id
ORDER BY c.customer_id, l.loan_id;



SELECT
  DISTINCT c.customer_id,
  c.customer_name,
  lo.officer_id,
  lo.officer_name
FROM customers c
JOIN loans l
  ON c.customer_id = l.customer_id
JOIN loan_officers lo
  ON l.officer_id = lo.officer_id
ORDER BY c.customer_id;
 
 SELECT
  b.branch_id,
  b.branch_name,
  lo.officer_id,
  lo.officer_name
FROM branch b
LEFT JOIN loan_officers lo
  ON b.branch_id = lo.branch_id
ORDER BY b.branch_id, lo.officer_name;

SELECT
  l.loan_id,
  l.customer_id,
  l.loan_amount,
  l.loan_type,
  lo.officer_id,
  lo.officer_name,
  lo.experience_years
FROM loans l
JOIN loan_officers lo
  ON l.officer_id = lo.officer_id
WHERE lo.experience_years > 6
ORDER BY lo.experience_years DESC, l.loan_id;

					-- LEVEL 5 — Subqueries
                    
SELECT 
    c.customer_id,
    c.customer_name,
    l.loan_id,
    l.loan_amount
FROM loans l
JOIN customers c ON l.customer_id = c.customer_id
WHERE l.loan_amount > (
    SELECT AVG(loan_amount) 
    FROM loans
)
ORDER BY l.loan_amount DESC;

SELECT 
    customer_id,
    customer_name,
    income
FROM customers
WHERE income > (
    SELECT AVG(income)
    FROM customers
)
ORDER BY income DESC;

SELECT 
    c.customer_id,
    c.customer_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM loans l
    WHERE l.customer_id = c.customer_id
      AND l.status = 'Defaulted'
);

SELECT 
    c.customer_id,
    c.customer_name,
    l.loan_id,
    l.loan_amount
FROM loans l
JOIN customers c ON l.customer_id = c.customer_id
WHERE l.loan_amount = (
    SELECT MAX(loan_amount)
    FROM loans
);

SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(l.loan_id) AS loan_count
FROM customers c
JOIN loans l ON c.customer_id = l.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(l.loan_id) >= 2
ORDER BY loan_count DESC;


				-- Level 6 Analytical Queries:

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(p.payment_id) AS delayed_count
FROM customers c
JOIN loans l ON c.customer_id = l.customer_id
JOIN payments p ON l.loan_id = p.loan_id
WHERE p.paid_on_time = FALSE
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(p.payment_id) > 2
ORDER BY delayed_count DESC;


SELECT
    b.branch_id,
    b.branch_name,
    SUM(l.loan_amount) AS total_disbursed,
    RANK() OVER (ORDER BY SUM(l.loan_amount) DESC) AS branch_rank
FROM branch b
JOIN loans l ON b.branch_id = l.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_disbursed DESC;


				-- LEVEL 7 – Case Expressions and Conditional Logic:

SELECT
    customer_id,
    customer_name,
    income,
    CASE
        WHEN income > 100000 THEN 'High Income'
        WHEN income BETWEEN 70000 AND 100000 THEN 'Medium Income'
        ELSE 'Low Income'
    END AS income_category
FROM customers
ORDER BY income DESC;

SELECT
    l.loan_id,
    c.customer_id,
    c.customer_name,
    c.credit_score,
    l.status,
    CASE
        WHEN c.credit_score < 650 OR l.status = 'Defaulted' THEN 'High Risk'
        ELSE 'Low Risk'
    END AS risk_label
FROM loans l
JOIN customers c ON l.customer_id = c.customer_id
ORDER BY risk_label DESC, l.loan_id;


SELECT
    payment_id,
    loan_id,
    payment_date,
    emi_amount,
    CASE
        WHEN paid_on_time = TRUE THEN 'On Time'
        ELSE 'Late'
    END AS payment_status
FROM payments
ORDER BY loan_id, payment_date;


SELECT
    b.branch_id,
    b.branch_name,
    COUNT(l.loan_id) AS total_loans,
    CASE
        WHEN COUNT(l.loan_id) > (
            SELECT AVG(loan_count) 
            FROM (
                SELECT COUNT(*) AS loan_count
                FROM loans
                GROUP BY branch_id
            ) AS avg_table
        ) THEN 'High Volume'
        ELSE 'Low Volume'
    END AS volume_category
FROM branch b
LEFT JOIN loans l ON b.branch_id = l.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_loans DESC;


			-- level 8 Business Case Study
            
	SELECT
    c.customer_id,
    c.customer_name,
    SUM(l.loan_amount) AS total_loan_amount
FROM customers c
JOIN loans l ON c.customer_id = l.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_loan_amount DESC
LIMIT 5;


SELECT
    b.region,
    ROUND(AVG(c.credit_score), 2) AS avg_credit_score
FROM branch b
JOIN loans l ON b.branch_id = l.branch_id
JOIN customers c ON l.customer_id = c.customer_id
GROUP BY b.region
ORDER BY avg_credit_score DESC
LIMIT 1;







 