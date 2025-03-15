DROP PROCEDURE IF EXISTS sp_update_contact;

CREATE PROCEDURE sp_update_contact(    
    IN _phone_num VARCHAR(15),
    IN _name VARCHAR(200),
    IN _name_tokens JSON
)
BEGIN
    -- variables
    DECLARE phone_num_id_ INT UNSIGNED;

    -- get phone number id
    CALL sp_get_phone_num_id (_phone_num, phone_num_id_);

    -- store tokens
    CALL sp_store_contact_tokens (phone_num_id_, _name_tokens);

    -- create or ignore new contact
    INSERT INTO contacts (phone_num_id, name)
        VALUES (phone_num_id_, _name)
        ON DUPLICATE KEY UPDATE
            name = _name;     

    -- return last used ID
    SELECT phone_num_id_;
END;
