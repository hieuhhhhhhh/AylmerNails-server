DROP PROCEDURE IF EXISTS sp_get_otp_code;

CREATE PROCEDURE sp_get_otp_code(
    IN _code_id INT UNSIGNED
)
sp:BEGIN
    -- variables
    DECLARE code_ VARCHAR(20);
    DECLARE phone_num_ VARCHAR(30);

    -- fetch the associated phone num
    SELECT phone_num, value
        INTO phone_num_, code_
        FROM otp_codes 
        WHERE code_id = _code_id 
            AND created_at + duration >= UNIX_TIMESTAMP() -- not expired
            AND attempts_left > 0; -- still available

    -- decrease the attempts
    UPDATE otp_codes
        SET attempts_left = attempts_left - 1
        WHERE code_id = _code_id;
    
    -- return details
    SELECT code_, phone_num_;
END;