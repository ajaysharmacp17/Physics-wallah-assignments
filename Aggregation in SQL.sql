use world;

-- Question 1 : Count how many cities are there in each country?
-- Ans. 

select CountryCode, count(City_Name) as Total_Cities
from city
group by CountryCode;

-- Question 2 : Display all continents having more than 30 countries.
-- Ans. 

select Continent, count(Country_Name) as Countries
from Country
group by Continent
having count(country_Name) > 30 ;

-- Question 3 : List regions whose total population exceeds 200 million.
-- Ans.  

select Region, sum(Country_Pop) as Total_Population
from Country
group by Region 
having sum(Country_Pop) > 20000000;

-- Question 4 : Find the top 5 continents by average GNP per country.
-- Ans. 

select Continent, avg(GNP) as GNP
from Country
group by continent 
order by GNP desc
limit 5;

-- Question 5 : Find the total number of official languages spoken in each continent.
-- Ans. 

select C.continent, count(CL.Language) as official_languages
from country C
join countrylanguage CL
on C.country_code = CL.Country_code
where CL.IsOfficial = "T"
Group by continent;


-- Question 6 : Find the maximum and minimum GNP for each continent.
-- Ans. 

select Continent , max(GNP) as Highest_GNP , min(GNP) as Lowest_GNP 
from country
group by Continent;


-- Question 7 : Find the country with the highest average city population.
-- Ans. 

select Countrycode,  avg(City_Pop) as Highest_averge_population
from city
group by Countrycode
order by Highest_averge_population desc
limit 1;


-- Question 8 : List continents where the average city population is greater than 200,000.
-- Ans.

select Continent, avg(City_Pop) as average_city_population
from city C
join country CC
on C.CountryCode = CC.Country_Code
group by CC.Continent
having avg(C.City_Pop) > 200000;
    

-- Question 9 : Find the total population and average life expectancy for each continent, ordered by average life expectancy descending.
-- Ans.
    
 select Continent , sum(Country_Pop) as Total_Population, avg(LifeExpectancy) as Average_Life_Expectancy
 from country
 group by continent 
 order by Average_Life_Expectancy desc;
 

-- Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where the total population is over 200 million.
-- Ans. 

select Continent , avg(LifeExpectancy) as highest_average_life_expectancy
from country
group by Continent
having sum(Country_Pop) > 200000000
order by highest_average_life_expectancy desc 
limit 3;

					







