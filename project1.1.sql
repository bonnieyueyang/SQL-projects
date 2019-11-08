select * from sakila.actor limit 5;
select * from sakila.film limit 5;
select * from sakila.language limit 5;
select * from sakila.film_category limit 5; 

select max(rental_rate) from film;

select rating, count(distinct film_id) 
from film
group by 1; 

select
case when length < 60 then 'short'
when length < 120 then 'standard'
when length >= 120 then 'long'
else 'invalid' end as film_length, 
count(distinct film_id) as cnt
from film
group by 1; 

select actor_id from actor 
where last_name = 'Johansson';

select count(distinct last_name) as cnt 
from actor;

select last_name 
from actor 
group by last_name
having count(last_name) = 1; 

select last_name 
from actor
group by last_name
having count(last_name) > 1;

select film_id, count(actor_id)
-- count(distint actor_id) as num_of_actor 
from film_actor
group by 1
order by 2 desc; 

select actor_id, count(film_id)
from film_actor
group by 1; 





