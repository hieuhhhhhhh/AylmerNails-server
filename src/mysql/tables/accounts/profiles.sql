CREATE TABLE profiles (
    user_id INT UNSIGNED PRIMARY KEY, -- Primary key and foreign key
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    theme_color VARCHAR(20), 
    appos_pending SMALLINT UNSIGNED DEFAULT 0,
    appos_completed SMALLINT UNSIGNED DEFAULT 0,
    appos_missed SMALLINT UNSIGNED DEFAULT 0,
    FOREIGN KEY (user_id) 
        REFERENCES authentication(user_id) 
        ON DELETE CASCADE
);
