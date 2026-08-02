--используя CTE, вычислите общую стоимость каждого заказа
WITH oi_price AS (
	SELECT
		oi.order_id,
		oi.product_id ,
		(oi.quantity * oi.unit_price) AS oi_total_price
	FROM order_items oi
)

SELECT
	o.id AS order_id,
	SUM(op.oi_total_price) AS total_amount
FROM orders o
JOIN oi_price op ON o.id = op.order_id
GROUP BY o.id
ORDER BY o.id ;

--используя несколько CTE, найдите пользователей, общая сумма оплаченных заказов
--которых выше средней суммы оплаченных заказов по всем пользователям
WITH total_prices AS (
	SELECT
		oi.id,
		oi.order_id,
		(oi.quantity * oi.unit_price) AS total_price
	FROM order_items oi
	LEFT JOIN orders o ON o.id = oi.order_id
	WHERE o.status = 'PAID'
),

avg_price AS (
	SELECT
		AVG(total_price) AS avg_paid_price
	FROM total_prices
),

user_totals AS (
SELECT
	u.id  AS user_id,
	u.name AS user_name,
	SUM(total_price) AS total_amount
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN total_prices tp ON o.id = tp.order_id
GROUP BY u.id, u.name
)

SELECT
    ut.user_id,
    ut.user_name,
    ut.total_amount
FROM user_totals ut
CROSS JOIN avg_price ap
WHERE ut.total_amount > ap.avg_paid_price;

-- используя CTE, определите пять самых продаваемых товаров по количеству проданных единиц.
WITH total_products AS (
	SELECT
		p.id AS product_id,
		p.name AS product_name,
		SUM(oi.quantity ) AS total_quantity
	FROM products p
	JOIN order_items oi ON oi.product_id = p.id
	GROUP BY p.id, p.name
)

SELECT
	tp.product_id,
	tp.product_name,
	tp.total_quantity
FROM total_products tp
ORDER BY tp.total_quantity DESC, tp.product_id ASC
LIMIT 5;
