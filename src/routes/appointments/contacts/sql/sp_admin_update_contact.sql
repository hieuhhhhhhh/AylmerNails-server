DROP PROCEDURE IF EXISTS sp_admin_update_contact;

CREATE PROCEDURE sp_admin_update_contact(    
    IN _session JSON,
    IN _phone_num VARCHAR(15),
    IN _name VARCHAR(200),
    IN _name_tokens JSON
)
BEGIN
    -- variables
    DECLARE phone_num_id_ INT UNSIGNED;

    -- validate session token
    CALL sp_validate_admin(_session);

    -- get phone number id
    CALL sp_get_phone_num_id (_phone_num, phone_num_id_);

    -- create or ignore new contact
    CALL sp_update_contact(_phone_num, _name, _name_tokens, phone_num_id_);

    -- return created id
    SELECT phone_num_id_;
END;
