# Выведите имена клиентов и суммарную выручку, которую они принесли.
# Учтите только успешные заказы. Отсортируйте результат по убыванию выручки и оставьте только двух самых прибыльных клиентов
SELECT
	o.customer_name,
	SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN products p ON oi.product_id  = p.product_id
WHERE o.status = 'completed'
GROUP BY o.customer_name
ORDER BY total_revenue DESC
LIMIT 2;

# Посчитайте общее количество проданных товаров и суммарную выручку для каждой категории (только успешные заказы).
# Выведите только те категории, суммарная выручка которых превышает 30 000 рублей.
SELECT
	p.category,
	COUNT(oi.quantity) AS total_items_sold,
	SUM(oi.quantity * p.price) AS category_revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN products p ON oi.product_id  = p.product_id
WHERE o.status = 'completed'
GROUP BY p.category
HAVING SUM(oi.quantity * p.price) > 30000;

# какое среднее количество товарных позиций (штук) находится в одном успешном заказе?
WITH ProdCounts AS (
SELECT
	COUNT(DISTINCT p.product_id ) AS count_prod_in_order
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN products p ON oi.product_id  = p.product_id
WHERE o.status = 'completed'
GROUP BY o.order_id
)

SELECT
	AVG(count_prod_in_order) AS avg_items_per_order
FROM ProdCounts;
