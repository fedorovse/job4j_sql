INSERT INTO products (name, price, is_active)
VALUES
    ('трусы', 200.00, true),
    ('носки', 150.00, true),
    ('шорты', 1490.00, true),
    ('дошик', 70.00, false),
    ('зубная щетка', 500.00, true),
    ('футболка', 3000.00, true),
    ('джинсы', 17000.00, true),
    ('куртка', 7600.00, true)
RETURNING id, name, price, is_active;

INSERT INTO users (name, email)
    VALUES
('Anna Ivanova', 'anna.ivanova@example.com'),
('Petr Petrov', 'petr.petrov@example.com'),
('Maria Smirnova', 'maria.smirnova@example.com'),
('Ivan Kuznetsov', 'ivan.kuznetsov@example.com'),
('Elena Popova', 'elena.popova@example.com'),
('Dmitry Sokolov', 'dmitry.sokolov@example.com'),
('Olga Lebedeva', 'olga.lebedeva@example.com'),
('Sergey Morozov', 'sergey.morozov@example.com'),
('Natalia Volkovа', 'natalia.volkova@example.com'),
('Alexey Fedorov', 'alexey.fedorov@example.com'),
('Tatyana Pavlova', 'tatyana.pavlova@example.com'),
('Andrey Nikolaev', 'andrey.nikolaev@example.com'),
('Svetlana Orlova', 'svetlana.orlova@example.com'),
('Mikhail Vinogradov', 'mikhail.vinogradov@example.com'),
('Ekaterina Alexeeva', 'ekaterina.alexeeva@example.com'),
('Nikolay Denisov', 'nikolay.denisov@example.com'),
('Julia Makarova', 'julia.makarova@example.com'),
('Roman Grigoryev', 'roman.grigoryev@example.com'),
('Oksana Zhukova', 'oksana.zhukova@example.com'),
('Vladimir Antonov', 'vladimir.antonov@example.com'),
('Irina Semenova', 'irina.semenova@example.com'),
('Pavel Efimov', 'pavel.efimov@example.com'),
('Lyudmila Karpova', 'lyudmila.karpova@example.com'),
('Kirill Belov', 'kirill.belov@example.com'),
('Anastasia Timofeeva', 'anastasia.timofeeva@example.com'),
('Yuri Kozlov', 'yuri.kozlov@example.com'),
('Alena Zaitseva', 'alena.zaitseva@example.com'),
('Grigory Melnikov', 'grigory.melnikov@example.com'),
('Veronika Guseva', 'veronika.guseva@example.com'),
('Denis Smirnov', 'denis.smirnov@example.com')
RETURNING *;

INSERT INTO orders (user_id, status)
VALUES
(1, 'NEW'),
(2, 'PAID'),
(3, 'CANCELLED'),
(4, 'COMPLETED'),
(5, 'NEW'),
(6, 'PAID'),
(7, 'CANCELLED'),
(8, 'COMPLETED'),
(9, 'NEW'),
(10, 'PAID'),
(11, 'CANCELLED'),
(12, 'COMPLETED'),
(13, 'NEW'),
(14, 'PAID'),
(15, 'CANCELLED'),
(16, 'COMPLETED'),
(17, 'NEW'),
(18, 'PAID'),
(19, 'CANCELLED'),
(20, 'COMPLETED')
RETURNING *;

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (3, 5, 2, 200.00),
    (4, 6, 1, 150.00),
    (5, 11, 1, 17000.00),
    (6, 12, 1, 7600.00),
    (7, 9, 3, 500.00),
    (8, 10, 2, 3000.00),
    (9, 11, 1, 17000.00),
    (10, 12, 1, 7600.00),
    (11, 7, 1, 1490.00),
    (12, 3, 1, 24990.00)
RETURNING *;