DROP PROCEDURE IF EXISTS sp_store_code;

CREATE PROCEDURE sp_store_code (
    IN _phone_number VARCHAR(15),
    IN _new_password VARCHAR(60),
    IN _code VARCHAR(4),
    IN _attempts_left INT,
    IN _expiry INT
)
BEGIN
    -- variable
    DECLARE phone_num_id_ INT UNSIGNED;

    -- get phone number id
    CALL sp_get_phone_num_id (_phone_number, phone_num_id_);

    INSERT INTO sms_verify_codes (
        phone_num_id,
        new_password,
        code,
        attempts_left,
        created_at,
        expiry
    )
        VALUES (
            phone_num_id_,
            _new_password, 
            _code,
            _attempts_left,
            UNIX_TIMESTAMP(),
            _expiry
        )
        ON DUPLICATE KEY UPDATE
            new_password = _new_password, 
            code = _code,
            attempts_left = _attempts_left,
            created_at =  UNIX_TIMESTAMP(),
            expiry = _expiry;
END;