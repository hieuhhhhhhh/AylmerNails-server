DROP PROCEDURE IF EXISTS sp_is_phonenum_avail;

CREATE PROCEDURE sp_is_phonenum_avail(
    IN input_phone_number VARCHAR(15)
)
BEGIN
    SELECT NOT EXISTS (
        SELECT 1
        FROM authentication
        WHERE phone_number = input_phone_number
    ) AS PhoneExists;
END