SELECT
	u.id AS user_id,
	u.name AS user_name,
	count (o.id) AS "количество товара"
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id
ORDER BY u.id ASC;

SELECT
	o.id AS order_id,
	o.status,
	o.created_at
FROM orders o
LEFT JOIN payments p ON o.id = p.order_id
WHERE p.id IS NULL
ORDER BY o.id;

SELECT
	p.id AS product_id,
	p.name AS product_name,
	count (oi.id) AS "количество строк заказа, где товар встречался"
FROM products p
LEFT JOIN order_items oi ON p.id = oi.product_id
WHERE oi.id IS NOT NULL
GROUP BY p.id
ORDER BY p.id;

SELECT
	r.name,
	count (ur.user_id) AS "количество пользователей"
FROM roles r
LEFT JOIN user_roles ur ON r.id = ur.role_id
GROUP BY r.id
ORDER BY r.code;

SELECT
	u.id,
	u.name,
	u.email
FROM users u
LEFT JOIN user_roles ur ON u.id = ur.user_id
WHERE ur.role_id IS NULL
ORDER BY u.id ASC ;

SELECT
	r.code,
	ur.user_id
FROM roles r
FULL JOIN user_roles ur ON r.id = ur.role_id;

SELECT
	r.code AS role_code,
	e.code AS environments_code
FROM roles r
CROSS JOIN environments e;

SELECT
	c.name ,
	p.name AS parent_name
FROM categories c
LEFT JOIN categories p ON c.parent_id = p.id;
