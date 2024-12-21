CREATE TABLE user_sessions (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    session_salt INT NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    created_at BIGINT NOT NULL,
    expiry INT NOT NULL,
    remember_me BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES authentication (user_id)
);

CREATE INDEX idx_id_session_salt ON user_sessions (id, session_salt);

CREATE INDEX idx_user_id ON user_sessions (user_id);
