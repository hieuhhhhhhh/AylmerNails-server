DROP PROCEDURE IF EXISTS sp_remove_otp_code;

CREATE PROCEDURE sp_remove_otp_code(
    IN _code_id INT UNSIGNED
)
sp:BEGIN
    -- remove row 
    DELETE FROM otp_codes
        WHERE code_id = _code_id;
END;