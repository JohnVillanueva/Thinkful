--What was the hottest day in our data set? Where was that?
select date as hottest_day, zip, maxtemperaturef as hottest_temp
from weather
where maxtemperaturef = (select max(maxtemperaturef) from weather)

--How many trips started at each station?
select start_station, count(trip_id) as trips_started
from trips
group by start_station
order by trips_started DESC;

--What's the shortest trip that happened?
select *
from trips
where duration = (select min(duration) from trips)

--What is the average trip duration, by end station?
select end_station, avg(duration)
from trips
GROUP BY end_station