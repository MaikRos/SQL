/* 1.
List each country name WHERE the population is larger than that of 'Russia'.
*/
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');

/* 2.
Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
*/
Select name FROM world
WHERE gdp/population >
    (SELECT gdp/population FROM world WHERE name = 'United Kingdom')
    AND continent = 'Europe';

/* 3.
List the name and continent of countries in the continents containing
either Argentina or Australia. Order by name of the country.
*/
SELECT name, continent FROM world
    WHERE continent = (SELECT continent FROM world WHERE name = 'Argentina')
    OR
    continent = (SELECT continent FROM world WHERE name = 'Australia')
    ORDER BY name;

/* 4.
Which country has a population that is more than Canada but less than Poland?
Show the name and the population.
*/
SELECT name, population FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND
population < (SELECT population FROM world WHERE name = 'Poland');

/* 5.
Show the name and the population of each country in Europe.
Show the population as a percentage of the population of Germany.
*/
SELECT name,
concat(round(population*100/
    (SELECT population FROM world WHERE name = 'Germany')), '%') AS population
    FROM world
    WHERE continent = 'Europe';

/* 6.
Which countries have a GDP greater than every country in Europe?
[Give the name only.] (Some countries may have NULL gdp values)
*/
SELECT name FROM world
    WHERE gdp >
    (SELECT max(gdp) FROM world WHERE continent = 'Europe');

/* 7.
Find the largest country (by area) in each continent, show the continent,
the name and the area
*/
SELECT continent, name, area FROM world w1
  WHERE area >= ALL
    (SELECT area FROM world w2
        WHERE w1.continent = w2.continent
     AND area > 0);

/* 8.
List each continent and the name of the country that comes first alphabetically.
*/
SELECT continent, name FROM world w1
WHERE name <= ALL (SELECT name FROM world w2 WHERE w1.continent = w2.continent);

/* 9.
Find the continents WHERE all countries have a population <= 25000000.
Then find the names of the countries associated with these continents.
Show name, continent and population.
*/
SELECT name, continent, population FROM world w1
    WHERE 25000000 >
    ALL (SELECT population FROM world w2 WHERE w1.continent = w2.continent);

/* 10.
Some countries have populations more than three times
that of any of their neighbours (in the same continent).
Give the countries and continents.
*/
SELECT name, continent FROM world x
    WHERE population >
    all (SELECT population*3 FROM world y
        WHERE x.continent=y.continent AND y.name != x.name)  
