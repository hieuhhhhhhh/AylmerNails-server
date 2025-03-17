CREATE TABLE appo_notifications (
    appo_id INT UNSIGNED PRIMARY KEY,
    time BIGINT NOT NULL DEFAULT (UNIX_TIMESTAMP()), -- created time
    FOREIGN KEY (appo_id)
        REFERENCES appo_details (appo_id)        
);

-- index on time
CREATE INDEX idx_time ON appo_notifications (time);

