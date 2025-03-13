DROP PROCEDURE IF EXISTS sp_add_contact;

CREATE PROCEDURE sp_add_contact(
    IN _session JSON,
    IN _phone_num VARCHAR(15),
    IN _name VARCHAR(200)
)
BEGIN
    -- variables
    DECLARE phone_num_id_ INT UNSIGNED;

    -- validate session
    CALL sp_validate_admin(_session);

    -- get phone number id
    CALL sp_get_phone_num_id (_phone_num, phone_num_id_);

    -- insert to new contact
    INSERT INTO contacts (phone_num_id, name)
        VALUES (phone_num_id_, _name)
        ON DUPLICATE KEY UPDATE
            name = _name;     

    -- return last used ID
    SELECT phone_num_id_;
END;
