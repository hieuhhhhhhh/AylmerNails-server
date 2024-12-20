CREATE TABLE authentication (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    hashed_password VARCHAR(255) NOT NULL,
    created_at BIGINT
);