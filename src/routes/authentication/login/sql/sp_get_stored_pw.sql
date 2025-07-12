DROP PROCEDURE IF EXISTS sp_get_stored_pw;

CREATE PROCEDURE sp_get_stored_pw(IN _phone_num VARCHAR(30))
BEGIN
    SELECT a.user_id, a.hashed_password
        FROM authentication a
            JOIN phone_numbers p
                ON a.phone_num_id = p.phone_num_id
        WHERE p.value = _phone_num;
END;