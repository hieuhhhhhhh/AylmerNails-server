DROP PROCEDURE IF EXISTS sp_verify_code;

CREATE PROCEDURE sp_verify_code(
    IN phonenum VARCHAR(15),
    IN code VARCHAR(4),
    IN lifespan INT, 
    OUT success BOOLEAN,
    OUT msg VARCHAR(255)
)
sp: BEGIN
    -- Decrement the attempts left
    UPDATE sms_verify_codes
    SET attempts_left = attempts_left - 1
    WHERE phone_number = phonenum;

    -- placeholders for data from table
    DECLARE _code VARCHAR(4);
    DECLARE _attempts_left INT;
    DECLARE _created_at BIGINT;

    -- Get the current timestamp and record details
    SELECT code, attempts_left, created_at INTO _code, _attempts_left, _created_at
    FROM sms_verify_codes
    WHERE phone_number = phonenum;

    -- If the phone number doesn't exist or other failure conditions
    IF _code IS NULL THEN
        SET success = FALSE;
        SET msg = 'Code not found.';
        LEAVE sp;
    END IF;

    -- Check if the code is correct
    IF _code != code THEN
        SET success = FALSE;
        SET msg = 'Incorrect code.';
        LEAVE sp;
    END IF;

    -- Check if there are no remaining attempts
    IF _attempts_left < 0 THEN
        SET success = FALSE;
        SET msg = 'No attempts left for this code.';
        LEAVE sp;
    END IF;

    -- Check if the code has expired (using the created_at time + lifespan)
    IF (UNIX_TIMESTAMP() - _created_at) > lifespan THEN
        SET success = FALSE;
        SET msg = 'Code has expired.';
        LEAVE sp;
    END IF;

    -- If everything is valid, return success and delete the record
    SET success = TRUE;
    SET msg = 'Verification successful.';

    -- Delete the record from the table after successful verification
    DELETE FROM sms_verify_codes WHERE phone_number = phonenum;

END;
