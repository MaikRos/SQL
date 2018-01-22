/* 1.
List the films where the yr is 1962 [Show id, title]
*/
SELECT id, title
 FROM movie
 WHERE yr = 1962;

/* 2.
Give year of 'Citizen Kane'.
*/
SELECT yr FROM movie
    WHERE title = 'Citizen Kane';

/* 3.
List all of the Star Trek movies, include the id, title and yr (all of
these movies include the words Star Trek in the title). Order results by year.
*/
SELECT id, title, yr FROM movie
    WHERE title LIKE '%Star Trek%'
ORDER BY yr;

/* 4.
What id number does the actor 'Glenn Close' have?
*/
SELECT id from actor
    WHERE name = 'Glenn Close';

/* 5.
What is the id of the film 'Casablanca'
*/
SELECT id FROM movie
    WHERE title = 'Casablanca';

/* 6.
Obtain the cast list for 'Casablanca'
use previously obtained movieid
*/
SELECT name from actor ac
 INNER JOIN casting cast ON (actorid=id)
 WHERE movieid = 11768;

/* 7.
Obtain the cast list for the film 'Alien'
*/
SELECT name from actor ac
 INNER JOIN casting cast ON (actorid=id)
 WHERE movieid = (SELECT id FROM movie
    WHERE title = 'Alien');

/* 8.
List the films in which 'Harrison Ford' has appeared
*/
SELECT title from movie
    INNER JOIN casting ON (id=movieid)
    WHERE actorid = (SELECT id from actor WHERE name = 'Harrison Ford');

/* 9.
List the films where 'Harrison Ford' has appeared - but not in the starring role. [
Note: the ord field of casting gives the position of the actor.
If ord=1 then this actor is in the starring role]
*/
SELECT title from movie
    INNER JOIN casting ON (id=movieid)
    WHERE actorid = (SELECT id from actor WHERE name = 'Harrison Ford')
    AND ord != 1;

/* 10.
List the films together with the leading star for all 1962 films.
*/
SELECT title, ac.name FROM movie mov
    INNER JOIN casting cast ON (id=movieid)
    INNER JOIN actor ac ON (cast.actorid=ac.id)
    WHERE yr = 1962
    AND ord = 1;

/* 11.
Which were the busiest years for 'John Travolta', show the year and the number
of movies he made each year for any year in which he made more than 2 movies.
*/
SELECT yr, COUNT(title) FROM movie
        INNER JOIN casting ON movie.id=movieid
        INNER JOIN actor   ON actorid=actor.id
        where name='John Travolta'
GROUP BY yr
HAVING COUNT(title) =
    (SELECT MAX(c) FROM
        (SELECT yr,COUNT(title) AS c FROM movie
            INNER JOIN casting ON (movie.id=movieid)
            INNER JOIN actor ON (actorid=actor.id)
            where name='John Travolta'
            GROUP BY yr)
    AS t);

/* 12.
List the film title and the leading actor for all of the films 'Julie Andrews'
played in.
*/
-- her id is 179
SELECT title, name FROM movie
  INNER JOIN casting ON (movieid=movie.id AND ord=1)
  INNER JOIN actor ON (actorid=actor.id)
  WHERE movie.id IN (SELECT movieid FROM casting WHERE actorid = 179);

/* 13.
Obtain a list, in alphabetical order,
of actors who've had at least 30 starring roles.
*/
SELECT name from actor
inner join casting on (actorid=id AND
    (SELECT count(ord) from casting WHERE actorid=id AND ord=1) >=30)
group by name;

/* 14.
List the films released in the year 1978 ordered by the number of actors
in the cast, then by title.
*/
SELECT title, count(actorid) AS cnt from casting
INNER JOIN movie ON (movieid=id)
WHERE yr = 1978
group by title
order by cnt DESC, title;

/* 15.
List all the people who have worked with 'Art Garfunkel'.
*/
-- his id is 1112
SELECT DISTINCT name from actor
    inner join casting ON (actorid=actor.id)
    where movieid IN (select movieid from casting where actorid = 1112)
    AND name != 'Art Garfunkel';
