DROP PROCEDURE IF EXISTS sp_validate_guest_booking;

CREATE PROCEDURE sp_validate_guest_booking(
    IN _code_id INT UNSIGNED,
    IN _code VARCHAR(20)
)
BEGIN
    -- return phone_num_id from otp
    SELECT phone_num_id
        FROM otp_codes o
            JOIN phone_numbers p
                ON p.value = o.phone_num
        WHERE o.code_id = _code_id 
            AND o.created_at + o.duration >= UNIX_TIMESTAMP() -- not expired
            AND o.attempts_left > 0 -- still available
            AND o.value = _code; -- correct code

    -- decrease the attempts
    UPDATE otp_codes
        SET attempts_left = attempts_left - 1
        WHERE code_id = _code_id;
END;

