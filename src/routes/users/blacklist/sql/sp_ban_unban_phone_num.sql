DROP PROCEDURE IF EXISTS sp_ban_unban_phone_num;

CREATE PROCEDURE sp_ban_unban_phone_num(
    IN _session JSON,
    IN _phone_num VARCHAR(30),
    IN _boolean BOOLEAN
)
BEGIN    
    -- variables
    DECLARE phone_num_id_ INT UNSIGNED;

    -- validate session token
    CALL sp_validate_admin(_session);    

    -- fetch phone number id
    CALL sp_get_phone_num_id(_phone_num, phone_num_id_);

    -- insert or delete row
    IF _boolean THEN
        INSERT INTO blacklist (phone_num_id)    
            VALUES (phone_num_id_);
    ELSE
        DELETE FROM blacklist
            WHERE phone_num_id = phone_num_id_;
    END IF;
END;