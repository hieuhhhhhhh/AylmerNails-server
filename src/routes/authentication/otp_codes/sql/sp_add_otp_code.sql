DROP PROCEDURE IF EXISTS sp_add_otp_code;

CREATE PROCEDURE sp_add_otp_code (
    IN _phone_num VARCHAR(30),
    IN _code VARCHAR(4),
    IN _attempts_left INT,
    IN _duration INT
)
BEGIN
    -- add a new otp code
    INSERT INTO otp_codes (
        phone_num,
        value,
        attempts_left,
        created_at,
        expiry
    )
        VALUES (
            _phone_num,
            _code,
            _attempts_left,
            UNIX_TIMESTAMP(),
            _expiry
        );

    -- return id
    SELECT LAST_INSERT_ID();
END;