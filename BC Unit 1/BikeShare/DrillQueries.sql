select trip_id, duration
from trips
where duration > 500
order by duration DESC;

select *
from stations
where station_id = 84;

select mintemperaturef
from weather
where precipitationin != 0 and zip = 94301;