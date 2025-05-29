DROP PROCEDURE IF EXISTS sp_verify_code;

CREATE PROCEDURE sp_verify_code(
    IN _code_id INT UNSIGNED,
    IN _value VARCHAR(4)
)
sp:BEGIN
    SELECT phone_num_id
        FROM otp_codes 
        WHERE code_id = _code_id 
            AND created_at + duration >= UNIX_TIMESTAMP()
            AND attempts_left > 0
            AND value = _value;
END;