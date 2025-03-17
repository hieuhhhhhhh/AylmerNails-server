CREATE TABLE phone_numbers (
    phone_num_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    value VARCHAR(15) UNIQUE NOT NULL
);

-- unique index on value

-- some default phone numbers
INSERT INTO aylmer_nails.phone_numbers (phone_num_id, value)
    VALUES
        (1,'+12269851917'),
        (2,'+11');
