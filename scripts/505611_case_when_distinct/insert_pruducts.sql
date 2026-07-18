# Дубликаты с другой ценой для проверки запроса
INSERT INTO products (name, price, is_active)
VALUES
    ('трусы', 100.00, true),
    ('трусы', 500.00, true),
    ('носки', 250.00, true),
    ('шорты', 1090.00, true),
    ('дошик', 65.00, false),
    ('зубная щетка', 501.00, true),
    ('футболка', 2050.00, true),
    ('джинсы', 15000.00, true),
    ('куртка', 9600.00, true)
RETURNING id, name, price, is_active;