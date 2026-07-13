SELECT
    id,
    name,
    price,
    is_active
FROM products
WHERE is_active = TRUE;

SELECT
    id,
    name,
    price
FROM products
WHERE price BETWEEN 10000 AND 100000;

SELECT
    id,
    user_id,
    status,
    created_at
FROM orders
WHERE status IN ('NEW', 'PAID');

INSERT INTO orders (user_id, status)
VALUES
    (1, 'CANCELLED'),
    (1, 'CANCELLED')
RETURNING id, user_id, status, created_at;

SELECT
    id,
    user_id,
    status,
    created_at
FROM orders
WHERE user_id = 1 AND status <> 'CANCELLED';

SELECT
    id,
    name,
    email
FROM users
WHERE created_at BETWEEN TIMESTAMPTZ '2026-06-20 00:00:00+00' AND TIMESTAMPTZ '2026-08-20 00:00:00+00';

SELECT
    id,
    name,
    price
FROM products
WHERE price < 20000 OR price > 80000;

SELECT
    id,
    name,
    price
FROM products
WHERE is_active = TRUE AND (price < 3000 OR price > 150000);
