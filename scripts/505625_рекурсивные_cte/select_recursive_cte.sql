WITH RECURSIVE folders_tree AS (
SELECT
	id,
	name,
	parent_id,
	1 AS level,
	name::text AS path_tree
FROM folders
WHERE id = 1

UNION ALL

SELECT
	f.id,
	f.name,
	f.parent_id,
	ft.level + 1,
	ft.path_tree || '/' || f.name
FROM folders f
JOIN folders_tree ft ON ft.id = f.parent_id
)

SELECT
	repeat('-', level - 1) || name AS folder_name,
	LEVEL
FROM folders_tree
ORDER BY path_tree

WITH RECURSIVE folders_path AS (
SELECT
	id,
	name,
	parent_id,
	ARRAY[name] AS path
FROM folders
WHERE id = 10

UNION ALL

SELECT
	f.id,
	f.name,
	f.parent_id,
	f.name || fp.path
FROM folders f
JOIN folders_path fp ON f.id = fp.parent_id
)

SELECT
	array_to_string(path, '->') AS full_path
FROM folders_path
WHERE parent_id IS NULL ;


-- искусственно создаем цикл
UPDATE folders
SET parent_id = 10
WHERE id = 3;

SELECT *
FROM folders f

WITH RECURSIVE folders_tree AS (
SELECT
	id,
	name,
	parent_id,
	1 AS level,
	name::text AS path_tree
FROM folders
WHERE id = 1

UNION ALL

SELECT
	f.id,
	f.name,
	f.parent_id,
	ft.level + 1,
	ft.path_tree || '/' || f.name
FROM folders f
JOIN folders_tree ft ON ft.id = f.parent_id
)

CYCLE id
SET is_cycle
USING cycle_path

SELECT
	repeat('-', level - 1) || name AS folder_name,
	LEVEL
FROM folders_tree
WHERE NOT is_cycle
ORDER BY path_tree;

