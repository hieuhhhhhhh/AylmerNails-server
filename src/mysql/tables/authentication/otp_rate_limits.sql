CREATE TABLE otp_rate_limits (
    ip_address VARBINARY(16) PRIMARY KEY,
    wait_score INT NOT NULL DEFAULT 0,
    created_at BIGINT NOT NULL DEFAULT (UNIX_TIMESTAMP()),
    wait_until BIGINT NOT NULL   
);

-- index on birth
CREATE INDEX idx_created_at ON otp_rate_limits (created_at);
