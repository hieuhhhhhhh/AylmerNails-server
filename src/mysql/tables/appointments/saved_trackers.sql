CREATE TABLE saved_trackers (
    user_id INT UNSIGNED PRIMARY KEY,
    time BIGINT NOT NULL DEFAULT (UNIX_TIMESTAMP()), -- user's last track on appointments  
    FOREIGN KEY (user_id)
        REFERENCES authentication (user_id)        
        ON DELETE CASCADE
);

-- index on time
CREATE INDEX idx_time ON saved_trackers (time);

