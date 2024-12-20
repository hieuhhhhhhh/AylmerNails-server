DROP PROCEDURE IF EXISTS sp_store_code;

CREATE PROCEDURE sp_store_code (
    IN p_phone_number VARCHAR(15),
    IN p_code VARCHAR(4),
    IN p_attempts_left INT
) BEGIN
INSERT INTO
    sms_verify_codes (
        phone_number,
        code,
        attempts_left,
        created_at
    )
VALUES
    (
        p_phone_number,
        p_code,
        p_attempts_left,
        UNIX_TIMESTAMP()
    ) ON DUPLICATE KEY
UPDATE
    code =
VALUES
(code),
    attempts_left =
VALUES
(attempts_left),
    created_at =
VALUES
(created_at);

END;