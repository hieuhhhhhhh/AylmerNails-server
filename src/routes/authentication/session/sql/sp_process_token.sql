DROP PROCEDURE IF EXISTS sp_process_token;

CREATE PROCEDURE sp_process_token(
    IN _session_id INT UNSIGNED,
    IN _session_salt INT,
)
sp:BEGIN
    -- placeholders for output
    DECLARE user_id_ INT DEFAULT NULL;
    DECLARE new_salt INT DEFAULT NULL;

    -- other variables
    DECLARE remember_me_ BOOLEAN ;
    DECLARE created_at_ BIGINT;
    DECLARE expiry_ INT;

    -- Fetch data from sessions table
    SELECT user_id, created_at, expiry, remember_me
    INTO user_id_, created_at_, expiry_, remember_me_
    FROM user_sessions
    WHERE id = _session_id;

    -- validate salt and session existance
    DECLARE is_valid BOOLEAN;
    CALL sp_validate_salt(_session_id, _session_salt, is_valid)

    -- session not found or salt is not valid
    IF NOT is_valid THEN
        SELECT 401;
        LEAVE sp;
    END IF;

    -- if session is expired 
    IF UNIX_TIMESTAMP() > (created_at_ + expiry_) THEN
        -- if remember_me is turned on, generate a new salt and reset birth time (refresh this session)
        IF remember_me THEN 
            CALL sp_generate_salt(_session_id, new_salt);
            -- return green http status, with a new salt
            SELECT 205, user_id_, new_salt;
        
        -- otherwise
        ELSE
            -- clean up expired session and return failed status
            DELETE FROM user_sessions WHERE id = _session_id;
            SELECT 401;
            LEAVE sp;
        END IF;
    END IF;

    -- if session is not expired
    SELECT 200, user_id_;
END;