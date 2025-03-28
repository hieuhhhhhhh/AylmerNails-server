CREATE TABLE contacts (
    phone_num_id INT UNSIGNED PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    time BIGINT NOT NULL DEFAULT (UNIX_TIMESTAMP()), -- time of the most recent appointment         
    FOREIGN KEY (phone_num_id)
        REFERENCES phone_numbers(phone_num_id)        
);

-- index on time
CREATE INDEX idx_time ON contacts (time);

-- some default phone numbers
INSERT INTO aylmer_nails.contacts (phone_num_id, name)
    VALUES
        (1,'Henry Duong');
        
