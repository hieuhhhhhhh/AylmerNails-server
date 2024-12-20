-- Create the new database
CREATE DATABASE test_db;

-- Use the newly created database
USE test_db;

-- Create table
CREATE TABLE hello_table(
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255)
);

-- Create table
CREATE TABLE authentication (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    hashed_password VARCHAR(255) NOT NULL,
    created_at BIGINT
);

-- Insert a sample row into the table
INSERT INTO
    hello_table (message)
VALUES
    ('Hello from MySQL');