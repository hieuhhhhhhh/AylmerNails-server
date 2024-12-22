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

    -- Fetch needed data from table
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

        -- if token is exposed
        IF session_salt_ != _session_salt THEN
            -- log out user in all sessions
            DELETE FROM user_sessions
            WHERE user_id = user_id_;

            -- Reset return data to nulls
            SET user_id_ = NULL;
            SET is_expired_ = NULL;
            SET remember_me_ = NULL;
        END IF;  
    END IF;
 
    SELECT user_id_ AS user_id, is_expired_ AS is_expired, remember_me_ AS remember_me;
END;