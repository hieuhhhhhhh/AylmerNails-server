CREATE TABLE contact_tokens(
    token VARCHAR(50) NOT NULL,
    phone_num_id INT UNSIGNED,

    FOREIGN KEY (phone_num_id) REFERENCES contacts(phone_num_id)
        ON DELETE CASCADE,
    PRIMARY KEY (token, phone_num_id)
);

-- index on phone number id
CREATE INDEX idx_phone_num_id ON contact_tokens(phone_num_id);