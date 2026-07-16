
SELECT
id,
name,
email
FROM users u
WHERE email LIKE '%mail%';

SELECT
 id,
 name,
 price
 FROM products p
 WHERE name ILIKE '%air%';

SELECT
 id,
 name,
 price
 FROM products p
 WHERE name ILIKE 'i%';

SELECT
 id,
 name,
 price
 FROM products p
 WHERE name ILIKE '%pro';

SELECT
id,
name,
email
FROM users u
WHERE email ILIKE 'A%' OR
		email ILIKE 'I%';

SELECT
id,
title,
company,
description
FROM vacancies
WHERE title ILIKE '%java%' OR
title ILIKE '%go%' OR
title ILIKE '%postgres%';

SELECT
 id,
 name,
 price
 FROM products p
 WHERE name ~* 'iphone [0-9]+';
