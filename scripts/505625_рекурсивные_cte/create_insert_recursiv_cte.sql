CREATE TABLE IF NOT EXISTS folders (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    parent_id BIGINT REFERENCES folders(id)
);

INSERT INTO folders (id, name, parent_id)
VALUES (1, 'Projects', NULL),
       (2, 'Backend', 1),
       (3, 'Frontend', 1),
       (4, 'Java', 2),
       (5, 'Python', 2),
       (6, 'src', 4),
       (7, 'test', 4),
       (8, 'React', 3),
       (9, 'components', 8),
       (10, 'utils', 9),
       (11, 'images', 8);

-- искусственно создаем цикл
UPDATE folders
SET parent_id = 10
WHERE id = 3;