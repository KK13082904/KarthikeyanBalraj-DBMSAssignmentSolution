create database travelonthego;

use travelonthego;

--1.You are required to create two tables PASSENGER and PRICE with the following attributes and properties 
CREATE TABLE passenger (
    passenger_name VARCHAR(50),
    category VARCHAR(50),
    gender VARCHAR(1),
    boarding_city VARCHAR(50),
    destination_city VARCHAR(50),
    distance INT,
    bus_type VARCHAR(50)
);

CREATE TABLE price (
    bus_type VARCHAR(50),
    distance INT,
    price INT
);

--2.Insert the following data in the tables
INSERT INTO passenger
	(passenger_name,category,gender,boarding_city,destination_city,distance,bus_type) 
VALUES
	('sejal','ac','f','bengaluru','chennai',350,'sleeper'),
	('anmol','non-ac','m','mumbai','hyderabad',700,'sitting'),
	('pallavi','ac','f','panaji','bengaluru',600,'sleeper'),
	('khusboo','ac','f','chennai','mumbai',1500,'sleeper'),
	('udit','non-ac','m','trivandrum','panaji',1000,'sleeper'),
	('ankur','ac','m','nagpur','hyderabad',500,'sitting'),
	('hemant','non-ac','m','panaji','mumbai',700,'sleeper'),
	('manish','non-ac','m','hyderabad','bengaluru',500,'sitting'),
	('piyush','ac','m','pune','nagpur',700,'sitting');


INSERT INTO price 
	(Bus_Type,Distance,Price)
VALUES
	('Sleeper',350,770),
	('Sleeper',500,1100),
	('Sleeper',600,1320),
	('Sleeper',700,1540),
	('Sleeper',1000,2200),
	('Sleeper',1200,2640),
	('Sleeper',1500,2700),
	('Sitting',500,620),
	('Sitting',600,744),
	('Sitting',700,868),
	('Sitting',1000,1240),
	('Sitting',1200,1488),
	('Sitting',1500,1860);
	
--3.How many females and how many male passengers travelled for a minimum distance of 600 KM s?	
SELECT 
    gender, COUNT(*)
FROM
    passenger
WHERE
    distance >= 600
GROUP BY gender;


--4.Find the minimum ticket price for Sleeper Bus
SELECT 
    MIN(price) min_ticket_price, bus_type
FROM
    price
WHERE
    bus_type = 'Sleeper';

--5.Select passenger names whose names start with character 'S'
SELECT 
    *
FROM
    passenger
WHERE
    passenger_name LIKE 'S%';

--6.Calculate price charged for each passenger displaying Passenger name, Boarding City,Destination City, Bus_Type, Price in the output
SELECT 
    p.passenger_name,
    p.boarding_city,
    p.destination_city,
    p.bus_type,
    c.price
FROM
    passenger p
        INNER JOIN
    price c ON p.bus_type = c.bus_type
        AND p.distance = c.distance
ORDER BY passenger_name;

--7.What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM s
SELECT 
    p.passenger_name, c.price
FROM
    passenger p
        INNER JOIN
    price c ON p.bus_type = c.bus_type
        AND p.distance = c.distance
WHERE
    p.distance = 1000
        AND p.bus_type = 'Sitting';

--8.What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
SELECT 
    c.bus_type, c.distance, c.price
FROM
    price c,
    passenger p
WHERE
    p.passenger_name = 'Pallavi'
        AND c.distance = p.distance;

--9.List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order
SELECT DISTINCT
    distance
FROM
    passenger
ORDER BY 1 DESC;

--10.Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables
SELECT 
    passenger_name,
    distance * 100 / (SELECT 
            COUNT(distance)
        FROM
            passenger) AS percentage
FROM
    passenger
GROUP BY passenger_name;


--11.Display the distance, price in three categories in table Price
--a) Expensive if the cost is more than 1000
--b) Average Cost if the cost is less than 1000 and greater than 500
--c) Cheap otherwise
SELECT 
    distance,
    price,
    CASE
        WHEN price > 1000 THEN 'Expensive'
        WHEN price < 1000 OR price > 500 THEN 'Average Cost'
        ELSE 'Cheap'
    END AS Type
FROM
    price;
