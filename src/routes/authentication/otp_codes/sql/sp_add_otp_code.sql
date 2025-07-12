DROP PROCEDURE IF EXISTS sp_add_otp_code;

CREATE PROCEDURE sp_add_otp_code (
    IN _phone_num VARCHAR(30),
    IN _code VARCHAR(20),
    IN _attempts_left INT,
    IN _duration INT
)
BEGIN
    -- validate blacklist
    IF EXISTS (
        SELECT 1
            FROM blacklist b
                JOIN phone_numbers p
                    ON p.phone_num_id = b.phone_num_id
            WHERE p.value = _phone_num
    )   
    THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '403, restricted phone number';
    END IF;

    -- add a new otp code
    INSERT INTO otp_codes (
        phone_num,
        value,
        attempts_left,
        duration
    )
        VALUES (
            _phone_num,
            _code,
            _attempts_left,
            _duration
        );

    -- return id
    SELECT LAST_INSERT_ID();
END;