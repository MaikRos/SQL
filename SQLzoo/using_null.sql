/* 1.
List the teachers who have NULL for their department.
*/
SELECT name FROM teacher WHERE dept IS NULL;

/* 2.
Show teachers and their associated department
*/
SELECT teacher.name, dept.name AS department FROM teacher
    INNER JOIN dept ON (teacher.dept=dept.id);

/* 3.
Use a different JOIN so that all teachers are listed since the previous
join misses the teachers with no department and the departments with no teacher.
*/
SELECT teacher.name, department.name AS department FROM teacher
    LEFT JOIN dept department ON (teacher.dept=department.id);

/* 4.
Use a different JOIN so that all departments are listed.
*/
SELECT teacher.name, department.name AS department FROM teacher
    RIGHT JOIN dept department ON (teacher.dept=department.id);

/* 5.
Show teacher name and mobile number or '07986 444 2266' if none was provided
*/
SELECT name, coalesce(mobile, '07986 444 2266') AS mobile FROM teacher;

/* 6.
Use the COALESCE function and a LEFT JOIN to print the teacher name
and department name. Use the string 'None' where there is no department.
*/
SELECT teacher.name, coalesce(department.name, 'None') FROM teacher
    LEFT JOIN dept department ON (department.id=teacher.dept);

/* 7.
select count(name) as 'teachers', count(mobile) as 'mobile phones' from teacher
*/
SELECT count(name) AS 'teachers', count(mobile) AS 'mobile phones' FROM teacher;

/* 8.
Use COUNT and GROUP BY dept.name to show each department and the number of staff.
Use a RIGHT JOIN to ensure that the Engineering department is listed.
*/
SELECT department.name, count(teacher.dept) AS staff FROM teacher
    RIGHT JOIN dept department ON (teacher.dept=department.id)
GROUP BY department.name;

/* 9.
Use CASE to show the name of each teacher followed by 'Sci' if the teacher
is in dept 1 or 2 and 'Art' otherwise.
*/
SELECT teacher.name,
(CASE
    WHEN dept IN (1,2) THEN 'Sci'
  	ELSE 'Art'
   	END) AS department
FROM teacher;

/* 10.
Use CASE to show the name of each teacher followed by 'Sci' if the teacher
is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.
*/
SELECT teacher.name,
(CASE
		WHEN dept in (1,2) THEN 'Sci'
  	WHEN dept = 3 THEN 'Art'
    ELSE 'None'
   	END) AS department
FROM teacher
