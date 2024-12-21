CREATE TABLE user_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    created_at BIGINT NOT NULL,
    remember_me BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES authentication (user_id)
);