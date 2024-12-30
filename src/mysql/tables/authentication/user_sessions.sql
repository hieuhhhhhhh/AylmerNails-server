CREATE TABLE user_sessions (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    session_salt INT NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    created_at BIGINT NOT NULL,
    expiry INT NOT NULL,
    remember_me BOOLEAN DEFAULT FALSE,
    
    FOREIGN KEY (user_id) 
        REFERENCES authentication (user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- index on birth time
CREATE INDEX idx_created_at ON user_sessions(created_at);

-- index to find salt in a session
CREATE INDEX idx_id_session_salt ON user_sessions (id, session_salt);

-- index on user id
CREATE INDEX idx_user_id ON user_sessions (user_id);
