CREATE TABLE phone_num_tokens(
    token VARCHAR(30) NOT NULL,
    phone_num_id INT UNSIGNED,

    FOREIGN KEY (phone_num_id) REFERENCES phone_numbers (phone_num_id)
        ON DELETE CASCADE,
    PRIMARY KEY (token, phone_num_id)
);

-- index on phone number id
CREATE INDEX idx_phone_num_id ON phone_num_tokens (phone_num_id);

-- some default phone numbers
INSERT INTO aylmer_nails.phone_numbers (phone_num_id, value)
    VALUES
        (1,'+12269851917');
