CREATE TABLE profiles (
    user_id INT UNSIGNED PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    notes VARCHAR(300),
    
    FOREIGN KEY (user_id) 
        REFERENCES authentication(user_id) 
        ON DELETE CASCADE
);

-- index on first and last name
CREATE INDEX idx_first_name ON profiles (first_name);
CREATE INDEX idx_last_name ON profiles (last_name);


-- TRIGGERS
CREATE TRIGGER after_profiles_insert
    AFTER INSERT ON profiles
    FOR EACH ROW
    BEGIN
        -- variables 
        DECLARE phone_num_id_ INT UNSIGNED;
    
        -- fetch phone num id
        SELECT phone_num_id
            INTO phone_num_id_
            FROM authentication a
            WHERE a.user_id = NEW.user_id;

        -- recreate tokens
        CALL sp_update_name_tokens(phone_num_id_);
    END;


CREATE TRIGGER after_profiles_update
    AFTER UPDATE ON profiles
    FOR EACH ROW
    BEGIN
        -- variables 
        DECLARE phone_num_id_ INT UNSIGNED;
    
        -- fetch phone num id
        SELECT phone_num_id
            INTO phone_num_id_
            FROM authentication a
            WHERE a.user_id = NEW.user_id;

        -- recreate tokens
        CALL sp_update_name_tokens(phone_num_id_);
    END;


