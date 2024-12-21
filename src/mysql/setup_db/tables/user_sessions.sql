CREATE TABLE user_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    session_salt INT NOT NULL,
    user_id INT NOT NULL,
    created_at BIGINT NOT NULL,
    remember_me BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES authentication(user_id)
);

CREATE INDEX idx_session_salt_user_id ON user_sessions (session_salt, user_id);
