
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    payment_method VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Amit Sharma', 28, 'Male', 'Mumbai', '2023-01-15'),
(2, 'Priya Singh', 24, 'Female', 'Delhi', '2023-02-10'),
(3, 'Rahul Verma', 31, 'Male', 'Bengaluru', '2023-03-05'),
(4, 'Sneha Patel', 29, 'Female', 'Ahmedabad', '2023-03-18'),
(5, 'Karan Malhotra', 35, 'Male', 'Chennai', '2023-04-01'),
(6, 'Neha Gupta', 27, 'Female', 'Kolkata', '2023-04-11'),
(7, 'Rohit Desai', 40, 'Male', 'Pune', '2023-05-09'),
(8, 'Sara Khan', 22, 'Female', 'Hyderabad', '2023-05-26'),
(9, 'Vivek Mehta', 33, 'Male', 'Jaipur', '2023-06-03'),
(10, 'Aisha Roy', 26, 'Female', 'Mumbai', '2023-06-20');

INSERT INTO products VALUES
(101, 'Wireless Mouse', 'Electronics', 899),
(102, 'Mechanical Keyboard', 'Electronics', 2500),
(103, 'Running Shoes', 'Footwear', 3200),
(104, 'Formal Shirt', 'Fashion', 1500),
(105, 'Bluetooth Earbuds', 'Electronics', 1999),
(106, 'Leather Wallet', 'Accessories', 999),
(107, 'Sports Watch', 'Accessories', 4500),
(108, 'Backpack', 'Bags', 1800),
(109, 'Smartphone Case', 'Electronics', 450),
(110, 'Sunglasses', 'Fashion', 1200);

INSERT INTO orders VALUES
(1001, 1, '2023-06-01', 'UPI'),
(1002, 3, '2023-06-02', 'Credit Card'),
(1003, 2, '2023-06-05', 'UPI'),
(1004, 5, '2023-06-12', 'Debit Card'),
(1005, 4, '2023-06-18', 'Cash'),
(1006, 7, '2023-07-01', 'UPI'),
(1007, 1, '2023-07-04', 'Credit Card'),
(1008, 8, '2023-07-10', 'UPI'),
(1009, 9, '2023-07-15', 'UPI'),
(1010, 10, '2023-07-21', 'Debit Card');

INSERT INTO order_items VALUES
(1, 1001, 101, 1),
(2, 1001, 109, 2),
(3, 1002, 103, 1),
(4, 1003, 105, 1),
(5, 1004, 102, 1),
(6, 1004, 104, 2),
(7, 1005, 106, 1),
(8, 1006, 107, 1),
(9, 1007, 108, 1),
(10, 1008, 101, 1),
(11, 1008, 110, 1),
(12, 1009, 103, 2),
(13, 1010, 105, 1);
