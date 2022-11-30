USE sakila;

-- 1 Select all the actors with the first name ‘Scarlett’.
SELECT * FROM sakila.actor;
SELECT * FROM actor
WHERE first_name = 'Scarlett';

-- 2 How many films (movies) are available for rent and how many films have been rented?
SELECT * FROM sakila.rental;

SELECT 
(select count(*) from rental
where date(return_date) >= date(rental_date)) as "available",
(select count(*) from rental
where return_date is null)as "rented";
# we asssume that if return_date is null, that means it is still rented.


-- 3 What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT max(length) AS 'max_duration', min(length) AS 'min_duration' 
FROM film;

-- 4 What's the average movie duration expressed in format (hours, minutes)?
SELECT avg(length) FROM film;
SELECT SEC_TO_TIME(round(avg(length*60),0)) AS "average" FROM film;

-- 5 How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name) AS distinct_surnames FROM actor;

-- 6 Since how many days has the company been operating (check DATEDIFF() function)?
SELECT MAX(last_update)FROM rental; 
-- the last update was on 23-02-2006
SELECT DATEDIFF("2006-02-23", MIN(rental_date)) FROM rental;


-- 7 Show rental info with additional columns month and weekday. Get 20 results.
SELECT *, MONTHNAME(rental_date) AS month, DAYNAME(rental_date) AS weekday 
FROM rental 
LIMIT 20;


-- 8 Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *, MONTHNAME(rental_date) AS month, 
DAYNAME(rental_date) AS weekday,
CASE
WHEN dayname(rental_date)
IN ('Saturday', 'Sunday')
THEN 'Weekend' 
ELSE 'Weekday'
END
AS day_type FROM rental;

-- 9 Get release years.
SELECT distinct release_year FROM film;

-- 10 Get all films with ARMAGEDDON in the title.
SELECT * FROM film 
WHERE title like '%ARMAGEDDON%';

-- 11 Get all films which title ends with APOLLO.
SELECT * FROM film 
WHERE title like '%APOLLO%';


-- 12 Get 10 the longest films.
SELECT * FROM film;
SELECT title FROM film 
ORDER BY length 
DESC LIMIT 10;

-- 13 How many films include Behind the Scenes content?
SELECT COUNT(title) FROM film 
WHERE special_features LIKE '%Behind the Scenes%';