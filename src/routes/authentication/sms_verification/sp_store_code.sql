DROP PROCEDURE IF EXISTS s_store_code;

CREATE PROCEDURE s_store_code (
    IN _phone_number VARCHAR(15),
    IN _password VARCHAR(60),
    IN _code VARCHAR(4),
    IN _attempts_left INT
)
BEGIN
    INSERT INTO sms_verify_codes (
        phone_number,
        hashed_password,
        code,
        attempts_left,
        created_at
    )
    VALUES (
        _phone_number,
        _password, 
        _code,
        _attempts_left,
        UNIX_TIMESTAMP()
    )
    ON DUPLICATE KEY UPDATE
        hashed_password = VALUES(hashed_password), 
        code = VALUES(code),
        attempts_left = VALUES(attempts_left),
        created_at = VALUES(created_at);
END;