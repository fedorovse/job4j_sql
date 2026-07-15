
UPDATE users u
SET
phone = v.phone,
middle_name = v.middle_name
FROM (
    VALUES
        (4, '+71234567890', 'Petrovna'),
        (5, '+71234567001', NULL),
        (6, '+71234567002', 'Ivanovna'),
        (7, NULL, NULL),
        (8, NULL, 'Vasilevna'),
        (9, '+71234567005', 'Vladimirovich'),
        (10, '+71234567006', 'Petrovna'),
        (11, '+71234567007', 'Sergeevich'),
        (12, '+71234567008', 'Olegovna'),
        (13, '+71234567009', NULL),
        (14, '+71234567010', NULL),
        (15, NULL, 'Petrovich')
    ) AS v(id, phone, middle_name)
WHERE u.id = v.id;

UPDATE products p
SET
description = v.description,
discount_price = v.discount_price
FROM (
    VALUES
        (1, 'яблофон', NULL),
        (2, 'макабук', NULL),
        (3, NULL, 24900.00),
        (4, NULL, NULL),
        (5, NULL, 180.00),
        (6, 'караси', 145.00),
        (7, 'спорт', 1400.00),
        (8, NULL, NULL),
        (9, NULL, NULL),
        (10, NULL, NULL),
        (11, 'левайсы', 15000.00),
        (12, NULL, 7500.00)
    ) AS v(id, description, discount_price)
WHERE p.id = v.id;
