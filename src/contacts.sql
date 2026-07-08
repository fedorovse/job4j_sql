CREATE TABLE contacts
(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description  VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO contacts (description, created_at)
VALUES ('Hi', '2026-07-06 14:30:00'),
       ('By', '2026-07-06 14:30:01'),
       ('Good', '2026-07-06 14:30:02'),
       ('Morning', '2026-07-06 14:30:03'),
       ('The end', '2026-07-06 14:30:04');

INSERT INTO contacts (description)
VALUES ('Sorry'),
       ('Bag');