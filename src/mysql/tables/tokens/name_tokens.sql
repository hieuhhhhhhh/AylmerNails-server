CREATE TABLE name_tokens(
    token VARCHAR(50) NOT NULL,
    phone_num_id INT UNSIGNED,

    FOREIGN KEY (phone_num_id) REFERENCES phone_numbers(phone_num_id)
        ON DELETE CASCADE,
    PRIMARY KEY (token, phone_num_id)
);

-- index on phone number id
CREATE INDEX idx_phone_num_id ON name_tokens(phone_num_id);

-- some default phone numbers
INSERT INTO aylmer_nails.profiles (user_id, first_name, last_name)
    VALUES
        (1,'Henry', 'Duong');
        
-- some default phone numbers
INSERT INTO aylmer_nails.contacts (phone_num_id, name)
    VALUES
        (1,'Henry Duong');
        

