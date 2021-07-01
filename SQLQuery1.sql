--Select all products with brand “Cacti Plus”
SELECT * FROM product
where brand = 'cacti plus'

--Count of total products with product category=”Skin Care”
SELECT COUNT (*) FROM product
where category ='Skin Care'

--Count of total products with MRP more than 100
SELECT COUNT (*) FROM product
where mrp >100

--Count of total products with product category=”Skin Care” and MRP more than 100
SELECT COUNT (*) FROM product
where category= 'Skin Care' AND mrp > 100

--Brandwise product count
SELECT product.brand, count (product.product_id) FROM product	
group by brand

--Brandwise as well as Active/Inactive Status wise product count
SELECT product.brand,
	sum(case when active = 'Y' then 1 else 0 end) as active,
	sum(case when active = 'N' then 1 else 0 end) as inactive,
	COUNT(*) AS totals
from product
group by brand

--Display all columns with Product category in Skin Care or Hair Care
SELECT * FROM product
WHERE mrp>100 AND (category='Skin Care' OR category='Hair Care');

--Display   all   columns   with   Product   category=”Skin   Care”   and
--Brand=”Pondy”, and MRP more than 100
SELECT * FROM product
WHERE mrp>100 AND (category='Skin Care' AND brand='Pondy');

--Display   all   columns   with   Product   category   =”Skin   Care”   or
--Brand=”Pondy”, and more than 100
SELECT * FROM product
WHERE mrp>100 AND (category='Skin Care' OR brand='Pondy');

--Display all product names only with names starting from letter P
SELECT product_name FROM product WHERE product_name LIKE 'P%'

--Display  all product  names only with names Having letters “Bar”  in Between
SELECT product_name FROM product WHERE product_name LIKE '%Bar%'

--SELECT * from product

--Sales of those products which have been sold in more than two quantity in a bill
SELECT * FROM sales 
WHERE qty > 2

--Sales of those products which have been sold in more than two quantity throughout the bill
SELECT product_id, SUM(qty)  FROM sales GROUP BY product_id HAVING SUM (qty) > 2



/*
Create a new table with columns username and birthday, and dump data from dates file. Convert it to .csv format if required.
Research on Date Function Queries from the slide
After populating the data, find no of people sharing
Birth date
Birth month
Weekday
Find the current age of all people
*/
CREATE TABLE Person (
 name  VARCHAR(20),
 birthdate  Date
)

BULK INSERT dbo.Person
FROM 'B:\QA Internship Programe\SQL data\dates.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR ='\n'
)

SELECT COUNT(name) 
FROM Person 
WHERE birthdate 
    IN (
     SELECT birthdate
     FROM person
     GROUP BY birthdate
     HAVING COUNT(birthdate) > 1
    )

SELECT birthdate,
       MONTH(birthdate) birthmonth
FROM Person

SELECT COUNT(name) ,
    DATENAME(weekday, GETDATE()) as WEEKDAY
FROM Person

SELECT *, DATEDIFF(year, birthdate, GETDATE()) Age
FROM Person