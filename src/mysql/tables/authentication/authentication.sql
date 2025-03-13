-- default indexes on user id (primary key) and phone (unique key)
CREATE TABLE authentication (
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    phone_num_id INT UNSIGNED UNIQUE,
    hashed_password VARCHAR(60) NOT NULL,
    created_at BIGINT NOT NULL DEFAULT (UNIX_TIMESTAMP()),
    role 
        ENUM('client', 'employee', 'admin', 'developer') 
        NOT NULL 
        DEFAULT 'client',

    FOREIGN KEY (phone_num_id)
        REFERENCES phone_numbers (phone_num_id)        
);

-- unique index on phone number id

-- index on birth
CREATE INDEX idx_created_at ON authentication (created_at);

-- some default users
INSERT INTO aylmer_nails.authentication (phone_num_id,hashed_password,created_at,`role`) 
    VALUES 
        (1,'$2b$12$YKgGgFRGCqaccjM7f5cG0O2sEjlMWwo6fdIqCL0N6rERSozoUXWIq',1734817348,'developer'),
        (2,'$2b$12$YKgGgFRGCqaccjM7f5cG0O2sEjlMWwo6fdIqCL0N6rERSozoUXWIq',1736992767,'developer');
