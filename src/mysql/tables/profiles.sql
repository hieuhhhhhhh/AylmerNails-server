CREATE TABLE profiles (
    user_id INT UNSIGNED PRIMARY KEY, -- Primary key and foreign key
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    theme_color VARCHAR(20), 
    FOREIGN KEY (user_id) 
        REFERENCES authentication(user_id) 
        ON DELETE CASCADE
);
