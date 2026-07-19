SELECT
	o.id AS order_id,
	o.status ,
	u.email
FROM orders o
INNER JOIN users u ON o.user_id = u.id
ORDER BY order_id DESC ;

SELECT
	oi.id AS order_item_id,
	o.id AS order_id,
	p.name,
	oi.quantity
FROM order_items oi
INNER JOIN orders o ON oi.order_id = o.id
INNER JOIN products p ON oi.product_id = p.id
WHERE oi.quantity > 1;

SELECT
	o.id AS order_id,
	p.name,
	oi.quantity,
	oi.unit_price
FROM order_items oi
INNER JOIN orders o ON oi.order_id = o.id
INNER JOIN products p ON oi.product_id = p.id
WHERE o.user_id = 1;

SELECT
	o.id AS order_id,
	o.status,
	u.name
FROM orders o
INNER JOIN users u ON o.user_id = u.id
WHERE o.status = 'NEW';

SELECT
	oi.id AS order_item_id,
	p.name,
	oi.quantity,
	oi.quantity * oi.unit_price AS line_total
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.id
