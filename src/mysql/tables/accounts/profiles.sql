CREATE TABLE profiles (
    user_id INT UNSIGNED PRIMARY KEY, -- Primary key and foreign key
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    theme_color VARCHAR(20), 
    pending_appos SMALLINT UNSIGNED DEFAULT 0,
    completed_appos SMALLINT UNSIGNED DEFAULT 0,
    missed_appos SMALLINT UNSIGNED DEFAULT 0,
    FOREIGN KEY (user_id) 
        REFERENCES authentication(user_id) 
        ON DELETE CASCADE
);
