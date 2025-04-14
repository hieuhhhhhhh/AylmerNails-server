DROP PROCEDURE IF EXISTS sp_ban_unban_phone_num;

CREATE PROCEDURE sp_ban_unban_phone_num(
    IN _session JSON,
    IN _phone_num VARCHAR(30),
    IN _boolean BOOLEAN
)
BEGIN    
    -- variables
    DECLARE _phone_num_id INT UNSIGNED;

    -- validate session token
    CALL sp_validate_admin(_session);    

    -- fetch phone number id
    SELECT phone_num_id
        INTO _phone_num_id 
        FROM phone_numbers
        WHERE value = _phone_num;

    -- insert or delete row
    IF _boolean THEN
        INSERT INTO blacklist (phone_num_id)    
            VALUES (_phone_num_id);
    ELSE
        DELETE FROM blacklist
            WHERE phone_num_id = _phone_num_id;
    END IF;
END;