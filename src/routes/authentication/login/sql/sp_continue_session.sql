DROP PROCEDURE IF EXISTS sp_continue_session;

CREATE PROCEDURE sp_continue_session(
    IN _session_id INT UNSIGNED,
    IN _session_salt INT
)
sp:BEGIN
    DECLARE user_id_ INT DEFAULT NULL;
    DECLARE session_salt_ INT DEFAULT NULL;
    DECLARE created_at_ BIGINT;
    DECLARE remember_me_ BOOLEAN;
    DECLARE expiry_ INT;

    -- Fetch needed data from table
    SELECT user_id, session_salt, created_at, expiry, remember_me
    INTO user_id_, session_salt_, created_at_, expiry_, remember_me_
    FROM user_sessions
    WHERE id = _session_id
    LIMIT 1;

    -- If no session is found, exit procedure
    IF user_id_ IS NULL THEN
        LEAVE sp;
    END IF;

    -- If session is expired and remember_me is not on, exit procedure
    IF UNIX_TIMESTAMP() > (created_at_ + expiry_) AND NOT remember_me_ THEN
        LEAVE sp;
    END IF;
    
    -- Check if the provided salt matches the stored salt
    IF session_salt_ = _session_salt THEN
        -- Salt matches: Generate a new salt
        SET session_salt_ = FLOOR(RAND() * 1000000000);
        
        -- Update the new salt and birth time of the session (refresh session)
        UPDATE user_sessions
        SET session_salt = session_salt_, created_at = UNIX_TIMESTAMP()
        WHERE id = _session_id;
        
        -- Return the session_id and updated session_salt
        SELECT _session_id, session_salt_;
    ELSE
        -- Salt doesn't match (security risk): delete all active sessions of that user
        DELETE FROM user_sessions
        WHERE user_id = user_id_;
    END IF;
END