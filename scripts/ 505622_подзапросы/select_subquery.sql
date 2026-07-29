
--вывести товары, цена которых меньше средней цены всех товаров
SELECT
	p.id AS product_id,
	p.name AS product_name,
	p.price
FROM products p
WHERE p.price < (
	SELECT
		AVG(price)
	FROM products
);

--вывести пользователей, у которых есть хотя бы один заказ со статусом PAID
SELECT
	u.id AS user_id,
	u.name AS user_name,
	u.email
FROM users u
WHERE EXISTS (
	SELECT 1
	FROM orders o
	WHERE o.user_id = u.id AND o.status = 'PAID'
);

--вывести пользователей, у которых нет ни одного заказа
SELECT
	u.id AS user_id,
	u.name AS user_name,
	u.email
FROM users u
WHERE NOT EXISTS (
	SELECT 1
	FROM orders o
	WHERE o.user_id = u.id
)
ORDER BY user_id ASC ;

--вывести товары, которые хотя бы раз встречались в order_items
SELECT
	p.id AS product_id,
	p.name AS product_name,
	p.price
FROM products p
WHERE p.id IN (
	SELECT
		oi.product_id
	FROM order_items oi
	GROUP BY oi.product_id
);

--вывести заказы, сумма которых больше 10000
SELECT
	ot.order_id,
	ot.order_total
FROM (
	SELECT
		oi.order_id,
		SUM(oi.unit_price * oi.quantity) AS order_total
	FROM order_items oi
	GROUP BY oi.order_id
) AS ot
WHERE ot.order_total > 10000;

--вывести пользователей и количество их заказов через коррелированный подзапрос в SELECT
SELECT
	u.id AS user_id,
	u.name AS user_name,
	(
		SELECT
			COUNT(o.id)
		FROM orders o
		WHERE o.user_id = u.id
	) AS orders_count
FROM users u ;

--вывести товары, по которым суммарно продано больше, чем среднее количество продаж на товар
SELECT
	oi.product_id,
	SUM(oi.quantity) AS total_quantity
FROM order_items oi
GROUP BY oi.product_id
HAVING SUM(oi.quantity) > (
	SELECT
		AVG(ot.total_quantity)
	FROM (
		SELECT
			SUM(oi.quantity) AS total_quantity
		FROM order_items oi
		GROUP BY oi.product_id
	) AS ot
);

--вывести заказы, у которых сумма выше средней суммы заказа
SELECT
    t.order_id,
    t.order_total
FROM (
    SELECT
        order_id,
        SUM(quantity * unit_price) AS order_total
    FROM order_items
    GROUP BY order_id
) AS t
WHERE t.order_total > (
    SELECT AVG(order_total)
    FROM (
        SELECT
            order_id,
            SUM(quantity * unit_price) AS order_total
        FROM order_items
        GROUP BY order_id
    ) AS order_totals
);