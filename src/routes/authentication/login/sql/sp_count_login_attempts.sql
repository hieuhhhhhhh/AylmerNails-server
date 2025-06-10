DROP PROCEDURE IF EXISTS sp_count_login_attempts;

CREATE PROCEDURE sp_count_login_attempts(
    IN _phone_num VARCHAR(30)
)
BEGIN
    -- get attempt count
    SELECT COUNT(*)
        FROM login_attempts l
            JOIN authentication a
                ON a.user_id = l.user_id
            JOIN phone_numbers p
                ON a.phone_num_id = p.phone_num_id
        WHERE p.value = _phone_num
            AND l.created_at >= UNIX_TIMESTAMP() - 7*24*60*60;

    CALL sp_add_login_attempt(_phone_num);
END;