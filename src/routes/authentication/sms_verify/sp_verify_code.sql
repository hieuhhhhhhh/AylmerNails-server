DROP PROCEDURE IF EXISTS sp_store_code;

CREATE PROCEDURE sp_verify_code(
    IN phonenum VARCHAR(15),
    IN code VARCHAR(4),
    IN validity_period INT, -- validity period in seconds (e.g., 5*60 for 5 minutes)
    OUT result BOOLEAN,
    OUT message VARCHAR(255)
)
BEGIN
    DECLARE current_time BIGINT;
    DECLARE record_created_at BIGINT;
    DECLARE record_code VARCHAR(4);
    DECLARE record_attempts_left INT;

    -- Get the current timestamp
    SET current_time = UNIX_TIMESTAMP();

    -- Check if the phone number exists in the table
    SELECT code, attempts_left, created_at INTO record_code, record_attempts_left, record_created_at
    FROM sms_verify_codes
    WHERE phone_number = phonenum;

    -- If the phone number doesn't exist
    IF record_code IS NULL THEN
        SET result = FALSE;
        SET message = 'Code not found.';
        LEAVE PROCEDURE;
    END IF;

    -- Check if the code is correct
    IF record_code != code THEN
        SET result = FALSE;
        SET message = 'Incorrect code.';
        LEAVE PROCEDURE;
    END IF;

    -- Check if there are no remaining attempts
    IF record_attempts_left <= 0 THEN
        SET result = FALSE;
        SET message = 'No attempts left for this code.';
        LEAVE PROCEDURE;
    END IF;

    -- Check if the code has expired (using the created_at time + validity_period)
    IF (current_time - record_created_at) > validity_period THEN
        SET result = FALSE;
        SET message = 'Code has expired.';
        LEAVE PROCEDURE;
    END IF;

    -- Decrement the attempts left
    UPDATE sms_verify_codes
    SET attempts_left = attempts_left - 1
    WHERE phone_number = phonenum;

    -- If everything is valid, return success and delete the record
    SET result = TRUE;
    SET message = 'Verification successful.';

    -- Delete the record from the table after successful verification
    DELETE FROM sms_verify_codes WHERE phone_number = phonenum;
    
END