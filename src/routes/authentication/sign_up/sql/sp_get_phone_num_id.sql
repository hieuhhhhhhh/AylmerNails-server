DROP PROCEDURE IF EXISTS sp_get_phone_num_id;

CREATE PROCEDURE sp_get_phone_num_id(
    IN _phone_num VARCHAR(30),
    OUT _phone_num_id INT UNSIGNED
)
sp:BEGIN
    -- validate
    IF _phone_num IS NULL OR LENGTH(_phone_num) < 5
    THEN
        LEAVE sp;
    END IF;

    -- add or ingore phone number
    INSERT IGNORE INTO phone_numbers (value)
        VALUES (_phone_num);
    
    -- fetch phone number id
    SELECT phone_num_id
        INTO _phone_num_id
        FROM phone_numbers
        WHERE value = _phone_num;
END;
