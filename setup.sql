-- Drop the database if it exists
DROP DATABASE IF EXISTS test_db;

-- Create the new database
CREATE DATABASE test_db;

-- Use the newly created database
USE test_db;

-- Create the table if it does not exist
CREATE TABLE hello_table(
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255)
);

-- Insert a sample row into the table
INSERT INTO
    hello_table (message)
VALUES
    ('Hello from MySQL');