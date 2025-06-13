CREATE TABLE otp_codes (
    code_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    value VARCHAR(20) NOT NULL,
    phone_num VARCHAR(30) NOT NULL,
    attempts_left INT NOT NULL,
    created_at BIGINT NOT NULL DEFAULT (UNIX_TIMESTAMP()),
    duration INT NOT NULL   -- in secs
);

-- index on birth
CREATE INDEX idx_created_at ON otp_codes(created_at);