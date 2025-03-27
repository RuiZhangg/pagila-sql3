/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */

( SELECT f.title FROM film_category fc1
JOIN film_category fc2 ON fc1.category_id = fc2.category_id
JOIN film f ON fc2.film_id = f.film_id
WHERE fc1.film_id = (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
GROUP BY f.title
HAVING COUNT(DISTINCT fc2.category_id) >= 2 )
INTERSECT
( SELECT f.title FROM film_actor fa
JOIN film f ON fa.film_id = f.film_id
WHERE fa.actor_id IN (
SELECT actor_id FROM film_actor
WHERE film_id = (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
))
ORDER BY title;
