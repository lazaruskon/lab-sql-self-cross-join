-- Lab | SQL Self and cross join
use sakila;

-- In this lab, you will be using the Sakila database of movie rentals.

	-- Get all pairs of actors that worked together.
select * from film_actor;

select * from film_actor fa1
join film_actor fa2
on fa1.film_id = fa2.film_id
and fa1.actor_id <> fa2.actor_id;

    -- Get all pairs of customers that have rented the same film more than 3 times.
select * from customer;
select * from rental;
select * from inventory;

select count(distinct inventory_id) from rental;
select count(distinct rental_id) from rental; -- checking if rental_id and inventory_id are different and how

select * 
from (select inventory_id, customer_id, rental_id from rental -- group by inventory_id, rental_id -- having count(distinct inventory_id) > 3
) sub1 
cross join ( select customer_id from customer 
) sub2;

# something is missing from my first approach. So I then decided to take a different route use a self join

select title, r1.customer_id, r2.customer_id, count(distinct r1.inventory_id) as rented_movies
from inventory i
join film f
on f.film_id = i.film_id
join
rental r1
on r1.inventory_id = i.inventory_id
join
rental r2
on r1.inventory_id = r2.inventory_id and r1.customer_id < r2.customer_id
group by r1.customer_id , r2.customer_id
having rented_movies > 3;

    -- Get all possible pairs of actors and films.
select * from film;
select * from film_actor;
select * from actor;
    
select * from (select distinct first_name, last_name from actor
) sub1 
cross join (select distinct film_id from film_actor
) sub2;
