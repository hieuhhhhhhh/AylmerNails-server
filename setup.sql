CREATE DATABASE IF NOT EXISTS test_db;

USE test_db;

CREATE PROCEDURE create_hello_table() BEGIN CREATE TABLE IF NOT EXISTS hello_table(
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255)
);

INSERT INTO
    hello_table (message)
VALUES
    ('Hello from MySQL');

END;

CALL create_hello_table();