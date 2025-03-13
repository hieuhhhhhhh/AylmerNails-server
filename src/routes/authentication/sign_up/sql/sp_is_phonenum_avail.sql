DROP PROCEDURE IF EXISTS sp_is_phonenum_avail;

CREATE PROCEDURE sp_is_phonenum_avail(
    IN _phone_num VARCHAR(15)
)
BEGIN
    SELECT NOT EXISTS (
        SELECT 1
            FROM authentication a
                JOIN phone_numbers p
            WHERE p.value = _phone_num
    ) AS PhoneExists;
END