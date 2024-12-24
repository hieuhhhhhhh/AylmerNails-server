DROP PROCEDURE IF EXISTS sp_process_token;

CREATE PROCEDURE sp_process_token(
    IN _session_id INT UNSIGNED,
    IN _session_salt INT
)
sp:BEGIN
    -- init variables
    DECLARE user_id_ INT UNSIGNED DEFAULT NULL;
    DECLARE remember_me_ BOOLEAN ;
    DECLARE created_at_ BIGINT;
    DECLARE expiry_ INT;

    -- helpers
    DECLARE is_valid BOOLEAN;
    DECLARE new_salt INT DEFAULT NULL;              

    -- validate salt and session existance
    CALL sp_validate_salt(_session_id, _session_salt, is_valid);

    -- session not found or salt is not valid
    IF NOT is_valid THEN
        SELECT 401, NULL, NULL;
        LEAVE sp;
    END IF;

    -- Fetch required data from user_sessions
    SELECT user_id, created_at, expiry, remember_me
    INTO user_id_, created_at_, expiry_, remember_me_
    FROM user_sessions
    WHERE id = _session_id;

    -- if session has not expired 
    IF UNIX_TIMESTAMP() <= (created_at_ + expiry_) THEN
        -- if session is not expired
        SELECT 200, user_id_, NULL;
        LEAVE sp;
    END IF;

    -- if session has expired but remember_me is turned on
    IF remember_me_ THEN 
        CALL sp_generate_salt(_session_id, new_salt);
        -- return green http status, with a new salt
        SELECT 205, user_id_, new_salt;
        LEAVE sp;
    END IF;

    -- if session has expired 
    DELETE FROM user_sessions WHERE id = _session_id;
    SELECT 401, NULL, NULL;
END;