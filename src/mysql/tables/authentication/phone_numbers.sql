CREATE TABLE phone_numbers (
    phone_num_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    value VARCHAR(15) UNIQUE NOT NULL
);

-- unique index on value
