SELECT
	oi.order_id,
	o.user_id,
	(oi.unit_price * oi.quantity) AS total_amount,
	SUM(oi.unit_price * oi.quantity)
	OVER (PARTITION BY o.user_id ) AS user_total
FROM order_items oi
JOIN orders o ON oi.order_id = o.id

--
SELECT
	oi.order_id,
	o.user_id,
	(oi.unit_price * oi.quantity) AS total_amount,
	AVG(oi.unit_price * oi.quantity)
	OVER (PARTITION BY o.user_id ) AS average_order_amount
FROM order_items oi
JOIN orders o ON oi.order_id = o.id

--для каждого заказа необходимо определить его порядковый номер среди заказов этого пользователя по дате оформления
SELECT
	o.id AS order_id,
	o.user_id,
	o.created_at,
	ROW_NUMBER() OVER (ORDER BY o.created_at) AS row_number
FROM orders o

--постройте рейтинг заказов по их стоимости в порядке убывания
SELECT
	oi.order_id,
	(oi.quantity  * oi.unit_price) AS total_amount,
	RANK() OVER (ORDER BY (oi.quantity  * oi.unit_price) DESC) AS order_rank
FROM order_items oi

--выполните ту же задачу, что и в предыдущем задании, но используйте функцию DENSE_RANK()
SELECT
	oi.order_id,
	(oi.quantity  * oi.unit_price) AS total_amount,
	DENSE_RANK() OVER (ORDER BY (oi.quantity  * oi.unit_price) DESC) AS order_rank
FROM order_items oi

--разделите все заказы на четыре примерно равные группы по стоимости заказа в порядке убывания
WITH order_totals AS (
SELECT
	oi.order_id,
	SUM(oi.quantity  * oi.unit_price) AS total_amount
FROM order_items oi
GROUP BY oi.order_id
)

SELECT
	order_id,
	total_amount,
	NTILE(4) OVER (ORDER BY total_amount DESC) AS group_number
FROM order_totals
ORDER BY total_amount DESC ;

--
WITH order_totals AS (
SELECT
	oi.order_id,
	o.user_id,
	SUM(oi.quantity * oi.unit_price) AS total_am
FROM order_items oi
JOIN orders o ON oi.order_id = o.id
GROUP BY oi.order_id , o.user_id
)

SELECT
	order_id,
	user_id,
	total_am AS total_amount,
	SUM(total_am) OVER w AS user_total,
	AVG(total_am) OVER w AS average_order_amount,
	COUNT(*) OVER w AS orders_count
FROM order_totals

WINDOW w AS (
    PARTITION BY user_id
);