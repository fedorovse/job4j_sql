# вывести кузова, которые не используются ни в одной машине
SELECT
	cb.id,
	cb.name
FROM car_bodies AS  cb
LEFT JOIN cars c ON c.body_id = cb.id
WHERE c.id IS NULL ;

# вывести двигатели, которые не используются ни в одной машине
SELECT
	ce.id,
	ce.name
FROM car_engines AS  ce
LEFT JOIN cars c ON c.engine_id = ce.id
WHERE c.id IS NULL ;

# вывести коробки передач, которые не используются ни в одной машине
SELECT
	ct.id,
	ct.name
FROM car_transmissions AS  ct
LEFT JOIN cars c ON c.transmission_id = ct.id
WHERE c.id IS NULL ;

# вывести список всех машин и название кузова, если оно указано
SELECT
	c.id,
	c.name AS car_name,
	cb.name AS body_name
FROM cars AS c
LEFT JOIN car_bodies AS cb ON c.body_id = cb.id;

# вывести только те машины, у которых одновременно указаны: кузов, двигатель, коробка передач
SELECT
	c.id,
	c.name AS car_name,
	cb.name AS body_name,
	ce.name AS engine_name,
	ct.name AS transmission_name
FROM cars c
LEFT JOIN car_bodies cb ON c.body_id = cb.id
LEFT JOIN car_engines ce ON c.engine_id = ce.id
LEFT JOIN car_transmissions ct ON c.transmission_id = ct.id
WHERE (cb.id IS NOT NULL) AND (ce.id IS NOT NULL) AND (ct.id IS NOT NULL);

# вывести машины, у которых есть двигатель, но нет кузова
SELECT
	c.id,
	c.name AS car_name,
	cb.name AS body_name,
	ce.name AS engine_name
FROM cars c
LEFT JOIN car_bodies cb ON c.body_id = cb.id
LEFT JOIN car_engines ce ON c.engine_id = ce.id
WHERE (cb.id IS NULL) AND (ce.id IS NOT NULL);

# вывести все кузова и машины, которые их используют
SELECT
	cb.id AS body_id,
	cb.name AS body_name,
	c.id AS car_id,
	c.name AS car_name
FROM car_bodies cb
LEFT JOIN cars c ON cb.id = c.body_id;

# вывести неиспользуемые двигатели
SELECT
	ce.id,
	ce.name
FROM car_engines AS  ce
LEFT JOIN cars c ON c.engine_id = ce.id
WHERE c.id IS NULL ;

# вывести машины и все их детали, но только для машин с автоматической коробкой передач
SELECT
	c.id,
	c.name AS car_name,
	cb.name AS body_name,
	ce.name AS engine_name,
	ct.name AS transmission_name
FROM cars c
LEFT JOIN car_bodies cb ON c.body_id = cb.id
LEFT JOIN car_engines ce ON c.engine_id = ce.id
LEFT JOIN car_transmissions ct ON c.transmission_id = ct.id
WHERE ct.name LIKE 'automatic%';

# вывести машины, у которых отсутствует хотя бы одна деталь
SELECT
	c.id,
	c.name AS car_name,
	cb.name AS body_name,
	ce.name AS engine_name,
	ct.name AS transmission_name
FROM cars c
LEFT JOIN car_bodies cb ON c.body_id = cb.id
LEFT JOIN car_engines ce ON c.engine_id = ce.id
LEFT JOIN car_transmissions ct ON c.transmission_id = ct.id
WHERE (cb.id IS NULL) OR (ce.id IS NULL) OR (ct.id IS NULL);

# вывести все машины с двигателями, но коробку передач подключить так, чтобы машины без коробки тоже попали в результат
SELECT
	c.id,
	c.name AS car_name,
	ce.name AS engine_name,
	ct.name AS transmission_name
FROM cars c
LEFT JOIN car_engines ce ON c.engine_id = ce.id
LEFT JOIN car_transmissions ct ON c.transmission_id = ct.id
WHERE ce.id IS NOT NULL;

# вывести все неиспользуемые детали в едином формате
SELECT
    'body' AS detail_type,
    cb.id AS detail_id,
    cb.name AS detail_name
FROM car_bodies cb
LEFT JOIN cars c ON c.body_id = cb.id
WHERE c.id IS NULL

UNION ALL

SELECT
    'engine' AS detail_type,
    ce.id AS detail_id,
    ce.name AS detail_name
FROM car_engines ce
LEFT JOIN cars c ON c.engine_id = ce.id
WHERE c.id IS NULL

UNION ALL

SELECT
    'transmission' AS detail_type,
    ct.id AS detail_id,
    ct.name AS detail_name
FROM car_transmissions ct
LEFT JOIN cars c ON c.transmission_id = ct.id
WHERE c.id IS NULL;

# вывести машины и детали только для кузовов определенных типов
SELECT
	c.id,
	c.name AS car_name,
	cb.name AS body_name,
	ce.name AS engine_name,
	ct.name AS transmission_name
FROM cars c
LEFT JOIN car_bodies cb ON c.body_id = cb.id
LEFT JOIN car_engines ce ON c.engine_id = ce.id
LEFT JOIN car_transmissions ct ON c.transmission_id = ct.id
WHERE (cb.name LIKE 'sedan') OR (cb.name LIKE 'hatchback') OR (cb.name LIKE 'suv');
