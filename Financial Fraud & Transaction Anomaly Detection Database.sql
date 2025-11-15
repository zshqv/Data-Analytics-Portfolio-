-- ----------------------------------------------------
-- CREATE DATABASE (optional)
-- ----------------------------------------------------
CREATE DATABASE fraud_detection;
USE fraud_detection;

-- ----------------------------------------------------
-- TABLE 1: customers
-- ----------------------------------------------------

CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  age INT,
  city VARCHAR(100),
  risk_score INT
);

INSERT INTO customers (customer_id, name, age, city, risk_score) VALUES
(1, 'Arjun Mehta', 29, 'Mumbai', 45),
(2, 'Riya Sharma', 34, 'Delhi', 82),
(3, 'Kabir Rana', 41, 'Bangalore', 67),
(4, 'Sneha Kapoor', 26, 'Pune', 30),
(5, 'Ayush Verma', 50, 'Hyderabad', 90),
(6, 'Neha Singh', 23, 'Jaipur', 22),
(7, 'Manish Kumar', 35, 'Chennai', 75),
(8, 'Harsh Jain', 31, 'Ahmedabad', 60),
(9, 'Priya Nair', 28, 'Kochi', 55),
(10, 'Vivek Sinha', 39, 'Kolkata', 88);

-- ----------------------------------------------------
-- TABLE 2: accounts
-- ----------------------------------------------------
CREATE TABLE accounts (
  account_id INT PRIMARY KEY,
  customer_id INT,
  account_type VARCHAR(50),
  balance DECIMAL(12,2),
  status VARCHAR(20),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO accounts (account_id, customer_id, account_type, balance, status) VALUES
(101, 1, 'Savings', 120000, 'Active'),
(102, 1, 'Current', 54000, 'Active'),
(103, 2, 'Savings', 890000, 'Active'),
(104, 2, 'Current', 20000, 'Active'),
(105, 3, 'Savings', 450000, 'Active'),
(106, 4, 'Savings', 12000, 'Active'),
(107, 5, 'Current', 200000, 'Active'),
(108, 6, 'Savings', 3000, 'Active'),
(109, 7, 'Savings', 150000, 'Frozen'),
(110, 8, 'Current', 25000, 'Active'),
(111, 9, 'Savings', 60000, 'Active'),
(112, 10, 'Savings', 900000, 'Active'),
(113, 10, 'Current', 15000, 'Active'),
(114, 5, 'Savings', 300000, 'Active'),
(115, 3, 'Current', 50000, 'Frozen');

-- ----------------------------------------------------
-- ----------------------------------------------------
DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
  txn_id INT PRIMARY KEY,
  account_id INT,
  txn_date DATETIME,
  txn_type VARCHAR(20),
  amount DECIMAL(12,2),
  merchant VARCHAR(100),
  channel VARCHAR(50),
  location VARCHAR(100),
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

INSERT INTO transactions (txn_id, account_id, txn_date, txn_type, amount, merchant, channel, location) VALUES
(1, 101, '2025-01-02 10:15:00', 'Debit', 1200, 'Amazon', 'Card', 'Mumbai'),
(2, 101, '2025-01-02 10:45:00', 'Debit', 950, 'Uber', 'UPI', 'Mumbai'),
(3, 103, '2025-01-03 12:05:00', 'Debit', 200000, 'CarZone', 'Card', 'Delhi'),
(4, 103, '2025-01-03 12:25:00', 'Debit', 210000, 'CarZone', 'Card', 'Delhi'),
(5, 105, '2025-01-04 14:30:00', 'Debit', 50000, 'Flipkart', 'Card', 'Bangalore'),
(6, 105, '2025-01-04 14:50:00', 'Debit', 52000, 'Flipkart', 'Card', 'Bangalore'),
(7, 102, '2025-01-05 23:50:00', 'Debit', 15000, 'NightClub', 'Card', 'Mumbai'),
(8, 102, '2025-01-06 00:10:00', 'Debit', 18000, 'NightClub', 'Card', 'Mumbai'),
(9, 109, '2025-01-06 10:00:00', 'Debit', 3000, 'GroceryMart', 'UPI', 'Chennai'),
(10, 109, '2025-01-06 10:20:00', 'Debit', 3500, 'CafeDay', 'Card', 'Chennai'),
(11, 109, '2025-01-06 10:40:00', 'Debit', 4000, 'PetrolPump', 'Card', 'Chennai'),
(12, 109, '2025-01-06 11:00:00', 'Debit', 4200, 'GroceryMart', 'Card', 'Chennai'),
(13, 109, '2025-01-06 11:20:00', 'Debit', 4500, 'GroceryMart', 'UPI', 'Chennai'),
(14, 109, '2025-01-06 11:40:00', 'Debit', 4600, 'GroceryMart', 'UPI', 'Chennai'),
(15, 110, '2025-01-07 09:30:00', 'Debit', 900, 'Zomato', 'UPI', 'Ahmedabad'),
(16, 110, '2025-01-07 09:31:30', 'Debit', 950, 'Zomato', 'UPI', 'Ahmedabad'),
(17, 110, '2025-01-07 09:33:10', 'Debit', 1000, 'Zomato', 'UPI', 'Ahmedabad'),
(18, 110, '2025-01-07 09:35:40', 'Debit', 1050, 'Zomato', 'UPI', 'Ahmedabad'),
(19, 110, '2025-01-07 09:37:00', 'Debit', 1100, 'Zomato', 'UPI', 'Ahmedabad'),
(20, 110, '2025-01-07 09:39:20', 'Debit', 1000, 'Zomato', 'UPI', 'Ahmedabad'),
(21, 112, '2025-01-08 14:10:00', 'Debit', 300000, 'ElectronicsHub', 'Card', 'Kolkata'),
(22, 112, '2025-01-08 14:25:00', 'Debit', 350000, 'ElectronicsHub', 'Card', 'Kolkata'),
(23, 113, '2025-01-09 11:00:00', 'Credit', 15000, 'Refund-Amazon', 'Online', 'Kolkata'),
(24, 113, '2025-01-09 11:15:00', 'Credit', 15000, 'Refund-Amazon', 'Online', 'Kolkata'),
(25, 113, '2025-01-09 11:25:00', 'Credit', 15000, 'Refund-Amazon', 'Online', 'Kolkata'),
(26, 114, '2025-01-10 16:00:00', 'Debit', 45000, 'ShoppingMall', 'Card', 'Hyderabad'),
(27, 114, '2025-01-10 16:20:00', 'Debit', 47000, 'ShoppingMall', 'Card', 'Hyderabad'),
(28, 114, '2025-01-10 16:30:00', 'Debit', 49000, 'ShoppingMall', 'Card', 'Hyderabad'),
(29, 114, '2025-01-10 16:45:00', 'Debit', 51000, 'ShoppingMall', 'Card', 'Hyderabad'),
(30, 114, '2025-01-10 17:00:00', 'Debit', 53000, 'ShoppingMall', 'Card', 'Hyderabad'),
(31, 108, '2025-01-11 14:00:00', 'Debit', 1500, 'LocalStore', 'UPI', 'Jaipur'),
(32, 108, '2025-01-11 14:10:00', 'Debit', 2000, 'LocalStore', 'UPI', 'Jaipur'),
(33, 108, '2025-01-11 14:20:00', 'Debit', 1800, 'LocalStore', 'UPI', 'Jaipur'),
(34, 111, '2025-01-11 18:00:00', 'Debit', 25000, 'LoungeBar', 'Card', 'Kochi'),
(35, 111, '2025-01-11 18:20:00', 'Debit', 26000, 'LoungeBar', 'Card', 'Kochi'),
(36, 111, '2025-01-11 18:40:00', 'Debit', 27000, 'LoungeBar', 'Card', 'Kochi'),
(37, 104, '2025-01-12 09:00:00', 'Debit', 80000, 'TravelBooking', 'Online', 'Delhi'),
(38, 104, '2025-01-12 09:15:00', 'Debit', 85000, 'TravelBooking', 'Online', 'Delhi'),
(39, 106, '2025-01-12 22:30:00', 'Debit', 10000, 'BarClub', 'Card', 'Pune'),
(40, 106, '2025-01-12 22:45:00', 'Debit', 15000, 'BarClub', 'Card', 'Pune');

-------------------------------------------------------
-- TABLE 4: fraud_alerts
------------------------------------------------------

CREATE TABLE fraud_alerts (
  alert_id INT PRIMARY KEY,
  txn_id INT,
  alert_type VARCHAR(50),
  severity VARCHAR(20),
  status VARCHAR(20),
  FOREIGN KEY (txn_id) REFERENCES transactions(txn_id)
);

INSERT INTO fraud_alerts (alert_id, txn_id, alert_type, severity, status) VALUES
(1, 3, 'High Value Txn', 'High', 'Open'),
(2, 4, 'High Value Txn', 'High', 'Closed'),
(3, 22, 'High Value Txn', 'High', 'Open'),
(4, 23, 'Excess Refunds', 'Medium', 'Open'),
(5, 21, 'High Value Txn', 'High', 'Closed');


git rm /r myData-Analytics-Portfolio

