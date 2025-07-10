DROP PROCEDURE IF EXISTS sp_add_user;

CREATE PROCEDURE sp_add_user(
    IN _phone_num VARCHAR(15),
    IN _hashed_password VARCHAR(60),
    IN _first_name VARCHAR(30),
    IN _last_name VARCHAR(30),
    IN _name_tokens JSON
) 
BEGIN
    -- variables
    DECLARE phone_num_id_ INT UNSIGNED;

    -- get phone number id
    CALL sp_get_phone_num_id (_phone_num, phone_num_id_);

    -- create new user
    INSERT INTO authentication (phone_num_id, hashed_password)
        VALUES (phone_num_id_, _hashed_password)
        ON DUPLICATE KEY 
            UPDATE hashed_password = _hashed_password;
    
    -- create profile for new user
    INSERT INTO profiles(user_id, first_name, last_name)
        VALUES (LAST_INSERT_ID(), _first_name, _last_name);

    -- overwrite new contact
    INSERT INTO contacts (phone_num_id, name)
        VALUES (phone_num_id_, CONCAT(_first_name, ' ', _last_name))
        ON DUPLICATE KEY UPDATE
            name = CONCAT(_first_name, ' ', _last_name),
            time = UNIX_TIMESTAMP();     
            
    -- return added user id
    SELECT LAST_INSERT_ID();
END;
