/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

WITH category_film_rental_count AS (
  SELECT name, title, COUNT(rental_id) AS rental_count
  FROM category
  JOIN film_category fc USING (category_id)
  JOIN film USING (film_id)
  JOIN inventory USING (film_id)
  JOIN rental USING (inventory_id)
  GROUP BY name, title
)
SELECT name, title, rental_count AS "total rentals"
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY name ORDER BY rental_count DESC, title DESC) AS film_rank
  FROM category_film_rental_count
) ranked
WHERE film_rank <= 5
ORDER BY name, rental_count DESC, title;

