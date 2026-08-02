
--получить общий список идентификаторов пользователей, которые:
--либо делали заказы со статусом PAID;
--либо делали заказы со статусом NEW
SELECT
	u.id AS user_id
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.status = 'PAID'

UNION

SELECT
	u.id AS user_id
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.status = 'NEW'
ORDER BY user_id ASC ;

--получить общий список событий из таблиц users, products, orders
SELECT
	'user' AS entity_type,
	u.id AS entity_id,
	u.created_at
FROM users u

UNION ALL

SELECT
	'product' AS entity_type,
	p.id AS entity_id,
	p.created_at
FROM products p

UNION ALL

SELECT
	'order' AS entity_type,
	o.id AS entity_id,
	o.created_at
FROM orders o
ORDER BY entity_type ASC , entity_id ASC ;

--найти товары, которые:
--активны;
--и хотя бы раз встречались в заказах
SELECT
	p.id AS product_id,
	p.name AS product_name
FROM products p
WHERE p.is_active = TRUE

INTERSECT

SELECT
	oi.product_id,
	p.name AS product_name
FROM order_items oi
JOIN products p ON p.id = oi.product_id
WHERE p.id IS NOT NULL
ORDER BY product_id ASC ;

--найти активные товары, которые ни разу не встречались в заказах
SELECT
	p.id AS product_id,
	p.name AS product_name
FROM products p
WHERE p.is_active = TRUE

EXCEPT

SELECT
	oi.product_id,
	p.name AS product_name
FROM order_items oi
JOIN products p ON p.id = oi.product_id
WHERE p.id IS NOT NULL
ORDER BY product_id ASC ;

--получить общий список пользователей, которые:
--либо вообще делали заказы;
--либо были созданы после 2025-01-01
SELECT
	u.id AS user_id,
	u.name AS user_name
FROM orders o
JOIN users u ON u.id = o.user_id

UNION

SELECT
	u.id AS user_id,
	u.name AS user_name
FROM users u
WHERE u.created_at > '2025-01-01'
ORDER BY user_id;

--получить список товаров, которые:
--дороже средней цены товаров;
--и при этом встречались в заказах
SELECT
	p.id AS product_id,
	p.name AS product_name,
	p.price
FROM products p
WHERE p.price > (
	SELECT
		AVG(price)
	FROM products
)

INTERSECT

SELECT
	oi.product_id,
	p.name,
	p.price
FROM order_items oi
JOIN products p ON oi.product_id = p.id

ORDER BY product_id;

--получить список пользователей, которые делали заказы, но не делали заказов со статусом CANCELLED
SELECT
	u.id AS user_id,
	u.name AS user_name
FROM users u
JOIN orders o ON u.id = o.user_id

EXCEPT

SELECT
	u.id AS user_id,
	u.name AS user_name
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.status <> 'CANCELLED'
ORDER BY user_id;

--получить общий список объектов для поиска по названию/имени из таблиц users и products
SELECT
	'user' AS entity_type,
	u.id AS entity_id,
	u.name AS display_name
FROM users u

UNION ALL

SELECT ALL
	'product' AS entity_type,
	p.id AS entity_id,
	p.name AS display_name
FROM products p
ORDER BY entity_type ASC, entity_id ASC ;
