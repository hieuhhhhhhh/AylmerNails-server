CREATE TABLE authentication (
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    hashed_password VARCHAR(60) NOT NULL,
    created_at BIGINT NOT NULL
);

CREATE INDEX idx_created_at ON authentication (created_at);

INSERT INTO
    aylmer_nails.authentication (
        phone_number,
        hashed_password,
        created_at
    )
VALUES (
        '+12269851917',
        '$2b$12$YKgGgFRGCqaccjM7f5cG0O2sEjlMWwo6fdIqCL0N6rERSozoUXWIq',
        1734817348
    );