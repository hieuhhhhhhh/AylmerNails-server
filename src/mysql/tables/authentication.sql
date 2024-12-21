CREATE TABLE authentication (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    hashed_password VARCHAR(60) NOT NULL,
    created_at BIGINT NOT NULL
);

CREATE INDEX idx_created_at ON authentication(created_at);