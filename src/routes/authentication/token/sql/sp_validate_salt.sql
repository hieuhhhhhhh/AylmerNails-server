DROP PROCEDURE IF EXISTS sp_validate_salt;

CREATE PROCEDURE sp_validate_salt(
    IN _session_id INT UNSIGNED,
    IN _session_salt INT
)
sp:BEGIN
    -- init variables
    DECLARE session_salt_ INT DEFAULT NULL;

    -- Fetch data from sessions table
    SELECT user_id, session_salt, created_at, expiry, remember_me
    INTO user_id_, session_salt_, created_at_, expiry_, remember_me_
    FROM user_sessions
    WHERE id = _session_id
    LIMIT 1;

    IF session_salt_ != _session_salt THEN
        -- validate if it is new salt that hasnot been confirmed
        SELECT new_salt 
        INTO session_salt_
        FROM unconfirmed_salts
        WHERE session_id = _session_id;

        -- if it is truely a new salt, overwrite the salt of this table
        IF session_salt_ = _session_salt THEN
            -- Update the new salt and birth time of the session (refresh session)
            CALL sp_confirm_salt(_session_salt)
        ELSE:
            -- Salt doesn't match (security risk): delete all active sessions of this user
            DELETE FROM user_sessions
            WHERE user_id = user_id_;

            -- Reset return data to nulls
            SET user_id_ = NULL;
            SET is_expired_ = NULL;
            SET remember_me_ = NULL;
        END IF;              
    END IF;  
END;