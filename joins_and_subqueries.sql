--1. List all customers who live in Texas
SELECT first_name, last_name, district
FROM customer AS cu
JOIN address AS a
ON cu.address_id = a.address_id
WHERE district = 'Texas';
--Five customers live in Texas

--2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, amount
FROM payment AS p
JOIN customer AS cu
ON cu.customer_id = p.customer_id  
WHERE amount > 6.99;
--There are 1406 payments > 6.99

--3. Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name
FROM customer 
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id 
	HAVING sum(amount) > 175
);
--Six customers have made payments over $175

--4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name, country 
FROM customer AS cu
JOIN address AS a
ON cu.address_id = a.address_id 
JOIN city AS ci
ON a.city_id = ci.city_id 
JOIN country AS co
ON co.country_id = ci.city_id
WHERE country = 'Nepal';
--One customer, Nicholas Barfield, lives in Nepal

--5. Which staff member had the most transactions?
SELECT first_name, last_name
FROM staff 
WHERE staff_id IN(
	SELECT staff_id
	FROM payment 
	GROUP BY staff_id
	ORDER BY count(staff_id)
);
--Mike Hillyer had the most transactions

--6. How many movies of each rating are there? 
SELECT rating, count(rating) 
FROM film
GROUP BY rating 
ORDER BY count(rating);
-- G: 178 | PG: 194 | PG-13: 223 | R: 195 | NC-17: 210

--7. Show all customers who have made a single paymennt above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer 
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment 
	WHERE amount > 6.99
);
--There are 539 customers with payment above $6.99

--8. How many free rentals did our stores give away?
SELECT count(amount) 
FROM payment 
GROUP BY amount
HAVING amount = 0;
--24 free rentals
