DROP PROCEDURE IF EXISTS sp_get_stored_pw;

CREATE PROCEDURE sp_get_stored_pw(IN phone_num VARCHAR(15))
BEGIN
    SELECT a.user_id, a.hashed_password
        FROM authentication a
            JOIN phone_numbers p
        WHERE p.value = phone_num;
END;