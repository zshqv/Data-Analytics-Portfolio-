				-- Project 2 Financial Fraud & Transaction Anomaly Detection 
                
			#1 List all customers.

SELECT * FROM customers;

		#2 List all accounts with their balance.

SELECT account_id, balance FROM accounts;

		#3 Show all transactions above ₹100,000.

SELECT * FROM transactions WHERE amount > 100000;

		#4 Count total number of transactions.
        
SELECT COUNT(*) FROM transactions;

		#5 Show all debit transactions.
        
SELECT * FROM transactions WHERE txn_type = 'Debit';

		#6 Show customer name, account ID, and balance.
        
SELECT c.name, a.account_id, a.balance
FROM customers c
JOIN accounts a USING(customer_id);

		#7 List all transactions done in Mumbai.

SELECT * FROM transactions WHERE location = 'Mumbai';

		#8 Count transactions done through UPI.
        
SELECT COUNT(*) FROM transactions WHERE channel = 'UPI';

		#9 Find customers with risk score > 70.
        
SELECT * FROM customers WHERE risk_score > 70;

		#10 Show total amount spent per account.
        
SELECT account_id, SUM(amount) AS total_spent
FROM transactions
GROUP BY account_id;

		#11 Show all transactions along with customer name
        
SELECT c.name, t.*
FROM customers c
JOIN accounts a USING(customer_id)
JOIN transactions t USING(account_id);

		#12 List high-value transactions (> ₹50,000) with customer city.
        
SELECT c.city, t.*
FROM customers c
JOIN accounts a USING(customer_id)
JOIN transactions t USING(account_id)
WHERE t.amount > 50000;

		#13 Count transactions per channel.
        
SELECT channel, COUNT(*) AS total
FROM transactions
GROUP BY channel;

		#14 Find total spending per merchant.
        
SELECT merchant, SUM(amount) AS total_spent
FROM transactions
GROUP BY merchant;

		#15 Find customers who have more than 2 accounts. 
        
SELECT customer_id, COUNT(*) AS account_count
FROM accounts
GROUP BY customer_id
HAVING account_count > 2;

		#16 Show all transactions on frozen accounts. 
        
SELECT t.*
FROM accounts a
JOIN transactions t USING(account_id)
WHERE a.status = 'Frozen';

		#17 Count transactions per city.
        
SELECT location, COUNT(*) AS txn_count
FROM transactions
GROUP BY location;


		#18 Show accounts with balance below ₹10,000 that still have transactions.
        
SELECT t.*
FROM accounts a
JOIN transactions t USING(account_id)
WHERE a.balance < 10000;

		#19 Find most frequently used merchant by each account.
        
SELECT account_id, merchant, COUNT(*) AS frequency
FROM transactions
GROUP BY account_id, merchant
ORDER BY frequency DESC;

		#20 Show all refund transactions (Credit type).
        
SELECT * FROM transactions WHERE txn_type = 'Credit';






