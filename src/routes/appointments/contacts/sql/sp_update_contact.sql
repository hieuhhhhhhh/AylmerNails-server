DROP PROCEDURE IF EXISTS sp_update_contact;

CREATE PROCEDURE sp_update_contact(    
    IN _phone_num VARCHAR(15),
    IN _name VARCHAR(200),
    OUT _phone_num_id INT UNSIGNED
)
sp:BEGIN
    IF _phone_num IS NULL OR _phone_num = '' THEN
        LEAVE sp;
    END IF;


    -- get phone number id
    CALL sp_get_phone_num_id (_phone_num, _phone_num_id);

    -- overwrite new contact
    INSERT INTO contacts (phone_num_id, name)
        VALUES (_phone_num_id, _name)
        ON DUPLICATE KEY UPDATE
            name = _name,
            time = UNIX_TIMESTAMP();     
            
END;
