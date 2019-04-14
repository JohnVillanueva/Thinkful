-- What are the three longest trips on rainy days?
WITH
	rainydays
AS (
	select * 
	from weather 
	where precipitationin > 0
	)
select *
from trips t join rainydays rd
	ON rd.date = SPLIT_PART(t.start_date,' ',1) and t.zip_code = rd.zip
ORDER BY duration DESC
LIMIT 3;

-- Which station is full most often?
select name, count(*)
from status s join stations st
	on s.station_id = st.station_id
where s.docks_available = 0
GROUP BY name
ORDER BY count DESC


-- Return a list of stations with a count of number of trips starting at that 
-- station but ordered by dock count.
WITH
totstatdocks AS (
	select name, s.station_id, max(bikes_available + docks_available) as total_docks
	from status s join stations st
		on s.station_id = st.station_id
	GROUP BY name, s.station_id
	),
tripcounttab AS (
	select start_terminal, count(*) as tripcount
	from trips
	GROUP BY start_terminal
	)
select name, tripcount, total_docks
from totstatdocks tot join tripcounttab tab
	on tot.station_id = tab.start_terminal
ORDER BY total_docks DESC


-- What's the length of the longest trip for each day it rains anywhere?
WITH
rainanywhere AS (
	select date
	from weather
	where precipitationin > 0
	group by date)
select date, max(duration)
from trips t join rainanywhere r
	ON SPLIT_PART(t.start_date,' ',1) = r.date
GROUP BY date
ORDER BY date


