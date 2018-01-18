/* 1.
Show the total population of the world.
*/
SELECT SUM(population)
FROM world;

/* 2.
List all the continents - just once each.
*/
SELECT distinct continent FROM world;

/* 3.
Give the total GDP of Africa
*/
SELECT sum(GDP) FROM world
    WHERE continent = 'Africa';

/* 4.
How many countries have an area of at least 1000000.
*/
SELECT count(name) FROM world
    WHERE area > 1000000;

/* 5.
What is the total population of ('Estonia', 'Latvia', 'Lithuania').
*/
SELECT sum(population) FROM world
    WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

/* 6.
For each continent show the continent and number of countries.
*/
SELECT continent, count(name) AS 'number of countries' FROM world
    GROUP BY continent;

/* 7.
For each continent show the continent and number of countries
with populations of at least 10 million.
*/
SELECT continent, count(name) AS 'number of countries' FROM world
    WHERE population >= 10000000
    GROUP BY continent;

/* 8.
List the continents that have a total population of at least 100 million.
*/
SELECT distinct continent FROM world w1
    WHERE (SELECT sum(population) FROM world w2
    WHERE w1.continent = w2.continent) >= 100000000