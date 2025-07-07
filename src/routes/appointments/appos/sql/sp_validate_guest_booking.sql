DROP PROCEDURE IF EXISTS sp_validate_guest_booking;

CREATE PROCEDURE sp_validate_guest_booking(
    IN _code_id INT UNSIGNED,
    IN _name VARCHAR(200),
    in _name_tokens JSON
)
BEGIN
    -- variables
    DECLARE code_ VARCHAR(20);
    DECLARE phone_num_ VARCHAR(30);
    DECLARE phone_num_id_ INT UNSIGNED;
    
    -- fetch the associated phone num
    SELECT phone_num, value
        INTO phone_num_, code_
        FROM otp_codes 
        WHERE code_id = _code_id 
            AND created_at + duration >= UNIX_TIMESTAMP() -- not expired
            AND attempts_left > 0; -- still available
    
    -- fetch phone num id
    CALL sp_get_phone_num_id (phone_num_, phone_num_id_);

    -- decrease the attempts
    UPDATE otp_codes
        SET attempts_left = attempts_left - 1
        WHERE code_id = _code_id;

    -- add contact if not exists
    INSERT IGNORE  INTO contacts (phone_num_id, name)
        VALUES (phone_num_id_, _name);
    IF ROW_COUNT() > 0 THEN
        CALL sp_store_contact_tokens (phone_num_id_, _name_tokens);
    END IF;

    -- return details
    SELECT code_, phone_num_id_;
END;

