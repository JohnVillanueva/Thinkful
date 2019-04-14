--What is the most expensive lisitng
select * from sfo_listings
where price = (select max(price) from sfo_listings)


--What neightborhoods seem to be the most popular?
Group by neighborhoods aggregated by average number of reviews for listings in each neighborhood.
select neighbourhood, avg(number_of_reviews) as avg_review_count
from sfo_listings
group by neighbourhood
order by avg_review_count DESC


--What time of year is cheapest to go to San Francisco? The primary metric will be the average
price of all available listings for a particular day.
select calender_date, avg(to_number(split_part(split_part(price,'.',1),'$',2),'99999')) as avg_listing_price
from sfo_calendar
where available = 't'
GROUP BY calender_date
ORDER BY calender_date -- also order by avg_listing_price
									
									
--When is the busiest time to go San Francisco?
WITH
tot_listings
AS (select calender_date, count(available) as tot_exists
	from sfo_calendar
	GROUP BY calender_date
	),
tot_available
AS (select calender_date, count(available) as tot_avails
   from sfo_calendar
   where available = 't'
   GROUP BY calender_date)
select ta.calender_date, cast(ta.tot_avails as decimal)/tl.tot_exists as proportion_available
from tot_listings tl join tot_available ta
	on ta.calender_date = tl.calender_date
ORDER BY proportion_available