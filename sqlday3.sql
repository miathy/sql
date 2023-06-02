-- 1/ Get the Top 3 film that have the most CUSTOMERS book
select screening.film_id , count(customer_id) as customer_count 
from screening join booking  on screening.id = booking.screening_id
group by film_id 
order by customer_count desc
limit 3;

-- 2/ Get all the films that longer than average length
select film.*
from film 
where film.length_min > (select avg(length_min) from film);

-- 3/ Get the room which have the highest and lowest screenings IN 1 SQL query
select room_id, count
from (select count(id) as count, room_id
from screening
group by room_id) as t
having count = (select max(count)
						from  (select count(id) as count, room_id
								from screening
								group by room_id) as k)
		or count = (select min(count)
						from  (select count(id) as count, room_id
								from screening
								group by room_id) as k)
order by count
;

-- 4/ Get number of booking customers of each room of film ‘Tom&Jerry’
select room_id, count(customer_id)
from screening join booking on screening.id = booking.screening_id
				join film on film.id = screening.film_id
where film.name ='Tom&Jerry'
group by room_id
;

-- 5/ What seat is being book the most ?

select seat_id, max(count) as total
from ( select seat_id, count(id) as count from reserved_seat
		group by seat_id) as t ;

-- 6/ What film have the most screens in 2022?
select film_id, count
from (select film_id, count(*) as count
			from screening 
			where start_time between '2022-01-01 00:00:00' and '2022-12-30 00:00:00'
			group by film_id) as t
having count = (select max(count) from (select film_id, count(*) as count
							from screening 
							where start_time between '2022-01-01 00:00:00' and '2022-12-30 00:00:00'
							group by film_id) as t);
;
select film_id, count(*) as count
			from screening 
			where start_time between '2022-01-01 00:00:00' and '2022-12-30 00:00:00'
			group by film_id ;
-- 7/ Which day has most screen?

select start_time, count
from (select start_time, count(id) as count
			from screening
			group by date(start_time)) as t
having count = (select max(count) from (select start_time, count(id) as count
			from screening
			group by date(start_time)) as t);
;
-- 8/ Show film on 2022- MAy
select id, start_time
from screening
where extract( year from start_time)  =2022
and extract(month from start_time) = 05;
	
-- 9/ Select film end with character "n"
select name
from film
where name like '%n';

-- 10/ Show customer name but just show first 3 characters AND last 3 characters in UPPERCASE
select upper(substring(first_name, 1,3)) as firstName,   upper(substring(last_name, 1,3)) as lastName 
from customer;
-- 11/ WHAT film long than 2 hours?
select name, length_min
from film
where length_min >120;