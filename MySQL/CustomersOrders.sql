--MySQL Exercises - Customer Orders

CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);


INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);
       
-- This INSERT fails because of our fk constraint.  No user with id: 98
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/06/06', 33.67, 98);


-- Finding Orders Placed By George: 2 Step Process
SELECT id FROM customers WHERE last_name='George';
SELECT * FROM orders WHERE customer_id = 1;

-- Finding Orders Placed By George: Using a subquery
SELECT * FROM orders WHERE customer_id =
    (
        SELECT id FROM customers
        WHERE last_name='George'
    );

-- Cross Join Craziness
SELECT * FROM customers, orders;

-- IMPLICIT INNER JOIN
SELECT * FROM customers, orders 
WHERE customers.id = orders.customer_id;

-- IMPLICIT INNER JOIN
SELECT first_name, last_name, order_date, amount
FROM customers, orders 
    WHERE customers.id = orders.customer_id;
    
-- EXPLICIT INNER JOINS
SELECT * FROM customers
JOIN orders
    ON customers.id = orders.customer_id;
    
SELECT first_name, last_name, order_date, amount 
FROM customers
JOIN orders
    ON customers.id = orders.customer_id;
    
SELECT *
FROM orders
JOIN customers
    ON customers.id = orders.customer_id;

-- Getting Fancier
SELECT first_name, last_name, order_date, amount 
FROM customers
JOIN orders
    ON customers.id = orders.customer_id
ORDER BY order_date;


SELECT 
    first_name, 
    last_name, 
    SUM(amount) AS total_spent
FROM customers
JOIN orders
    ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY total_spent DESC;

-- LEFT JOIN
SELECT * FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;

SELECT first_name, last_name, order_date, amount
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;
    
SELECT 
    first_name, 
    last_name,
    IFNULL(SUM(amount), 0) AS total_spent
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent;

-- RIGHT JOIN
SELECT * FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id;


CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT
);


INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

INSERT INTO orders (order_date, amount, customer_id) VALUES
('2017/11/05', 23.45, 45),
(CURDATE(), 777.77, 109);



-- RIGHT JOIN
SELECT 
    IFNULL(first_name,'MISSING') AS first, 
    IFNULL(last_name,'USER') as last, 
    order_date, 
    amount, 
    SUM(amount)
FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY first_name, last_name;


-- ON DELETE CASCADE

CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) 
        REFERENCES customers(id)
        ON DELETE CASCADE
);


INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

SELECT * FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;

SELECT * FROM orders
RIGHT JOIN customers
    ON customers.id = orders.customer_id;
    
SELECT * FROM orders
LEFT JOIN customers
    ON customers.id = orders.customer_id;
    
SELECT * FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id;
    
    
    







       


















-- Implicit Joins
SELECT * FROM customers, orders;
SELECT * FROM orders, customers;

SELECT first_name, last_name, order_date, amount 
FROM customers, orders WHERE customers.id = orders.customer_id;

-- Explicit Inner Join
SELECT first_name, last_name, order_date, amount
FROM customers
JOIN orders ON customers.id = orders.customer_id;

-- Works the same as what you're used to
SELECT first_name, last_name, order_date, amount
FROM customers
JOIN orders ON customers.id = orders.customer_id
ORDER BY order_date;

-- More Complex
SELECT 
    first_name, 
    last_name, 
    SUM(amount) as total_spent,
    COUNT(*) AS number_orders,
    AVG(amount) AS avg_order
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customer_id
ORDER BY total_spent DESC;

-- LEFT JOIN
SELECT first_name, last_name, order_date, amount
FROM customers
LEFT OUTER JOIN orders ON customers.id = orders.customer_id;

SELECT first_name, last_name, order_date, amount
FROM customers
LEFT OUTER JOIN orders ON customers.id = orders.customer_id;

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100)
);

CREATE TABLE papers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  grade INT,
  student_id INT,
  FOREIGN KEY (student_id) REFERENCES students(id)
);

INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

SELECT first_name, title, grade
FROM students 
JOIN papers
    ON students.id = papers.student_id
    ORDER BY grade DESC;
    
SELECT 
    first_name, 
    IFNULL(title, 'MISSING') AS title, 
    IFNULL(grade, '0') AS grade
FROM students 
LEFT JOIN papers
    ON students.id = papers.student_id;


SELECT 
    first_name, 
    IFNULL(AVG(grade), '0') AS average,
    CASE
        WHEN AVG(grade) >= 75 THEN 'PASSING'
        ELSE 'FAILING'
    END AS passing_status
FROM students 
LEFT JOIN papers
    ON students.id = papers.student_id
    GROUP BY first_name
    ORDER BY average DESC;
    
