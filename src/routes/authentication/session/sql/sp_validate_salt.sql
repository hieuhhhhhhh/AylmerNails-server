DROP PROCEDURE IF EXISTS sp_validate_salt;

CREATE PROCEDURE sp_validate_salt(
    IN _session_id INT UNSIGNED,
    IN _session_salt INT,
    OUT _is_valid BOOLEAN
)
sp:BEGIN
    -- init variables
    DECLARE session_salt_ INT;
    DECLARE user_id_ INT UNSIGNED;

    -- default status
    SET _is_valid = FALSE;

    -- validate if it is new salt that hasnot been confirmed
    SELECT session_salt, user_id
        INTO session_salt_, user_id_
        FROM user_sessions
        WHERE id = _session_id;

    -- if session is not found, then leave with false status
    IF session_salt_ IS NULL THEN     
        LEAVE sp;
    END IF;

    -- if provided salt matches the confirmed salt
    IF session_salt_ = _session_salt THEN
        -- leave with succesful status
        SET _is_valid = TRUE;
        LEAVE sp;
    END IF;

    -- retrieve any unconfirmed salt
    SET session_salt_ = fn_get_unconfirmed_salt(_session_id);

    -- compare provided salt with unconfirmed salt
    IF session_salt_ = _session_salt THEN
        -- if matched, confirm that new salt and refresh birth time of the session (refreshing session)
        CALL sp_confirm_salt(_session_id, _session_salt);

        -- leave with succesful status
        SET _is_valid = TRUE;
        LEAVE sp;
    END IF;

    -- after 2 comparisions, the provided salt not match any, 
    -- this can be a security risk, as this or the confirmed salt is exposed to an intruder
    -- log out all sessions of this user
    CALL sp_log_out_all(user_id_);
END;