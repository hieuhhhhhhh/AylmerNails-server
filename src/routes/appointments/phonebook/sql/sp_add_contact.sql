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

    -- insert or ignore phone number
    INSERT IGNORE INTO phone_numbers (value)
        VALUES (_phone_num);

    -- fetch phone number id
    SELECT phone_num_id
        INTO phone_num_id_
        FROM phone_numbers
        WHERE value = _phone_num;

    -- insert to phone book
    INSERT INTO contacts (phone_num_id, name)
        VALUES (phone_num_id_, _name)
        ON DUPLICATE KEY UPDATE
            name = _name;     

    -- return last used ID
    SELECT phone_num_id_;
END;
