CREATE TABLE login_attempts (
    user_id INT UNSIGNED PRIMARY KEY,
    created_at BIGINT DEFAULT UNIX_TIMESTAMP(),

    FOREIGN KEY (user_id) 
        REFERENCES authentication(user_id)
        ON DELETE CASCADE
);

-- index on birth
CREATE INDEX idx_created_at ON login_attempts(created_at);