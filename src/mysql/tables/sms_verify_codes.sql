CREATE TABLE sms_verify_codes (
    phone_number VARCHAR(15) PRIMARY KEY,
    new_password VARCHAR(60),
    code VARCHAR(4) NOT NULL,
    attempts_left INT NOT NULL,
    created_at BIGINT NOT NULL,
    expiry INT NOT NULL
);

CREATE INDEX idx_created_at ON sms_verify_codes(created_at);