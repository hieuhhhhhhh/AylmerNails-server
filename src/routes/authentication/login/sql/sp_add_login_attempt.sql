DROP PROCEDURE IF EXISTS sp_add_login_attempt;

CREATE PROCEDURE sp_add_login_attempt(
    IN _phone_num VARCHAR(30)
)
BEGIN
    -- add a login attempt
    INSERT INTO login_attempts (user_id, created_at)
        SELECT a.user_id, UNIX_TIMESTAMP()
            FROM authentication a
                JOIN phone_numbers p 
                    ON a.phone_num_id = p.phone_num_id
            WHERE p.value = _phone_num;

END;