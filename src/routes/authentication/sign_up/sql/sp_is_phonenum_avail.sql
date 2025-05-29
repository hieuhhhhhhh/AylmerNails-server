DROP PROCEDURE IF EXISTS sp_is_phonenum_avail;

CREATE PROCEDURE sp_is_phonenum_avail(
    IN _phone_num VARCHAR(15)
)
BEGIN
    SELECT NOT EXISTS (
        SELECT 1
            FROM authentication a
                JOIN phone_numbers p
                    ON p.phone_num_id = a.phone_num_id
            WHERE p.value = _phone_num
    ) AS PhoneExists;
END