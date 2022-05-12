use sakila;
/* In the table actor, which are the actors whose last names are not repeated? 
For example if you would sort the data in the table actor by last_name, you would see that 
there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have 
the same last name. So we do not want to include this last name in our output. 
Last name "Astaire" is present only one time with actor "Angelina Astaire", 
hence we would want this in our output list.
*/

select * from actor;
select last_name, count(last_name) as counter from actor
group by last_name
having counter=1;

-- We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once

select last_name, count(last_name) as counter from actor
group by last_name
having counter>1;

-- Using the rental table, find out how many rentals were processed by each employee.

select staff_id, count(rental_id)as rentals from rental
group by staff_id;

-- Using the film table, find out for each rating how many films were there.

select rating, count(film_id) as counter from film
group by rating
order by counter desc;

-- Using the film table, find out how many films were released each year.

select release_year, count(film_id) as counter from film
group by release_year
order by counter desc;

-- What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

select rating, round(avg(length),2) as avg_len from film
group by rating
order by rating desc;

-- Which kind of movies (rating) have a mean duration of more than two hours?

select rating, round(avg(length),2) as avg_len from film
group by rating
having avg(length)>120
order by rating desc;

-- Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.

select title, length,
rank() over (order by length desc) as the_rank
from film
where length <> 0 or length <> null
order by length desc;

select title, length, 
	rank() OVER(order by length desc) as ranking
from film
where not isnull(length) and not (length = 0)
order by length desc;