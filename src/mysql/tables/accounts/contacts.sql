CREATE TABLE contacts (
    phone_num_id INT UNSIGNED PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    time BIGINT NOT NULL DEFAULT (UNIX_TIMESTAMP()) -- time of the most recent appointment         
);

-- index on time
CREATE INDEX idx_time ON contacts (time);

