CREATE TABLE saved_appos(
    appo_id INT UNSIGNED PRIMARY KEY,
    time BIGINT,

    FOREIGN KEY (appo_id) REFERENCES appo_details(appo_id)
        ON DELETE CASCADE
);

-- index on time
CREATE INDEX idx_time
    ON saved_appos(time);