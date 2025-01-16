-- default indexes on user id (primary key) and phone (unique key)
CREATE TABLE authentication (
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    hashed_password VARCHAR(60) NOT NULL,
    created_at BIGINT NOT NULL,
    role ENUM('client', 'admin', 'developer') NOT NULL DEFAULT 'client'

);

-- index on birth
CREATE INDEX idx_created_at ON authentication (created_at);

-- some default users
INSERT INTO aylmer_nails.authentication (phone_number,hashed_password,created_at,`role`) VALUES
    ('+11','$2b$12$YKgGgFRGCqaccjM7f5cG0O2sEjlMWwo6fdIqCL0N6rERSozoUXWIq',1734817348,'developer'),
    ('+12269851917','$2b$12$YKgGgFRGCqaccjM7f5cG0O2sEjlMWwo6fdIqCL0N6rERSozoUXWIq',1736992767,'client');
