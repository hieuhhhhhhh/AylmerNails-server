CREATE TABLE login_attempts (
    attempt_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    created_at BIGINT DEFAULT (UNIX_TIMESTAMP()),

    FOREIGN KEY (user_id) 
        REFERENCES authentication(user_id)
        ON DELETE CASCADE
);

-- index on birth
CREATE INDEX idx_created_at ON login_attempts(created_at);