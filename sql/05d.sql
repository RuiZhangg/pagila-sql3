/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but the INTERSECT operator to make a convenient solution.
 */

(SELECT title FROM film
JOIN film_actor USING (film_id)
WHERE actor_id IN (
SELECT actor_id FROM film_actor
JOIN film USING (film_id)
WHERE title LIKE 'AMERICAN CIRCUS'))
INTERSECT
(SELECT title FROM film
JOIN film_actor USING (film_id)
WHERE actor_id IN (
SELECT actor_id FROM film_actor
JOIN film USING (film_id)
WHERE title LIKE 'ACADEMY DINOSAUR'))
INTERSECT
(SELECT title FROM film
JOIN film_actor USING (film_id)
WHERE actor_id IN (
SELECT actor_id FROM film_actor
JOIN film USING (film_id)
WHERE title LIKE 'AGENT TRUMAN'))
ORDER BY title;
