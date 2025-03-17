CREATE TABLE sms_verify_codes (
    phone_num_id INT UNSIGNED PRIMARY KEY,
    new_password VARCHAR(60),
    code VARCHAR(4) NOT NULL,
    attempts_left INT NOT NULL,
    created_at BIGINT NOT NULL,
    expiry INT NOT NULL,    
    FOREIGN KEY (phone_num_id)
        REFERENCES phone_numbers(phone_num_id)
        ON DELETE CASCADE
);

-- index on birth
CREATE INDEX idx_created_at ON sms_verify_codes(created_at);