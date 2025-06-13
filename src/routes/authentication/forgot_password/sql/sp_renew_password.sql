DROP PROCEDURE IF EXISTS sp_renew_password;

CREATE PROCEDURE sp_renew_password(
    IN _phone_num VARCHAR(30),
    IN _password VARCHAR(60)
)
BEGIN
    UPDATE authentication a
        JOIN phone_numbers p
            ON a.phone_num_id = p.phone_num_id
        SET a.hashed_password = _password
        WHERE p.value = _phone_num;

    DELETE l
        FROM login_attempts l
            JOIN authentication a
                ON l.user_id = a.user_id
            JOIN phone_numbers p
                ON a.phone_num_id = p.phone_num_id
        WHERE p.value = _phone_num;
END;