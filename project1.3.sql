select * from rental;
select * from staff; 
select staff_id from rental; 

-- Q1
select count(*) as sales_volumn
from rental
where substring(rental_date, 1, 10) between '2005-05-01' and '2005-08-31'; 

-- Q2
select substring(rental_date, 1, 7) as month, count(*) as sales_volumn
from rental
group by 1; 

-- Q3
select s.staff_id, s.first_name, s.last_name, count(r.rental_id) as sales_volumn
from staff as s 
left join rental as r
on s.staff_id = r.staff_id
group by 1
order by 4;

select * from inventory;

-- Q4 
select film_id, count(inventory_id) as inventory_level, store_id
from inventory
group by 1, 3;

-- Q5
select f.film_id, f.title, count(i.inventory_id) as inventory_level, store_id
from film as f 
left join inventory as i 
on f.film_id = i.film_id 
group by 1, 3;

select * from category;

-- Q6
select f.film_id, f.title, count(i.inventory_id) as inventory_level, store_id, c.name as category_name
from film as f 
left join inventory as i 
on f.film_id = i.film_id 
left join film_category as fc
on fc.film_id = i.film_id
left join category as c
on fc.category_id = c.category_id
group by 1, 2, 4, c.category_id;

-- Q7
create table inventory_rep as 
select f.film_id, f.title, count(i.inventory_id) as inventory_level, store_id, c.name as category_name
from film as f 
left join inventory as i 
on f.film_id = i.film_id 
left join film_category as fc
on fc.film_id = i.film_id
left join category as c
on fc.category_id = c.category_id
group by 1, 2, 4, c.category_id;

/*
drop table inventory_2;
create table inventory_2 as 
select f.film_id, f.title, store_id, c.name as category_name, 
sum(case when i.store_id = 1 then 1 else 0 end) as num_of_stock_in_store1,
sum(case when i.store_id = 2 then 1 else 0 end) as num_of_stock_in_store2
from film as f 
left join inventory as i 
on f.film_id = i.film_id 
left join film_category as fc
on fc.film_id = i.film_id
left join category as c
on fc.category_id = c.category_id
group by 1, 2, 3, c.category_name;
*/

select * from inventory_rep;

-- Q8 
select film_id, store_id
from inventory_rep
where inventory_level = 0;


-- Q9 
select * from payment;

select substring(payment_date,1,7) as month, sum(amount) as revenue
from payment
where substring(payment_date,1,7) between '2005-05' and '2005-08'
group by 1;

-- Q10
select s.store_id as store, sum(p.amount) as revenue
from payment as p
left join staff as s
on s.staff_id = p.staff_id
where substring(payment_date,1,7) between '2005-05' and '2005-08'
group by 1;

-- Q11
select * from payment;
select * from inventory;
select * from rental;
select * from film;

select i.film_id, ir.title, ir.category_name, count(p.rental_id) as num_of_times
from payment as p 
left join rental as r
on p.rental_id = r.rental_id
left join inventory as i 
on i.inventory_id = r.inventory_id
left join inventory_rep as ir
on ir.film_id = i.film_id
group by 1,2,3
order by 4;



