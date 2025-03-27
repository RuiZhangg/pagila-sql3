/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

SELECT customer_id, first_name, last_name
FROM customer
JOIN LATERAL (
  SELECT COUNT(*) AS action_count
  FROM (
    SELECT rental_date, film_id FROM rental
    JOIN inventory USING (inventory_id)
    JOIN film USING (film_id)
    WHERE rental.customer_id = customer.customer_id
    ORDER BY rental_date DESC
    LIMIT 5
  ) recent
  WHERE EXISTS (
    SELECT 1 FROM film_category
    JOIN category USING (category_id)
    WHERE film_category.film_id = recent.film_id
      AND category.name = 'Action'
  )
) act ON true
WHERE act.action_count >= 4
ORDER BY customer_id;
