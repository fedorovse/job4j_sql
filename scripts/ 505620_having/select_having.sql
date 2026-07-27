# вывести статусы заказов, по которым количество заказов не меньше 3
SELECT
	o.status,
	COUNT(*) AS orders_count
FROM orders o
GROUP BY o.status
HAVING COUNT(*) >= 3;

#  для каждого пользователя вывести суммарную стоимость всех его заказов,
# но оставить только тех пользователей, у которых общая сумма заказов больше 10000
SELECT
	u.id AS user_id,
	u.name AS user_name,
	SUM(oi.quantity * oi.unit_price) AS total_spent
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN order_items oi ON o.id = oi.order_id
GROUP BY u.id, u.name
HAVING SUM(oi.quantity * oi.unit_price) > 10000;

# вывести товары, по которым суммарно продано от 5 единиц и больше,
# но учитывать только те строки заказа, где unit_price >= 1000
SELECT
	p.id AS product_id,
	p.name AS product_name,
	SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.id
WHERE (oi.unit_price * oi.quantity) >= 1000
GROUP BY p.id, p.name
HAVING SUM(oi.quantity) > 5;

# для каждого пользователя и каждого статуса заказа вывести количество заказов,
# но оставить только те группы, где количество заказов больше 1
SELECT
	u.id AS user_id,
	u.name AS user_name,
	o.status,
	COUNT(*) AS orders_count
FROM orders o
JOIN users u ON o.user_id = u.id
GROUP BY u.id, u.name, o.status
HAVING COUNT(*) > 1;

# вывести заказы, в которых суммарно куплено не меньше 4 единиц товара
SELECT
	oi.order_id,
	COUNT(oi.quantity) AS total_quantity
FROM order_items oi
GROUP BY oi.order_id
HAVING COUNT(oi.quantity) > 4;

# вывести пользователей, у которых есть хотя бы 2 заказа со статусом PAID
SELECT
	u.id AS user_id,
	u.name AS user_name,
	COUNT(*) AS paid_orders_count
FROM orders o
JOIN users u ON o.user_id = u.id
WHERE o.status = 'PAID'
GROUP BY u.id, u.name
HAVING COUNT(*) >= 2;

# для каждого товара вывести минимальную и максимальную цену продажи из order_items,
# но оставить только те товары, у которых максимальная цена продажи больше 5000
SELECT
	p.id AS product_id,
	p.name AS product_name,
	MIN(oi.unit_price ) AS min_unit_price,
	MAX(oi.unit_price) AS max_unit_price
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY p.id, p.name
HAVING MAX(oi.unit_price) > 5000
ORDER BY MAX(oi.unit_price) DESC ;

# вывести статусы заказов, для которых средняя сумма строки заказа больше 2000,
# но учитывать только заказы, созданные начиная с 1 января 2025 года
SELECT
	o.status,
	ROUND(AVG(oi.unit_price * oi.quantity), 2) AS avg_line_total
FROM order_items oi
JOIN orders o ON oi.order_id = o.id
WHERE o.created_at > DATE '2025-01-01'
GROUP BY o.status
HAVING AVG(oi.unit_price * oi.quantity) > 2000;