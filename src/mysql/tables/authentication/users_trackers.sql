CREATE TABLE users_trackers (
    user_id INT UNSIGNED PRIMARY KEY,
    time BIGINT NOT NULL DEFAULT (UNIX_TIMESTAMP()), -- user's last track on user list  
    FOREIGN KEY (user_id)
        REFERENCES authentication (user_id)        
);

-- index on time
CREATE INDEX idx_time ON users_trackers (time);

