# для каждого статуса заказа вывести количество заказов
SELECT
	o.status,
	count(o.id) AS orders_count
FROM orders o
GROUP BY o.status ;

# для каждого пользователя вывести общую сумму всех его заказов
SELECT
	u.id AS user_id,
	u.name AS user_name,
	sum(oi.unit_price * oi.quantity ) AS total_spent
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN users u ON o.user_id = u.id
GROUP BY u.name, u.id;

# для каждого товара вывести:
# сколько раз этот товар встретился в строках заказа
# сколько единиц товара было продано суммарно
SELECT
	p.id AS product_id,
	p.name AS product_name,
	count(oi.id) AS order_items_count,
	SUM(oi.unit_price * oi.quantity ) AS total_quantity
FROM order_items oi
JOIN products p ON p.id  = oi.product_id
GROUP BY p.id, p.name ;

# для каждого заказа вывести:
# order_id
# количество строк в заказе
# итоговую сумму заказа
SELECT
	o.id AS order_id,
	count(oi.id) AS items_count,
	sum(oi.unit_price * oi.quantity) AS order_total
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id;

# для каждого пользователя и для каждого статуса его заказов вывести количество таких заказов
SELECT
	u.id AS user_id,
	u.name AS user_name,
	status,
	count(o.status) AS orders_count
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name, o.status
ORDER BY user_id ASC;

# вывести минимальную, максимальную и среднюю цену продажи по каждому товару на основании order_items
SELECT
	product_id,
	p.name AS product_name,
	MIN(oi.unit_price) AS min_unit_price,
	MAX(oi.unit_price) AS max_unit_price,
	AVG(oi.unit_price) AS avg_unit_price
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY oi.product_id, p.name ;

# вывести пользователей и количество их заказов, включая пользователей, у которых заказов нет
SELECT
	u.id AS user_id,
	u.name AS user_name,
	count(o.id) AS orders_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name ;
