CREATE TABLE unconfirmed_salts (
    session_id INT UNSIGNED PRIMARY KEY,
    new_salt INT NOT NULL,
    FOREIGN KEY (session_id) 
        REFERENCES user_sessions(id)
        ON DELETE CASCADE
);
