DROP PROCEDURE IF EXISTS sp_change_password;

CREATE PROCEDURE sp_change_password(
    IN _session JSON,
    IN _new_password VARCHAR(60)
)
BEGIN
    -- update password by user id
    UPDATE authentication 
        SET hashed_password = _new_password
        WHERE user_id = fn_session_to_user_id(_session);

    IF ROW_COUNT() = 0 THEN        
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '400, Invalid session token';
    END IF;
END;