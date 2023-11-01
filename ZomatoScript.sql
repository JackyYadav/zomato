create database zomatocase;
use zomatocase;

select * from zomato ;

select min(rating) minimum , avg(rating) avrg , max(rating) maxm
from zomato;

-- 1) Help Zomato in identifying the cities with poor Restaurant ratings

select city, avg(rating) as average_rating
from zomato
group by city
having average_rating <2.89;


#2) Mr.roy is looking for a restaurant in kolkata which provides online 
#delivery. Help him choose the best restaurant


select restaurantid,rating
from zomato
where city ="kolkata" and Has_Online_delivery ="yes"
order by rating desc limit 1;


#3) Help Peter in finding the best rated Restraunt for Pizza in New Delhi.

select restaurantid
from zomato
where city="new delhi" and cuisines like "%pizza%"
order by rating desc limit 1;


#4)Enlist most affordable and highly rated restaurants city wise.

select city , avg(average_cost_for_two) as average_price
from zomato
group by city;

-- creating a view

create view average_cost as
select city , avg(average_cost_for_two) as average_price
from zomato
group by city;



select RestaurantID, z.City, Average_Cost_for_two,rating
from zomato z inner join average_cost ac on z.city=ac.city
where average_cost_for_two < average_price and rating>4.8
order by z.city desc,rating desc, Average_Cost_for_two asc;



#5)Help Zomato in identifying the restaurants with poor offline services

select RestaurantID,city,Has_Online_delivery,Has_Table_booking,rating
from zomato
where Has_Table_booking = "yes" and Rating between 1 and 2
and Has_Online_delivery="no";

#6)Help zomato in identifying those cities which have atleast 3 restaurants with
#ratings >= 4.9In case there are two cities with the same result,
#sort them in alphabetical order.

SELECT city, count(*) as no_of_ratings
FROM zomato
WHERE rating >= 4.9
GROUP BY city
having count(*) >=3
ORDER BY no_of_ratings DESC, city ASC;



#7) What are the top 5 countries with most restaurants linked with Zomato?
select c.Country, count(*) as TotalRestaurants
from zomato z INNER JOIN CountryTable c ON z.countrycode = C.CountryCode
group by country
order by TotalRestaurants desc
limit 5;


#8) What is the average cost for two across all Zomato listed restaurants? 


select Average_Cost_for_two, count(*) as count
from zomato
group by Average_Cost_for_two;



/*9) Group the restaurants basis the average cost for two into: 
Luxurious Expensive, Very Expensive, Expensive, High, Medium High, Average. 
Then, find the number of restaurants in each category. */

Select case
        When Average_Cost_for_two > 20000 then "Luxurious Fooding"
        When Average_Cost_for_two between 15000 and 19999 then "Ultra Expensive"
        When Average_Cost_for_two between 10000 and 14999 then "Very Expensive"
        When Average_Cost_for_two between 5000 and 9999 then "Expensive"
        When Average_Cost_for_two between 3000 and 4999 then "High"
        When Average_Cost_for_two between 1500 and 2999 then "Medium high"
        Else "Average"
        End as Price_Category, Count(*) as Cnt
From zomato
Group by price_category
Order by 2;


#10) List the two top 5 restaurants with highest rating with maximum votes. 

Select Res_identify, votes, rating
from zomato
order by votes desc, rating desc
limit 5;


