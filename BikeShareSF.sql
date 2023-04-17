/* BIKE SHARE SF */

/* SQL project for analysing bike share trips in San Francisco from 2013 to 2018.
Data is available on BigQuery */

/* Finding period of the data set */

SELECT
MIN (start_date) AS oldest_record,
MAX (start_date) AS newest_record
FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`

/* Identifying the stations in which most trips start at */

SELECT start_station_name, COUNT(*) AS trips_per_station
FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
GROUP BY start_station_name
ORDER BY  trips_per_station DESC

/* Identifying the stations in which most trips end at */

SELECT end_station_name, COUNT(*) AS end_per_station
FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
GROUP BY end_station_name
ORDER BY  end_per_station DESC

/* Identifying the general average duration of trips */

SELECT AVG (duration_sec), 
FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips` 

/* Identifying the average duration of trips by subscription type */

SELECT AVG(duration_sec), c_subscription_type,
FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips` 
GROUP BY c_subscription_type

/* Identifying the number of trips per subscription type */

SELECT DISTINCT c_subscription_type, COUNT (*) AS trips 
FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
GROUP BY c_subscription_type

/* Identifying the number of trips per year and per month */

SELECT 
TIMESTAMP_TRUNC(start_date, month) AS dates, count(*) AS trips, 
FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips` 
GROUP BY dates
ORDER BY dates DESC

/* Identifying the number of trips per year and per month by subscriber type */

SELECT 
TIMESTAMP_TRUNC(start_date, month) AS dates,
SUM (CASE WHEN c_subscription_type = 'Subscriber' THEN 1 ELSE 0 END) AS subscribers,
SUM (CASE WHEN c_subscription_type = 'Customer' THEN 1 ELSE 0 END) AS customers,
FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
GROUP BY dates 
ORDER BY dates ASC

