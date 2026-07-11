INSERT INTO users (name, email)
VALUES ('Ivan Petrov', 'ivan.petrov@example.com')
RETURNING *;

INSERT INTO users (name, email)
    VALUES
    ('Anna Smirnova', 'anna.smirnova@example.com'),
    ('Petr Ivanov', 'petr.ivanov@example.com'),
    ('Olga Sidorova', 'olga.sidorova@example.com')
RETURNING *;

SELECT id, name, email, created_at
FROM users
ORDER BY id;

INSERT INTO products (name, price, is_active)
VALUES
    ('iPhone 17', 99990.00, true),
    ('MacBook Air M5', 149990.00, true),
    ('AirPods Pro 2', 24990.00, true),
    ('Old Keyboard', 1500.00, false)
RETURNING id, name, price, is_active;

/*
заказ №1 принадлежит Ivan Petrov состоит из iPhone 17 (1 шт) и AirPods Pro 2 (2 шт)
заказ №2 принадлежит Anna Smirnova состоит из MacBook Air M5 (1 шт)
*/

INSERT INTO orders (user_id, status)
VALUES
    (1, 'NEW'),
    (2, 'PAID')
RETURNING id, user_id, status, created_at;

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 99990.00),
    (1, 3, 2, 24990.00),
    (2, 2, 1, 149990.00)
RETURNING *;

SELECT
    o.id AS order_id,
    u.name AS user_name,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS line_total,
    o.status,
    o.created_at
FROM orders o
         JOIN users u ON u.id = o.user_id
         JOIN order_items oi ON oi.order_id = o.id
         JOIN products p ON p.id = oi.product_id
ORDER BY o.id, oi.id;

INSERT INTO inactive_products_archive (product_id, product_name, price)
SELECT id, name, price
FROM products
WHERE is_active = false
RETURNING *;