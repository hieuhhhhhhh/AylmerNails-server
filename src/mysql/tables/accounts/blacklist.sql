CREATE TABLE blacklist(
    phone_num_id INT UNSIGNED PRIMARY KEY,
    time BIGINT DEFAULT (UNIX_TIMESTAMP())
);

-- index on time
CREATE INDEX idx_time ON blacklist(time);
