use sakila;

-- Write a query to display for each store its store ID, city, and country.

select store_id, city, country from store s
join address a on s.address_id = a.address_id
join city c on a.city_id = c.city_id
join country p on c.country_id = p.country_id;


-- Write a query to display how much business, in dollars, each store brought in.

select s.store_id, sum(amount) collected from store s
join customer c on s.store_id = c.store_id
join payment p on c.customer_id = p.customer_id
group by s.store_id;


-- What is the average running time of films by category?

select name, round(avg(length)) avg_duration from category c
join film_category p on c.category_id = p.category_id
join film f on p.film_id = f.film_id
group by c.name;


-- Which film categories are longest?

select name, round(avg(length)) avg_duration from category c
join film_category p on c.category_id = p.category_id
join film f on p.film_id = f.film_id
group by c.name order by avg(length) desc limit 5;


-- Display the most frequently rented movies in descending order.

select title, count(rental_id) times_rent from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.film_id order by times_rent desc;


-- List the top five genres in gross revenue in descending order.

select name, sum(amount) gross_revenue from category c
join film_category p on c.category_id = p.category_id
join inventory i on p.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment d on r.rental_id = d.rental_id
group by name order by gross_revenue desc limit 5;


-- Is "Academy Dinosaur" available for rent from Store 1?

select i.inventory_id, title,
case when max(return_date) > max(rental_date) then "available" else "rent" end availability 
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
where title = "ACADEMY DINOSAUR" and store_id = 1
group by inventory_id;