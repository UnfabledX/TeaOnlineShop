DROP SCHEMA tea_onlineshop;
CREATE schema tea_onlineshop;

USE tea_onlineshop;

-- these commands remove all tables from the database
-- An error occurs if tables not exist in DB, so just ignore commands

DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS order_content;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS statuses;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;

-- --------------------------------------------------------------
-- ROLES
-- users roles
-- --------------------------------------------------------------
CREATE TABLE roles
(

-- id has the INTEGER type (other name is INT), it is the primary key
    id   INT         NOT NULL,

-- name has the VARCHAR type - a string with a variable length
-- names values should not be repeated (UNIQUE) (admin, client)
    name VARCHAR(10) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (name)
) CHARACTER SET=utf8mb4;

-- first insertion goes 0, because we use ENUM as the Role entity
INSERT INTO roles
VALUES (0, 'admin');
INSERT INTO roles
VALUES (1, 'client');

-- --------------------------------------------------------------
-- USERS
-- --------------------------------------------------------------

CREATE TABLE users
(

-- 'generated always AS identity' means id is autoincrement field
-- (from 1 up to Integer.MAX_VALUE with the step 1)
    id       INTEGER     NOT NULL AUTO_INCREMENT,
-- not null string columns
    name     VARCHAR(20) NOT NULL,
    email    VARCHAR(64) NOT NULL,
    password VARCHAR(20) NOT NULL,

-- role_id in users table is associated with id in roles table
-- role_id of user = id of role
    role_id  INTEGER     NOT NULL,

-- 'UNIQUE' means logins values should not repeat in login column
-- of table
    PRIMARY KEY (id),
    UNIQUE KEY (email),

-- this declaration contains the foreign key constraint
    CONSTRAINT users_roles_fk
        FOREIGN KEY (role_id) REFERENCES roles (id)
) CHARACTER SET=utf8mb4;

-- inserting admin user with id = 1, name, email, password, 0-admin
INSERT INTO users
VALUES (DEFAULT, 'Olena', 'leka9pog@gmail.com', '654321', 0);

-- inserting authorized user with id = 2, name, email, password, 1-client
INSERT INTO users
VALUES (DEFAULT, 'Oleksii', 'alex0destroyer@gmail.com', '123456', 1);

-- inserting authorized user with id = 3, name, email, password, 1-client
INSERT INTO users
VALUES (DEFAULT, 'Luida', 'plakotniuk95@gmail.com', '987654', 1);

-- --------------------------------------------------------------
-- STATUSES
-- statuses for orders
-- --------------------------------------------------------------

CREATE TABLE statuses
(
    id   INTEGER     NOT NULL,
-- names are created, paid, canceled, done
    name VARCHAR(10) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (name)
) CHARACTER SET=utf8mb4;

-- As statuses are predefined let's insert them in the table
INSERT INTO statuses
VALUES  (0, 'created'),
        (1, 'paid'),
        (2, 'canceled'),
        (3, 'done');

-- --------------------------------------------------------------
-- ORDERS
-- --------------------------------------------------------------
CREATE TABLE orders
(
    id        INTEGER  NOT NULL AUTO_INCREMENT,
    user_id   INTEGER  NOT NULL,
    status_id INTEGER  NOT NULL,
-- DATETIME unites time and date in range from 1th of Jan 1000 till 31th of Dec 9999
-- format by default is 'yyyy-mm-dd hh:mm:ss'
    createdAt DATETIME NOT NULL,

    PRIMARY KEY (id),

    CONSTRAINT fk_orders_users
        FOREIGN KEY (user_id) REFERENCES users (id)
            ON DELETE CASCADE /* if user with id is deleted - all orders which are made by this user are deleted as well*/
            ON UPDATE CASCADE,
    CONSTRAINT fk_orders_statuses
        FOREIGN KEY (status_id) REFERENCES statuses (id)
            ON DELETE NO ACTION /*if status is deleted - all orders' status_id with such status aren't changed*/
            ON UPDATE CASCADE
) CHARACTER SET=utf8mb4;

-- inserting some orders for example
INSERT INTO orders
VALUES (DEFAULT/*1*/, 2/*user with id 2*/, 2/*status paid*/, '2022-09-26 10:25:13');
INSERT INTO orders
VALUES (DEFAULT/*2*/, 2/*user with id 2*/, 1/*status created*/, '2022-10-08 12:40:06');

-- --------------------------------------------------------------
-- PRODUCTS
-- --------------------------------------------------------------
CREATE TABLE products
(
    id          INTEGER        NOT NULL AUTO_INCREMENT,
    name        VARCHAR(255)   NOT NULL,
    description TEXT           NOT NULL,
    price       DECIMAL(10, 2) NOT NULL,

    PRIMARY KEY (id),
    UNIQUE KEY (name)
) CHARACTER SET=utf8mb4;

-- inserting some existing products
INSERT INTO products
VALUES (DEFAULT/*1*/, 'Чай «Літні радощі» 45г у пакеті з застібкою zip-lock',
        'Склад: ферментоване листя абрикосу, сливи, яблуні, ірги та шовковиці', 105.00);
INSERT INTO products
VALUES (DEFAULT/*2*/, 'Чай «Осінні барви» 45г у пакеті з застібкою zip-lock',
        'Склад: ферментоване листя горобини, дикої груші та яблуні, шматочки сушеної айви, верес і плоди горобини.',
        105.00);
INSERT INTO products
VALUES (DEFAULT/*3*/, 'Чай «Еліксир здоров’я» 45г у пакеті з застібкою zip-lock',
        'Склад: ферментоване листя чорниці, малини, яблуні, сливи, плоди горобини, барбарису.', 110.00);
INSERT INTO products
VALUES (DEFAULT/*4*/, 'Чай «Вітамінка» 75г у скляній банці',
        'Склад: ферментоване листя малини, винограду, липи та обліпихи, сушена м’ята, чебрець,
        шматочки яблука, шипшина, плоди обліпихи, лимонна цедра.', 185.00);
INSERT INTO products
VALUES (DEFAULT/*5*/, 'Чай «Вечірня колисанка» 75г у скляній банці',
        'Склад: ферментоване листя липи, ірги та глоду, шишки хмелю, материнка, верес, м’ята, плоди глоду.', 185.00);
INSERT INTO products
VALUES (DEFAULT/*6*/, 'Чай «Запашна феєрія» 45г у пакеті з застібкою zip-lock',
        'Склад: ферментоване листя іван-чаю та вишні, чебрець, материнка.', 105.00);

-- --------------------------------------------------------------
-- ORDER_CONTENT
-- --------------------------------------------------------------
CREATE TABLE order_content
(
    order_id    INTEGER        NOT NULL,
    product_id  INTEGER        NOT NULL,
    quantity    INTEGER        NOT NULL DEFAULT 1,
    total_price DECIMAL(10, 2) NOT NULL,

    CONSTRAINT `fk_order-content_orders`
        FOREIGN KEY (order_id) REFERENCES orders (id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_order-content_product`
        FOREIGN KEY (product_id) REFERENCES products (id)
            ON DELETE NO ACTION
            ON UPDATE CASCADE
) CHARACTER SET=utf8mb4;

-- Let's insert some content for orders
INSERT INTO order_content
VALUES (1, 3, 2, (SELECT price FROM products WHERE products.id = 3) * quantity);
INSERT INTO order_content
VALUES (1, 5, 1, (SELECT price FROM products WHERE products.id = 5) * quantity);
INSERT INTO order_content
VALUES (2, 4, 2, (SELECT price FROM products WHERE products.id = 4) * quantity);


-- --------------------------------------------------------------
-- test database:
-- --------------------------------------------------------------
SELECT *
FROM order_content;
SELECT *
FROM products;
SELECT *
FROM orders;
SELECT *
FROM statuses;
SELECT *
FROM users;
SELECT *
FROM roles;
