-- Total Revenue
SELECT SUM(amount) AS total_revenue
FROM payment;

-- Monthly Revenue Trend
SELECT 
DATE_TRUNC('month', payment_date) AS month,
SUM(amount) AS revenue
FROM payment
GROUP BY month
ORDER BY month;

-- Top Customers
SELECT 
c.customer_id,
c.first_name,
c.last_name,
SUM(p.amount) AS total_spent
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 5;

-- Revenue by Store
SELECT 
s.store_id,
SUM(p.amount) AS revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id;                                                                                          

--Most Rented Movies:         
SELECT 
f.title,
COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;                                                                                    

--Most Revenue Generated Movies:         
SELECT 
f.title,
    SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY total_revenue DESC
LIMIT 10;

--Revenue by Film Category:         
SELECT 
    c.name AS category,
    SUM(p.amount) AS revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY revenue DESC
LIMIT 5; 

--Revenue by Film Category:         
SELECT 
    c.name AS category,
    SUM(p.amount) AS revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY revenue DESC
LIMIT 5; 

--Films with No rentals:         
SELECT DISTINCT 
    f.title
FROM film f
JOIN inventory i 
    ON f.film_id = i.film_id
LEFT JOIN rental r                                                                                                                               
    ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;


--Customers with High rentals:         
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 5;                                                                               

