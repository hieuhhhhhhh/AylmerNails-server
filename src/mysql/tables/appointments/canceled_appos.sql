CREATE TABLE canceled_appos(
    canceled_id INT UNSIGNED AUTO_INCREMENT,
    user_id INT UNSIGNED, -- user id who canceled the appo
    details JSON,
    time BIGINT NOT NULL DEFAULT (UNIX_TIMESTAMP()),

    FOREIGN KEY (user_id) 
        REFERENCES authentication(user_id) 
        ON DELETE SET NULL
);

-- index on time
CREATE INDEX idx_time ON contacts (time);