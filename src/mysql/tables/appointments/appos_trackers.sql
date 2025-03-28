CREATE TABLE appos_trackers (
    user_id INT UNSIGNED PRIMARY KEY,
    time BIGINT NOT NULL DEFAULT (UNIX_TIMESTAMP()), -- user's last track on appointments  
    FOREIGN KEY (user_id)
        REFERENCES authentication (user_id)        
);

-- index on time
CREATE INDEX idx_time ON appos_trackers (time);

