DROP PROCEDURE IF EXISTS sp_verify_token;

CREATE PROCEDURE sp_verify_token(
    IN _session_id INT UNSIGNED,
    IN _session_salt INT,
)
sp:BEGIN
    -- placeholders for output
    DECLARE user_id_ INT DEFAULT NULL;
    DECLARE is_expired_ BOOLEAN DEFAULT NULL;
    DECLARE remember_me_ BOOLEAN DEFAULT NULL;

    -- other placeholders
    DECLARE session_salt_ INT DEFAULT NULL;
    DECLARE created_at_ BIGINT;
    DECLARE expiry_ INT;

    -- Fetch data from sessions table
    SELECT user_id, session_salt, created_at, expiry, remember_me
    INTO user_id_, session_salt_, created_at_, expiry_, remember_me_
    FROM user_sessions
    WHERE id = _session_id
    LIMIT 1;

    -- If session is found, start validating token
    IF user_id_ IS NOT NULL THEN
        -- If session is expired
        IF UNIX_TIMESTAMP() < (created_at_ + expiry_) THEN
            SET is_expired_ = FALSE;
        END IF;

        -- if the token has been updated or token is exposed
        IF session_salt_ != _session_salt THEN
            -- validate if it is new salt that hasnot been confirmed
            SELECT new_salt 
            INTO session_salt_
            FROM unconfirmed_salts
            WHERE session_id = _session_id;

            -- if it is truely a new salt, overwrite the salt of this table
            IF session_salt_ = _session_salt THEN
                -- Update the new salt and birth time of the session (refresh session)
                UPDATE user_sessions
                SET session_salt = session_salt_, created_at = UNIX_TIMESTAMP()
                WHERE id = _session_id;

                -- clean up that new salt on the other table (update completed)
                DELETE FROM unconfirmed_salts
                WHERE session_id = _session_id;
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
    END IF;
 
    SELECT user_id_ AS user_id, is_expired_ AS is_expired, remember_me_ AS remember_me;
END;