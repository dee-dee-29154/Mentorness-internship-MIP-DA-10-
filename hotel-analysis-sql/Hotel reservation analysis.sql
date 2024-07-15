1.
SELECT COUNT("Booking_id") as Total_reservation from HotelReservationDataset;

2.
SELECT "type_of_meal_plan",COUNT("type_of_meal_plan") AS TOT_COUNT
FROM HotelReservationDataset
GROUP BY "type_of_meal_plan"
ORDER BY TOT_COUNT DESC;

3.
--WITH CHILDREN_ROOM_AVG 
--AS(
SELECT round (avg("avg_price_per_room")) AS AVERAGE_PRICE_PER_ROOM--round(SUM("avg_price_per_room")/SUM ("no_of_children")) AS AVERAGE_PRICE_PER_ROOM
,SUM ("no_of_children") AS TOT_CHILDREN
FROM HotelReservationDataset
WHERE "no_of_children" != 0 AND "booking_status" LIKE 'Not_Canc%';
  -- )
 -- SELECT AVG(AVERAGE_PRICE_PER_ROOM,TOT_CHILDREN) AS AVER
 -- FROM CHILDREN_ROOM_AVG
  
4.
SELECT count("Booking_id") as tot_count, extract (year from (to_date("arrival_date", 'DD-MM-YYYY'))) as arrival_year
FROM HotelReservationDataset
group by  extract (year from (to_date("arrival_date", 'DD-MM-YYYY')))
order by arrival_year;

5.
-- coomon choice
SELECT "room_type_reserved", count(*) AS tot_booking
FROM (
    SELECT "room_type_reserved" 
    FROM HotelReservationDataset ) 
   GROUP BY "room_type_reserved"
ORDER BY tot_booking DESC;
--FETCH FIRST 1 ROW ONLY;

6.
select count("Booking_id") as tot_weekend_booking
from HotelReservationDataset
where "no_of_weekend_nights" > 0;

7.
select max(to_number("lead_time")) as highest_lead , min (to_number("lead_time")) as lowest_lead
from HotelReservationDataset;

8.
-- coomon choice
SELECT "market_segment_type", count(*) AS tot_booking
FROM (
    SELECT "market_segment_type" 
    FROM HotelReservationDataset ) 
   GROUP BY "market_segment_type"
ORDER BY tot_booking DESC
FETCH FIRST 1 ROWS ONLY;

9.
select count("Booking_id") as tot_confirmed
from hotelreservationdataset
where "booking_status" like 'Not_Can%';

10.
select sum("no_of_adults") as tot_adults , sum("no_of_children") as tot_children 
from hotelreservationdataset;

11.
SELECT round(avg("no_of_weekend_nights") ) AS AVERAGE_weekend_night 
--round(SUM("no_of_weekend_nights")/SUM ("no_of_children")) AS AVERAGE_weekend_night
,SUM ("no_of_children") AS TOT_CHILDREN
FROM HotelReservationDataset
WHERE "no_of_children" != 0 --AND "booking_status" LIKE 'Not_Canc%' 
and "no_of_weekend_nights" > 0;

12.

/*
SELECT EXTRACT(MONTH FROM (to_date("arrival_date",'DD-MM-YYYY'))) AS each_month,
       COUNT(*) AS reservations_count
FROM HotelReservationDataset
GROUP BY EXTRACT(MONTH FROM (to_date("arrival_date",'DD-MM-YYYY')))
ORDER BY each_month;
*/

SELECT 
EXTRACT(YEAR FROM (to_date("arrival_date",'DD-MM-YYYY'))) AS EACH_YEAR,
to_CHAR((to_date("arrival_date",'DD-MM-YYYY')),'MONTH') AS each_month,
       COUNT(*) AS reservations_count
FROM HotelReservationDataset
GROUP BY
EXTRACT(YEAR FROM (to_date("arrival_date",'DD-MM-YYYY'))),
to_CHAR((to_date("arrival_date",'DD-MM-YYYY')),'MONTH')
ORDER BY 
EACH_YEAR,
to_date(each_month,'MM') ;
  
13.
SELECT
    AVG(sum_weekend_nights + sum_week_nights) AS no_of_nights,
    "room_type_reserved" AS room_type
FROM (

    SELECT
        SUM(TO_NUMBER("no_of_weekend_nights")) AS sum_weekend_nights,
        SUM(TO_NUMBER("no_of_week_nights")) AS sum_week_nights,
        "room_type_reserved"
    FROM
        HotelReservationDataset
    GROUP BY
        "room_type_reserved"
)
GROUP BY
    "room_type_reserved";
/*
SELECT
AVG(sum ( SUM ( TO_NUMBER ("no_of_weekend_nights")) , sum(to_number("no_of_week_nights")))) as no_of_nights,
"room_type_reserved" as room_type
from HotelReservationDataset
group by "room_type_reserved";
*/

14.
--common choice
SELECT "room_type_reserved", round(avg("avg_price_per_room"))AS avg_price
from HotelReservationDataset
where "no_of_children" >0
/*FROM (
    SELECT "room_type_reserved" 
    FROM HotelReservationDataset ) */
   GROUP BY "room_type_reserved"
ORDER BY avg_price DESC
FETCH FIRST 1 ROWS ONLY;

15.
SELECT "market_segment_type", round(avg("avg_price_per_room"))AS avg_price
from HotelReservationDataset
   GROUP BY "market_segment_type"
ORDER BY avg_price DESC
FETCH FIRST 1 ROWS ONLY;
