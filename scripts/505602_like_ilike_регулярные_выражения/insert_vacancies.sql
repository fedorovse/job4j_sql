INSERT INTO vacancies (title, company, description)
VALUES
	('Java backend developer', 'Рога и копыта', 'Позарез нужен синьёр-помидор'),
	('Java developer', 'Войти в IT', NULL),
	('Go developer', 'SuperIT', '100500$ в секунду'),
	('java kotlin', 'Yellow', NULL),
	('java', 'Progress', NULL),
	('java go', 'Ozon', 'Переезд в Нск')
RETURNING *;