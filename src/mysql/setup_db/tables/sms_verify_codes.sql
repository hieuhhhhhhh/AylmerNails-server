CREATE TABLE sms_verify_codes (
    phone_number VARCHAR(15) PRIMARY KEY,
    hashed_password VARCHAR(60) NOT NULL,
    code VARCHAR(4) NOT NULL,
    attempts_left INT NOT NULL,
    created_at BIGINT NOT NULL
);

CREATE INDEX idx_created_at ON sms_verify_codes(created_at);