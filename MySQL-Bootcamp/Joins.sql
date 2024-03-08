CREATE DATABASE Joins;
USE Joins;
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8, 2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
INSERT INTO customers (first_name, last_name, email)
VALUES ('Boy', 'George', 'george@gmail.com'),
    ('George', 'Michael', 'gm@gmail.com'),
    ('David', 'Bowie', 'david@gmail.com'),
    ('Blue', 'Steele', 'blue@gmail.com'),
    ('Bette', 'Davis', 'bette@aol.com');
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
    ('2017-11-11', 35.50, 1),
    ('2014-12-12', 800.67, 2),
    ('2015-01-03', 12.50, 2),
    ('1999-04-11', 450.25, 5);
SELECT id
FROM customers
WHERE last_name = 'George';
SELECT *
FROM orders
WHERE customer_id = 1;
SELECT *
FROM orders
WHERE customer_id = (
        SELECT id
        FROM customers
        WHERE last_name = 'George'
    );
-- To perform a (kind of useless) cross join:
SELECT *
FROM customers,
    orders;
-- Our first inner join!
SELECT *
FROM customers
    JOIN orders ON orders.customer_id = customers.id;
SELECT first_name,
    last_name,
    order_date,
    amount
FROM customers
    JOIN orders ON orders.customer_id = customers.id;
-- The order doesn't matter here:
SELECT *
FROM orders
    JOIN customers ON customers.id = orders.customer_id;
SELECT first_name,
    last_name,
    SUM(amount) AS total
FROM customers
    JOIN orders ON orders.customer_id = customers.id
GROUP BY first_name,
    last_name
ORDER BY total;
SELECT first_name,
    last_name,
    order_date,
    amount
FROM customers
    LEFT JOIN orders ON orders.customer_id = customers.id;
SELECT order_date,
    amount,
    first_name,
    last_name
FROM orders
    LEFT JOIN customers ON orders.customer_id = customers.id;
SELECT first_name,
    last_name,
    IFNULL(SUM(amount), 0) AS money_spent
FROM customers
    LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY first_name,
    last_name;
SELECT first_name,
    last_name,
    order_date,
    amount
FROM customers
    RIGHT JOIN orders ON customers.id = orders.customer_id;
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8, 2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE
);
-- Exercises
create table students (
    id int auto_increment primary key,
    first_name varchar(50)
);
create table papers(
    student_id int,
    title varchar(100),
    grade smallint,
    foreign key (student_id) references students(id)
);
INSERT INTO students (first_name)
VALUES ('Caleb'),
    ('Samantha'),
    ('Raj'),
    ('Carlos'),
    ('Lisa');
INSERT INTO papers (student_id, title, grade)
VALUES (1, 'My First Book Report', 60),
    (1, 'My Second Book Report', 75),
    (2, 'Russian Lit Through The Ages', 94),
    (2, 'De Montaigne and The Art of The Essay', 98),
    (4, 'Borges and Magical Realism', 89);
select S.first_name,
    P.title,
    P.grade
from students S
    join papers P on S.id = P.student_id
order by P.grade DESC;
select S.first_name,
    P.title,
    P.grade
from students S
    left join papers P on S.id = P.student_id;
select S.first_name,
    ifnull(P.title, 'MISSING'),
    ifnull(P.grade, 0)
from students S
    left join papers P on S.id = P.student_id;
select S.first_name,
    ifnull(AVG(P.grade), 0) as average
from students S
    left join papers P on S.id = P.student_id
GROUP BY S.first_name
ORDER BY average DESC;
select S.first_name,
    ifnull(AVG(P.grade), 0) as average,
    case
        when AVG(P.grade) >= 75 THEN 'PASSING'
        ELSE 'FAILING'
    END AS passing_status
from students S
    left join papers P on S.id = P.student_id
GROUP BY S.first_name
ORDER BY average DESC;
-- ##################################
-- Many to many
CREATE DATABASE tv;
USE tv;
CREATE TABLE reviewers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);
CREATE TABLE series (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    released_year YEAR,
    genre VARCHAR(100)
);
CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    rating DECIMAL(2, 1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY (series_id) REFERENCES series (id),
    FOREIGN KEY (reviewer_id) REFERENCES reviewers (id)
);
INSERT INTO series (title, released_year, genre)
VALUES ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
INSERT INTO reviewers (first_name, last_name)
VALUES ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
INSERT INTO reviews(series_id, reviewer_id, rating)
VALUES (1, 1, 8.0),
(1, 2, 7.5),
(1, 3, 8.5),
(1, 4, 7.7),
(1, 5, 8.9),
    (2, 1, 8.1),
(2, 4, 6.0),
(2, 3, 8.0),
(2, 6, 8.4),
(2, 5, 9.9),
    (3, 1, 7.0),
(3, 6, 7.5),
(3, 4, 8.0),
(3, 3, 7.1),
(3, 5, 8.0),
    (4, 1, 7.5),
(4, 3, 7.8),
(4, 4, 8.3),
(4, 2, 7.6),
(4, 5, 8.5),
    (5, 1, 9.5),
(5, 3, 9.0),
(5, 4, 9.1),
(5, 2, 9.3),
(5, 5, 9.9),
    (6, 2, 6.5),
(6, 3, 7.8),
(6, 4, 8.8),
(6, 2, 8.4),
(6, 5, 9.1),
    (7, 2, 9.1),
(7, 5, 9.7),
    (8, 4, 8.5),
(8, 2, 7.8),
(8, 6, 8.8),
(8, 5, 9.3),
    (9, 2, 5.5),
(9, 3, 6.8),
(9, 4, 5.8),
(9, 6, 4.3),
(9, 5, 4.5),
    (10, 5, 9.9),
    (13, 3, 8.0),
(13, 4, 7.2),
    (14, 2, 8.5),
(14, 3, 8.9),
(14, 4, 8.9);
-- Challenges
select S.title,
    R.rating
from series S
    join reviews R on S.id = R.series_id;
select S.title,
    AVG(R.rating) as avg_rating
from series S
    join reviews R on S.id = R.series_id
group by S.title
order by avg_rating;
select first_name,
    last_name,
    rating
from reviewers
    join reviews on reviewers.id = reviews.reviewer_id;
select S.title as unreviewed_series
from series S
    left join reviews R on S.id = R.series_id
where R.rating is null;
select s.genre,
    avg(r.rating)
from series s
    join reviews r on s.id = r.series_id
group by s.genre;
select RE.first_name,
    RE.last_name,
    COUNT(R.rating) as COUNT,
    IFNULL(MIN(R.rating), 0) as MIN,
    IFNULL(MAX(R.rating), 0) as MAX,
    ROUND(IFNULL(AVG(R.rating), 0), 2) as AVG,
    IF(COUNT(R.rating) > 0, 'ACTIVE', 'INACTIVE') AS STATUS
from reviewers RE
    left join reviews R on R.reviewer_id = RE.id
group by RE.first_name,
    RE.last_name;
select S.title,
    R.rating,
    CONCAT(RE.first_name, ' ', RE.last_name) as reviewer
from series S
    join reviews R on S.id = R.series_id
    join reviewers RE on RE.id = R.reviewer_id
order by S.title;