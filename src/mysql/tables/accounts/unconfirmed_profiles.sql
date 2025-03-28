-- store temporary profile for sign up

CREATE TABLE unconfirmed_profiles (
    phone_num_id  INT UNSIGNED PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,

    FOREIGN KEY (phone_num_id) REFERENCES
        REFERENCES phone_numbers(phone_num_id)        
        ON DELETE CASCADE
);
