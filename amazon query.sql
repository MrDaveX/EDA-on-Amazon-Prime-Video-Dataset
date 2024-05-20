

--Hi,below are the queries used to explore and standardize
--this data set from Amazon prime for Visualization in Tableau and to avoid data redundancy.

--To show all the values in the data set
SELECT *
FROM amazon_prime

--Distinct values for all column was explored to understand each column
SELECT DISTINCT show_id
FROM amazon_prime

SELECT DISTINCT type
FROM amazon_prime

SELECT DISTINCT title
FROM amazon_prime

SELECT DISTINCT DIRECTOR
FROM amazon_prime

SELECT DISTINCT cast
FROM amazon_prime

SELECT DISTINCT country
FROM amazon_prime
--........this was done for all columns

--query to explore values in columns where errors were suspected 
SELECT *
FROM amazon_prime
WHERE director ='Óskar Thór Axelsson'

SELECT *
FROM amazon_prime
WHERE director ='Paul Weiland'

SELECT *
FROM amazon_prime
WHERE director ='20th_century_fox'

SELECT *
FROM amazon_prime
WHERE title ='Yu-Gi-Oh! 5D'

SELECT *
FROM amazon_prime
WHERE title ='World’s Toughest Race: Eco-Challenge Fiji'


--In one the director column, 20th century fox was written in two different formats,so we have to take one out.
--We update the right format we want

UPDATE amazon_prime
SET director = '20th_century_fox'
WHERE director LIKE '20th%' 

--The table was joined to itself for further exploration

SELECT ab.show_id,ab.title,ab.director
FROM amazon_prime ab
JOIN amazon_prime ba
ON ab.title = ba.title

--values inconsistent with the data set are deleted

SELECT *
FROM amazon_prime
where director = '1'

delete 
FROM amazon_prime
where director = '1'

SELECT *
FROM amazon_prime
where show_id  ='NULL'
OR DIRECTOR = 'NULL'

--Query to idntify duplicates and delete duplicates,avoiding data redundancy

WITH amazonCTE as(
SELECT *,
ROW_NUMBER () OVER (PARTITION BY 
							title,
							show_id,
							director ,
							release_year
							ORDER BY show_id) Row_num
FROM amazon_prime
)

Select *
FROM amazonCTE 
WHERE Row_num > 1

SELECT *
FROM amazon_prime
where title = 'Snow White'

--For this visualization,the column date added is considered irrelevant 

ALTER TABLE amazon_prime
DROP COLUMN date_added

--Please note that in this analysis,the null and blank values aren't removed to avoid data redundancy,and the dataset 
--resultin to a skewed moel and impairing visualization models. However, null values in the columns  will be
--filtered and avoided in relevant scenarios.

--xoxoDave