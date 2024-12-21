DROP PROCEDURE IF EXISTS sp_verify_code;

CREATE PROCEDURE sp_verify_code(
    IN _phone_number VARCHAR(15),
    IN _code VARCHAR(4),
    IN _lifespan INT
)
sp:BEGIN
    -- Placeholders for data from table
    DECLARE code_ VARCHAR(4);
    DECLARE attempts_left_ INT;
    DECLARE created_at_ BIGINT;
    DECLARE new_password_ VARCHAR(60);

    -- Decrement the attempts left
    UPDATE sms_verify_codes
    SET attempts_left = attempts_left - 1
    WHERE phone_number = _phone_number;

    -- Get the current timestamp and record details
    SELECT new_password, code, attempts_left, created_at INTO new_password_, code_, attempts_left_, created_at_
    FROM sms_verify_codes
    WHERE phone_number = _phone_number;

    -- If the phone number doesn't exist or other failure conditions
    IF code_ IS NULL THEN
        -- Return the failure result set
        SELECT FALSE AS success, 'Code not found, please try again' AS msg;
        LEAVE sp;
    END IF;

    -- Check if the code has expired (using the created_at time + _lifespan)
    IF (UNIX_TIMESTAMP() - created_at_) > _lifespan THEN
        -- Return the failure result set
        SELECT FALSE AS success, 'Code has expired, please request a new code' AS msg;
        LEAVE sp;
    END IF;

    -- Check if there are no remaining attempts
    IF attempts_left_ < 0 THEN
        -- Return the failure result set
        SELECT FALSE AS success, 'No attempts left, please request a new code' AS msg;
        LEAVE sp;
    END IF;

    -- Check if the code is correct
    IF code_ != _code THEN
        -- Return the failure result set
        SELECT FALSE AS success, 'Incorrect code, please try again' AS msg;
        LEAVE sp;
    END IF;

    -- Update the password if new_password column is not null
    IF new_password_ IS NOT NULL THEN
        CALL sp_new_auth(_phone_number, new_password_);
    END IF;

    -- If everything is valid, return success and delete the record
    SELECT TRUE AS success, 'Verification successful.' AS msg;

END;
