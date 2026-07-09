DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS states;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS comments;

CREATE TABLE roles
(
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    role            VARCHAR(50) NOT NULL UNIQUE,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE users
(
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    login           VARCHAR(100) NOT NULL UNIQUE,
    password_hash   TEXT NOT NULL,
    role_id         BIGINT NOT NULL REFERENCES roles(id),
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE states
(
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    state           VARCHAR(50) NOT NULL UNIQUE,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE categories
(
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category        VARCHAR(50) NOT NULL UNIQUE,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE items
(
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title           VARCHAR(100) NOT NULL,
    description     TEXT NOT NULL,
    author_id       BIGINT NOT NULL REFERENCES users(id),
    state_id        BIGINT NOT NULL REFERENCES states(id),
    category_id     BIGINT NOT NULL REFERENCES categories(id),
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE comments
(
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    comment         TEXT NOT NULL,
    author_id       BIGINT NOT NULL REFERENCES users(id),
    item_id         BIGINT NOT NULL REFERENCES items(id) ON DELETE CASCADE,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);