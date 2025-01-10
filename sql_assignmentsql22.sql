-- 1. Create a table called employees with the following structure?
-- : emp_id (integer, should not be NULL and should be a primary key)Q
-- : emp_name (text, should not be NULL)Q
-- : age (integer, should have a check constraint to ensure the age is at least 18)Q
-- : email (text, should be unique for each employee)Q
-- : salary (decimal, with a default value of 30,000).

-- Write the SQL query to create the above table with all constraints.

use assign;

create table employees
(emp_id int not null unique, emp_name text not null,
age int check(age>=18), email varchar(255) unique, 
salary decimal default(30000));

-- 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
-- examples of common types of constraints.

-- Constraints in a database are rules that enforce data integrity and consistency. They define conditions that 
-- must be met by the data stored in a table. By applying constraints, you prevent invalid data from being entered 
-- into your database, ensuring that the data remains accurate, reliable, and consistent over time.
-- Common Types of Constraints:

-- NOT NULL:

-- Purpose: Ensures that a column cannot contain NULL values. This means that a value must be provided for the column in every row.
-- Example: emp_name TEXT NOT NULL – Every employee must have a name.
-- UNIQUE:

-- Purpose: Ensures that all values in a column (or a combination of columns) are unique. This prevents duplicate values.
-- Example: email VARCHAR(255) UNIQUE – Every employee must have a unique email address.
-- PRIMARY KEY:

-- Purpose: Uniquely identifies each row in a table. It is a combination of NOT NULL and UNIQUE. A table can have only one primary key.
-- Example: emp_id INT NOT NULL PRIMARY KEY – Each employee has a unique ID that serves as the primary identifier.
-- FOREIGN KEY:

-- Purpose: Establishes a link between two tables. A foreign key in one table references the primary key in another table. It ensures referential integrity, meaning that a foreign key value must either be NULL or match an existing primary key value in the referenced table.
-- Example: Suppose you have a departments table with a dept_id primary key and an employees table. You could add a foreign key to the employees table: dept_id INT, FOREIGN KEY (dept_id) REFERENCES departments(dept_id). This ensures that every employee is assigned to a valid department.
-- CHECK:

-- Purpose: Defines a condition that must be true for the data in a column. If the condition is false, the data cannot be inserted or updated.
-- Example: age INT CHECK (age >= 18) – Ensures that an employee's age is at least 18.
-- DEFAULT:

-- Purpose: Specifies a default value for a column. If no value is provided during insertion, the default value is used.
-- Example: salary DECIMAL DEFAULT 30000 – If no salary is specified when adding a new employee, the salary defaults to 30,000.

-- 3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
-- your answer.
-- whenever we want that the column should not be null then that time we use not null to avoid that column left 
-- without any input. No, primary key can't contain null value as it is unique and also not null.

-- 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
-- example for both adding and removing a constraint.

-- We use alter table command to add or remove constraints
-- adding a constraint
ALTER TABLE employees
ADD CONSTRAINT emp_id Check (emp_id > 1001);
-- removing upper constraint
ALTER TABLE employees
DROP CHECK emp_id;

#5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
-- Provide an example of an error message that might occur when violating a constraint.

create table employees
(emp_id int not null unique, emp_name text not null,
age int check(age>=18), email varchar(255) unique, 
salary decimal default(30000));

insert into employees values
(101, "Mr.Mathur", 17, "mathur@gmail.com", 250000);
-- 10:22:04	insert into employees values (101, "Mr.Mathur", 17, "mathur@gmail.com", 250000)	Error Code: 3819. Check constraint 'employees_chk_1' is violated.	0.047 sec

-- 6. You created a products table without constraints as follows:

create table products 
(product_id INT,
product_name VARCHAR(50),
price DECIMAL(10, 2));
-- Now, you realise that?
-- : The product_id should be a primary key.
-- : The price should have a default value of 50.00

Alter table products
add primary key (product_id);

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

-- 7. You have two tables:
create table students
(student_id int unique,
student_name varchar(50),
class_id int);

insert into students values
(1, "Alice", 101),
(2, "Bob", "102"),
(3,  "Charlie", 101);

create table Classes
(class_id int,
class_name varchar(20));

insert into Classes values
(101, "Math"),(102, "Science"), (103, "History");

-- Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

-- 8. Consider the following three tables:
create table orders
(order_id int,
order_date date,
customer_id int);
insert into orders values
(1, '2024-01-01', 101), (2, '2024-01-03', 102);

create table customers
(customer_id int,
customer_name varchar(30));
insert into customers values
(101, "Alice"), (102, "Bob");

create table products2
(product_id int, 
product_name varchar(30),
order_id int);

insert into products2 values
(1, "Laptop", 1), (2, "Phone", Null);

-- Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
-- listed even if they are not associated with an order 

-- Hint: (use INNER JOIN and LEFT JOIN).


select o.order_id, c.customer_name, p.product_name  from products2 p
left join orders o 
on p.order_id = o.order_id
left join
Customers c 
on o.customer_id = c.customer_id;

-- 9. Given the following tables:

create table Sales
(sale_id int, 
product_id int,
amount int);
insert into Sales values
(1, 101, 500), 
(2, 102, 300),(3, 101, 700);

create table products3
(product_id int, 
product_name varchar(30));

insert into products3 values
(101, "Laptop"), (102, "Phone");

-- Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function. 
select sum(s.amount), s.product_id
from sales s inner join products3 p
on s.product_id = p.product_id
group by p.product_id;

-- 10. You are given three tables:

create table orders2
(order_id int,
order_date date,
customer_id int);

insert into orders2 values
(1, '2024-01-02',1), (2,'2024-01-05',2);

create table customers2
(customer_id int, 
customer_name varchar(20));

insert into customers2 values
(1, 'Alice'), (2,'Bob'); 

create table Order_details
(order_id int, 
product_id int,
quantity int);

insert into Order_details values
(1, 101, 2), (1, 102,1), (2, 101,3);
##Write a query to display the order_id, customer_name, and the quantity of products ordered by each
##customer using an INNER JOIN between all three tables.

select od.order_id, c.customer_name, od.quantity from orders2  o
inner join order_details od
on o.order_id = od.order_id
inner join customers2 c
on o.customer_id = c.customer_id;

-- SQL Commands
## 1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences
-- Primary Keys:

-- A primary key uniquely identifies each record in a table. It cannot contain NULL values. In the Maven Movies database, some of the primary keys are:   

-- actor: actor_id
-- address: address_id
-- category: category_id
-- city: city_id
-- country: country_id
-- customer: customer_id
-- film: film_id
-- inventory: inventory_id
-- language: language_id
-- payment: payment_id
-- rental: rental_id
-- staff: staff_id
-- store: store_id
-- Foreign Keys:   

-- A foreign key in one table refers to the primary key in another table. It establishes a link between the two tables. A foreign key can contain NULL values (unless it's part of a composite key with a NOT NULL constraint). Here are some examples of foreign keys in Maven Movies:   

-- address: city_id (references city.city_id)
-- customer: store_id (references store.store_id), address_id (references address.address_id)
-- film: language_id (references language.language_id)
-- film_actor: actor_id (references actor.actor_id), film_id (references film.film_id)
-- film_category: film_id (references film.film_id), category_id (references category.category_id)
-- inventory: film_id (references film.film_id), store_id (references store.store_id)
-- payment: customer_id (references customer.customer_id), staff_id (references staff.staff_id), rental_id (references rental.rental_id)
-- rental: inventory_id (references inventory.inventory_id), customer_id (references customer.customer_id), staff_id (references staff.staff_id)
-- staff: address_id (references address.address_id), store_id (references store.store_id)
-- store: address_id (references address.address_id), manager_staff_id (references staff.staff_id)

-- 2- List all details of actors
select * from actor;
-- 3 -List all customer information from DB.
select * from customer;
-- 4 -List different countries.
select country from country;
-- 5 -Display all active customers.
select * from customer
where active = 1;
-- 6 -List of all rental IDs for customer with ID 1.
select rental_id from rental
where customer_id = 1;
-- 7 - Display all the films whose rental duration is greater than 5 .
select * from film 
where rental_duration > 5;
-- 8 - List the total number of films whose replacement cost is greater than $15 and less than $20.
select count(*) from film
where replacement_cost > 15 and replacement_cost < 20;
-- 9 - Display the count of unique first names of actors.
select count(distinct first_name) from actor;
-- 10- Display the first 10 records from the customer table .
select * from customer
LIMIT 10;
-- 11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
select * from customer
where first_name like 'B%'
LIMIT 3;
-- 12 -Display the names of the first 5 movies which are rated as ‘G’.
select title from film
where rating = 'G'
LIMIT 5;
-- 13-Find all customers whose first name starts with "a".
select * from customer
where first_name like "a%";
-- 14- Find all customers whose first name ends with "a".
select * from customer
where first_name like "%a";
-- 15- Display the list of first 4 cities which start and end with ‘a’ .
select * from city
where city like "a%a";
-- 16- Find all customers whose first name have "NI" in any position.
select * from customer
where first_name like "%NI%";
-- 17- Find all customers whose first name have "r" in the second position .
select * from customer
where first_name like "_r%";
-- 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
select * from customer
where first_name like "a%" and length(first_name) = 5;
-- 19- Find all customers whose first name starts with "a" and ends with "o".
select * from customer
where first_name like "a%o";
-- 20 - Get the films with pg and pg-13 rating using IN operator.
select * from film
where rating in ('PG', 'PG-13');
-- 21 - Get the films with length between 50 to 100 using between operator.
SELECT *
FROM film
WHERE length BETWEEN 50 AND 100;
-- 22 - Get the top 50 actors using limit operator.
select * from actor 
limit 50;
-- 23 - Get the distinct film ids from inventory table.
select distinct film_id from inventory;
-- Functions-- 
-- Basic Aggregate Functions:
-- Question 1:
-- Retrieve the total number of rentals made in the Sakila database.
-- Hint: Use the COUNT() function.
use sakila;
select count(*) from rental;
-- Question 2:
-- Find the average rental duration (in days) of movies rented from the Sakila database.
-- Hint: Utilize the AVG() function.
select avg(rental_duration) from film;
-- String Functions:
-- Question 3:
-- Display the first name and last name of customers in uppercase.
-- Hint: Use the UPPER () function.
select upper(first_name), upper(last_name) from customer;
-- Question 4:
-- Extract the month from the rental date and display it alongside the rental ID.
-- Hint: Employ the MONTH() function.
select month(rental_date) from rental;

-- GROUP BY:
-- Question 5:
-- Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
-- Hint: Use COUNT () in conjunction with GROUP BY.
select customer_id,count(rental_id) from rental
group by customer_id;

-- Question 6:
-- Find the total revenue generated by each store.
-- Hint: Combine SUM() and GROUP BY.

## there is not any store with revenue column present in sakila dataset

-- Question 7:
-- Determine the total number of rentals for each category of movies.
-- Hint: JOIN film_category, film, and rental tables, then use COUNT () and GROUP BY. 
use mavenmovies;
select fc.category_id, count(r.rental_id) from rental r
inner join film_category fc
on r.last_update = fc.last_update
group by fc.category_id;

-- Question 8:
-- Find the average rental rate of movies in each language.
-- Hint: JOIN film and language tables, then use AVG () and GROUP BY.
select language_id, avg(rental_rate) from film
group by language_id;

-- Joins
-- Questions 9 -
-- Display the title of the movie, customer s first name, and last name who rented it.
-- Hint: Use JOIN between the film, inventory, rental, and customer tables.

select f.title, c.first_name, c.last_name from film f 
inner join inventory i 
on f.film_id = i.film_id inner join customer c 
on i.store_id = c.store_id;

-- Question 10:
-- Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
-- Hint: Use JOIN between the film actor, film, and actor tables.

select a.first_name, a.last_name, f.title from actor a
inner join film_actor fa on
a.actor_id = fa.actor_id inner join
film f on fa.film_id = f.film_id 
where f.title = "Gone with the Wind";

-- Question 11:
-- Retrieve the customer names along with the total amount they've spent on rentals.
-- Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.

select c.first_name, c.last_name, sum(p.amount) from customer c
inner join payment p on
c.customer_id = p.customer_id
group by c.first_name, c.last_name;

-- Question 12:
-- List the titles of movies rented by each customer in a particular city (e.g., 'London').
-- Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
select f.title, c.first_name, c.last_name, ci.city
from film f inner join inventory i 
on f.film_id = i.film_id inner join rental r 
on i.inventory_id = r.rental_id inner join customer c
on r.customer_id = c.customer_id inner join address ad
on c.address_id = ad.address_id inner join city ci
on ad.city_id = ci.city_id;

-- Question 13:
-- Display the top 5 rented movies along with the number of times they've been rented.
-- Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.

SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;

-- Question 14:
-- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
-- Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.

SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)  
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2; 

-- Windows Function:

-- 1. Rank the customers based on the total amount they've spent on rentals.

SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS customer_rank
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- 2. Calculate the cumulative revenue generated by each film over time.

SELECT f.title, p.payment_date, SUM(p.amount) OVER (PARTITION BY f.title ORDER BY p.payment_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.title, p.payment_date;

-- 3. Determine the average rental duration for each film, considering films with similar lengths.

SELECT f.title, f.length, AVG(TIMESTAMPDIFF(MINUTE, r.rental_date, r.return_date)) OVER (PARTITION BY f.length) AS avg_rental_duration
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL  -- Exclude open rentals
ORDER BY f.length, f.title;

-- 4. Identify the top 3 films in each category based on their rental counts.
WITH FilmRentalCounts AS (
    SELECT
        f.film_id,
        f.title,
        fc.category_id,
        COUNT(r.rental_id) AS rental_count
    FROM
        film f
    JOIN
        film_category fc ON f.film_id = fc.film_id
    JOIN
        inventory i ON f.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        f.film_id, f.title, fc.category_id
),
RankedFilms AS (
  SELECT
        film_id,
        title,
        category_id,
        rental_count,
        RANK() OVER (PARTITION BY category_id ORDER BY rental_count DESC) AS film_rank
    FROM
        FilmRentalCounts
)
SELECT
    f.title,
    c.name AS category_name,
    rf.rental_count
FROM RankedFilms rf
JOIN film f ON rf.film_id = f.film_id
JOIN category c ON rf.category_id = c.category_id
WHERE rf.film_rank <= 3
ORDER BY c.name, rf.film_rank;

-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals
-- across all customers.

WITH CustomerRentalCounts AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        COUNT(r.rental_id) AS customer_rental_count
    FROM
        customer c
    JOIN
        rental r ON c.customer_id = r.customer_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
),
AverageRentalCount AS (
    SELECT AVG(customer_rental_count) AS avg_rental_count
    FROM CustomerRentalCounts
)
SELECT
    crc.first_name,
    crc.last_name,
    crc.customer_rental_count,
    arc.avg_rental_count,
    (crc.customer_rental_count - arc.avg_rental_count) AS rental_count_difference
FROM
    CustomerRentalCounts crc, AverageRentalCount arc
ORDER BY rental_count_difference DESC;

-- 6. Find the monthly revenue trend for the entire rental store over time.
SELECT
    DATE_FORMAT(r.rental_date, '%Y-%m') AS rental_month,
    SUM(p.amount) AS monthly_revenue
FROM
    rental r
JOIN
    payment p ON r.rental_id = p.rental_id
GROUP BY
    rental_month
ORDER BY
    rental_month;
    
-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

WITH CustomerTotalSpending AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_spending
    FROM
        customer c
    JOIN
        rental r ON c.customer_id = r.customer_id
    JOIN
        payment p ON r.rental_id = p.rental_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
),
SpendingPercentiles AS (
    SELECT
        total_spending,
        PERCENT_RANK() OVER (ORDER BY total_spending) as percentile_rank
    FROM CustomerTotalSpending
)
SELECT cts.first_name, cts.last_name, cts.total_spending
FROM CustomerTotalSpending cts
JOIN SpendingPercentiles sp ON cts.total_spending = sp.total_spending
WHERE sp.percentile_rank >= 0.8  -- Top 20% (80th percentile and above)
ORDER BY cts.total_spending DESC;

-- 8. Calculate the running total of rentals per category, ordered by rental count

WITH CategoryRentalCounts AS (
    SELECT
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM
        category c
    JOIN
        film_category fc ON c.category_id = fc.category_id
    JOIN
        inventory i ON fc.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.name
)
SELECT
    category_name,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM
    CategoryRentalCounts
ORDER BY rental_count DESC;

-- 9. Find the films that have been rented less than the average rental count for their respective categories.

WITH FilmCategoryRentals AS (
    SELECT
        f.film_id,
        f.title,
        fc.category_id,
        COUNT(r.rental_id) AS rental_count
    FROM
        film f
    JOIN
        film_category fc ON f.film_id = fc.film_id
    JOIN
        inventory i ON f.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        f.film_id, f.title, fc.category_id
),
CategoryAverageRentals AS (
    SELECT
        category_id,
        AVG(rental_count) AS avg_rental_count
    FROM
        FilmCategoryRentals
    GROUP BY
        category_id
)
SELECT
    fcr.title,
    c.name AS category_name,
    fcr.rental_count
FROM
    FilmCategoryRentals fcr
JOIN CategoryAverageRentals car ON fcr.category_id = car.category_id
JOIN category c ON fcr.category_id = c.category_id
WHERE
    fcr.rental_count < car.avg_rental_count
ORDER BY c.name, fcr.title;

-- 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

SELECT
    DATE_FORMAT(p.payment_date, '%Y-%m') AS payment_month,
    SUM(p.amount) AS monthly_revenue
FROM
    payment p
GROUP BY
    payment_month
ORDER BY
    monthly_revenue DESC
LIMIT 5;

-- 1. First Normal Form (1NF):

--  a. Identify a table in the Sakila database that violates 1NF. Explain how you

--  would normalize it to achieve 1NF.

-- A common example of a potential 1NF violation, though not strictly present in the standard Sakila schema, is if the address table had multiple phone numbers stored in a single column. Let's imagine a modified address table like this (this is not the actual Sakila table):

-- Hypothetical address table (violating 1NF):

-- address_id	address	district	city_id	postal_code	phone
-- 1	123 Main St	Anytown	1	12345	555-1212, 555-1213
-- 2	456 Oak Ave	Anytown	1	54321	555-5678
-- 3	789 Pine Ln	Othertown	2	98765	555-9012, 555-9013, 555-9014

-- Export to Sheets
-- In this example, the phone column sometimes contains multiple phone numbers separated by commas. This violates 1NF because each column should hold only atomic (single) values.

-- Normalization to 1NF:

-- To normalize this hypothetical address table to 1NF, we would create a separate table to store phone numbers. This eliminates the repeating group of phone numbers within a single column.

-- Normalized tables:

-- address table (in 1NF):

-- address_id	address	district	city_id	postal_code
-- 1	123 Main St	Anytown	1	12345
-- 2	456 Oak Ave	Anytown	1	54321
-- 3	789 Pine Ln	Othertown	2	98765

-- Export to Sheets
-- address_phone table:

-- address_phone_id	address_id	phone
-- 1	1	555-1212
-- 2	1	555-1213
-- 3	2	555-5678
-- 4	3	555-9012
-- 5	3	555-9013
-- 6	3	555-9014

-- Export to Sheets
-- Explanation:

-- We created a new table called address_phone.
-- The address_phone table has a composite key consisting of address_phone_id (a surrogate key) and address_id (a foreign key referencing the address table).
-- Each row in address_phone represents a single phone number associated with an address.
-- By creating this separate table, we have achieved 1NF. Each column now contains only atomic values. This also allows us to easily add or remove phone numbers for an address without modifying the structure of the address table.

-- Important Note about Sakila: The actual Sakila database is generally well-designed and doesn't have obvious 1NF violations like the hypothetical example I provided. This example was created to illustrate the concept of 1NF normalization. You might find more subtle issues related to other normal forms (2NF, 3NF) in Sakila, but 1NF is usually well-addressed.

-- 2. Second Normal Form (2NF):

--  a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 

--  If it violates 2NF, explain the steps to normalize it.

-- To determine if a table is in 2NF, we need to check two things:

-- Is the table already in 1NF? (As discussed in the previous response, this means it has no repeating groups or multi-valued attributes.)
-- Does the table have a composite primary key (a primary key made up of two or more columns)? If the primary key is a single column, the table is automatically in 2NF.
-- If there's a composite key, are all non-key attributes fully dependent on all parts of the composite key? If a non-key attribute depends only on part of the composite key, then the table violates 2NF.
-- Let's consider the film_actor table in the Sakila database.

-- film_actor table:

-- film_id	actor_id
-- 1	1
-- 1	2
-- 2	1
-- ...	...

-- Export to Sheets
-- Primary Key: The primary key of film_actor is a composite key: (film_id, actor_id). This combination uniquely identifies each row in the table (a specific actor appearing in a specific film).
-- Non-Key Attributes: There are no other non-key attributes in this table.
-- Is film_actor in 2NF?

-- Yes, the film_actor table is in 2NF. Since there are no non-key attributes, there are no partial dependencies to worry about. The only dependency that exists is that the combination of film_id and actor_id uniquely determines a row in the table.

-- Example of a 2NF Violation (Hypothetical):

-- Let's imagine we added a film_title column to the film_actor table:

-- Hypothetical film_actor table (violating 2NF):

-- film_id	actor_id	film_title
-- 1	1	Academy Dinosaur
-- 1	2	Academy Dinosaur
-- 2	1	Ace Goldfinger
-- ...	...	...

-- Export to Sheets
-- Now, we have a partial dependency. The film_title attribute depends only on film_id (part of the composite key), not on the entire composite key (film_id, actor_id). This violates 2NF.

-- Normalization to 2NF (Hypothetical):

-- To normalize this hypothetical table, we would create a separate table for films:

-- film table:

-- film_id	film_title
-- 1	Academy Dinosaur
-- 2	Ace Goldfinger
-- ...	...

-- Export to Sheets
-- film_actor table (in 2NF):

-- film_id	actor_id
-- 1	1
-- 1	2
-- 2	1
-- ...	...

-- Export to Sheets
-- Now, the film_actor table is back in 2NF. The film_title is stored only once in the film table, and the film_actor table simply links actors to films.

-- Key takeaway: The standard film_actor table in the Sakila database is already in 2NF. I provided the hypothetical example to illustrate what a 2NF violation would look like and how to normalize it.

-- 3. Third Normal Form (3NF):

--  a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 

--  present and outline the steps to normalize the table to 3NF.

-- A table is in 3NF if it meets the following criteria:

-- It is in 2NF.
-- All non-key attributes are dependent only on the primary key and not on any other non-key attributes. This means there are no transitive dependencies.
-- Let's look at the address table in the Sakila database.

-- address table:

-- address_id	address	address2	district	city_id	postal_code	phone	last_update
-- 1	47 MySakila Dr		Alberta	300			2006-02-15 09:45:46
-- ...	...	...	...	...	...	...	...

-- Export to Sheets
-- The address table has a transitive dependency. Let's break it down:

-- Primary Key: address_id
-- Non-Key Attributes: address, address2, district, city_id, postal_code, phone, last_update
-- Transitive Dependency:

-- The district attribute is transitively dependent on the primary key (address_id) through city_id. Here's why:

-- address_id determines city_id (an address belongs to a city).
-- city_id determines district (a city is in a district).
-- Therefore, address_id indirectly determines district via city_id. This is a transitive dependency and violates 3NF.

-- Normalization to 3NF:

-- To normalize the address table to 3NF, we need to remove the transitive dependency by creating a new table for cities:

-- city table:

-- city_id	city	country_id	last_update
-- 300	Lethbridge	103	2006-02-15 09:45:46
-- ...	...	...	...

-- Export to Sheets
-- address table (in 3NF):

-- address_id	address	address2	city_id	postal_code	phone	last_update
-- 1	47 MySakila Dr		300			2006-02-15 09:45:46
-- ...	...	...	...	...	...	...

-- Export to Sheets
-- Now, the address table no longer has a transitive dependency. district information is accessed through the city table, which is linked by city_id.

-- Explanation:

-- We created a new city table with city_id as its primary key.
-- We moved the district attribute into the city table.
-- The address table now contains a foreign key, city_id, that references the city table.
-- This eliminates the transitive dependency. Now, district depends directly on city_id, and city_id depends directly on address_id (through the foreign key relationship).

-- By normalizing to 3NF, we reduce data redundancy and improve data integrity. If a district name changes, we only need to update it in one place (the city table) instead of potentially multiple rows in the address table.

-- 4. Normalization Process:

--  a. Take a specific table in Sakila and guide through the process of normalizing it from the initial 

--  unnormalized form up to at least 2NF.

-- demonstrate the steps more clearly than trying to force a contrived unnormalized state onto the existing Sakila tables, which are generally already well-normalized.

-- 1. Unnormalized Form (UNF):

-- Imagine we have a single table called customer_details that combines customer and address information:

-- customer_details (UNF):

-- customer_id	first_name	last_name	address	district	city_id	city
-- 1	John	Smith	123 Main St	Alberta	300	Lethbridge
-- 2	Jane	Doe	456 Oak Ave	California	463	Hollywood
-- 3	David	Lee	123 Main St	Alberta	300	Lethbridge
-- ...	...	...	...	...	...	...

-- Export to Sheets
-- Problems in UNF:

-- Redundancy: Address information (address, district, city_id, city) is repeated for customers who live at the same address (e.g., customer 1 and 3).
-- Update Anomalies: If the name of a city changes, we have to update multiple rows.
-- Insertion Anomalies: We can't store information about a city unless we have a customer living there.
-- Deletion Anomalies: If we delete the last customer living in a city, we lose the city information.
-- 2. First Normal Form (1NF):

-- To achieve 1NF, we need to eliminate repeating groups. In this case, we don't have repeating groups of columns within a row, but we do have redundant data across rows. However, the key step for 1NF is to define a primary key. In this case, customer_id serves as a unique identifier for each customer.

-- customer_details (1NF):

-- customer_id	first_name	last_name	address	district	city_id	city
-- 1	John	Smith	123 Main St	Alberta	300	Lethbridge
-- 2	Jane	Doe	456 Oak Ave	California	463	Hollywood
-- 3	David	Lee	123 Main St	Alberta	300	Lethbridge
-- ...	...	...	...	...	...	...

-- Export to Sheets
-- The table is now in 1NF because it has a primary key (customer_id) and no repeating groups within rows. However, the redundancy issues remain.

-- 3. Second Normal Form (2NF):

-- To achieve 2NF, we need to address partial dependencies. Since we have a composite key, we don't technically have partial dependencies in this example yet. However, the redundancy between the address information and the customer information is a clear violation of good database design that 2NF addresses by splitting the table.

-- customer table:

-- customer_id	first_name	last_name	address_id
-- 1	John	Smith	1
-- 2	Jane	Doe	2
-- 3	David	Lee	1
-- ...	...	...	...

-- Export to Sheets
-- address table:

-- address_id	address	district	city_id	city
-- 1	123 Main St	Alberta	300	Lethbridge
-- 2	456 Oak Ave	California	463	Hollywood
-- ...	...	...	...	...

-- Export to Sheets
-- Now we have two tables and the redundancy is gone. If the city name changes, we only update it in one place (the address table).

-- Key Changes for 2NF:

-- We created a new address table with address_id as the primary key.
-- We moved the address-related attributes (address, district, city_id, city) to the address table.
-- We added a foreign key address_id to the customer table to link customers to their addresses.
-- By splitting the table like this, we've eliminated the redundancy and update/insertion/deletion anomalies, effectively achieving 2NF. If we were to continue to 3NF, as discussed in the previous response, we would create a separate city table to remove the transitive dependency on city_id through the district.

-- 5. CTE Basics:

--  a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 

--  have acted in from the actor and film_actor tables

WITH ActorFilmCounts AS (
    SELECT
        a.actor_id,
        a.first_name,
        a.last_name,
        COUNT(fa.film_id) AS film_count
    FROM
        actor AS a
    JOIN
        film_actor AS fa ON a.actor_id = fa.actor_id
    GROUP BY
        a.actor_id, a.first_name, a.last_name
)
SELECT
    first_name,
    last_name,
    film_count
FROM
    ActorFilmCounts
ORDER BY
    film_count DESC, last_name, first_name;
    
-- 6. CTE with Joins:

--  a. Create a CTE that combines information from the film and language tables to display the film title, 

--  language name, and rental rate.

WITH FilmLanguageInfo AS (
    SELECT
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM
        film AS f
    JOIN
        language AS l ON f.language_id = l.language_id
)
SELECT
    film_title,
    language_name,
    rental_rate
FROM
    FilmLanguageInfo
ORDER BY
    film_title; -- Optional: Order the results
    
-- 7 CTE for Aggregation:

--  a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 

--  from the customer and payment tables.

WITH CustomerTotalPayments AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_payment
    FROM
        customer AS c
    JOIN
        payment AS p ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
)
SELECT
    first_name,
    last_name,
    total_payment
FROM
    CustomerTotalPayments
ORDER BY
    total_payment DESC;

-- 8 CTE with Window Functions:

--  a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.

WITH FilmRentalRank AS (
    SELECT
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_rank
    FROM
        film
)
SELECT
    title,
    rental_duration,
    rental_rank
FROM
    FilmRentalRank
ORDER BY
    rental_rank;
    
-- 9. CTE and Filtering:

--  a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 

--  customer table to retrieve additional customer details.

WITH CustomerRentalCounts AS (
    SELECT
        c.customer_id,
        COUNT(r.rental_id) AS rental_count
    FROM
        customer AS c
    JOIN
        rental AS r ON c.customer_id = r.customer_id
    GROUP BY
        c.customer_id
    HAVING
        COUNT(r.rental_id) > 2
)
SELECT
    cust.first_name,
    cust.last_name,
    cust.email,
    crc.rental_count
FROM
    customer AS cust
JOIN
    CustomerRentalCounts AS crc ON cust.customer_id = crc.customer_id
ORDER BY
    crc.rental_count DESC;
    
-- 10 CTE for Date Calculations:

--  a. Write a query using a CTE to find the total number of rentals made each month, considering the 

--  rental_date from the rental table

WITH CustomerRentalCounts AS (
    SELECT
        c.customer_id,
        COUNT(r.rental_id) AS rental_count
    FROM
        customer AS c
    JOIN
        rental AS r ON c.customer_id = r.customer_id
    GROUP BY
        c.customer_id
    HAVING
        COUNT(r.rental_id) > 2
)
SELECT
    cust.first_name,
    cust.last_name,
    cust.email,
    crc.rental_count
FROM
    customer AS cust
JOIN
    CustomerRentalCounts AS crc ON cust.customer_id = crc.customer_id
ORDER BY
    crc.rental_count DESC;
    
-- 11' CTE and Self-Join:

--  a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 

--  together, using the film_actor table.

WITH ActorPairs AS (
    SELECT
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        f.title AS film_title
    FROM
        film_actor AS fa1
    JOIN
        film_actor AS fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
    JOIN film f ON fa1.film_id = f.film_id
)
SELECT
    a1.first_name || ' ' || a1.last_name AS actor1_name,
    a2.first_name || ' ' || a2.last_name AS actor2_name,
    film_title
FROM
    ActorPairs
JOIN actor a1 ON ActorPairs.actor1_id = a1.actor_id
JOIN actor a2 ON ActorPairs.actor2_id = a2.actor_id
ORDER BY
    film_title, actor1_name, actor2_name;
    
-- 12. CTE for Recursive Search:

--  a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 

--  considering the reports_to column

WITH RECURSIVE EmployeeHierarchy AS (
    -- Anchor member: Select the initial manager
    SELECT staff_id, first_name, last_name, manager_id
    FROM staff
    WHERE staff_id = 2 -- Replace 2 with the desired manager's staff_id

    UNION ALL

    -- Recursive member: Find employees who report to those in the previous level
    SELECT e.staff_id, e.first_name, e.last_name, e.manager_id
    FROM staff AS e
    INNER JOIN EmployeeHierarchy AS eh ON e.manager_id = eh.staff_id
)
SELECT staff_id, first_name, last_name
FROM EmployeeHierarchy
WHERE staff_id <> 2 -- Exclude the initial manager from the final result if needed.
ORDER BY staff_id;











