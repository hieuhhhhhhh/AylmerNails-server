DROP PROCEDURE IF EXISTS sp_add_user;

CREATE PROCEDURE sp_add_user(
    IN _phone_num VARCHAR(15),
    IN _hashed_password VARCHAR(60)
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
END;
