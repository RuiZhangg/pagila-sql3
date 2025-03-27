/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */

SELECT title FROM (
SELECT title, count(actor_id) FROM film
JOIN film_actor USING (film_id)
WHERE actor_id IN (
SELECT actor_id FROM film_actor
JOIN film USING (film_id)
WHERE title LIKE 'AMERICAN CIRCUS')
GROUP BY title
HAVING count(actor_id) > 1) t
ORDER BY title;
