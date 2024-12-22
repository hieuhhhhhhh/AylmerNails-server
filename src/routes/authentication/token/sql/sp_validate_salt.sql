DROP PROCEDURE IF EXISTS sp_validate_salt;

CREATE PROCEDURE sp_validate_salt(
    IN _session_id INT UNSIGNED,
    IN _session_salt INT,
    OUT _http_status SMALLINT,
)
BEGIN
    -- default status
    SET _http_status = 401;

    -- init variables
    DECLARE session_salt_ INT DEFAULT NULL;

    -- validate if it is new salt that hasnot been confirmed
    SELECT session_salt
    INTO session_salt_
    FROM user_sessions
    WHERE id = _session_id;

    -- compare provided salt with confirmed salt
    IF session_salt_ = _session_salt THEN
        -- update status (succesful)
        SET _http_status = 200;    
    ELSE
        -- retrieve any unconfirmed salt
        SET session_salt_ = fn_get_unconfirmed_salt(_session_id);

        -- compare provided salt with unconfirmed salt
        IF session_salt_ = _session_salt THEN
            -- if matched, confirm the new salt and birth time of the session (refresh session)
            CALL sp_confirm_salt(_session_id, _session_salt);

            -- update status (succesful)
            SET _http_status = 200;
        ELSE
            -- provided salt not match both confirmed and unconfirmed => potentially an exposed salt
            -- log out all sessions of this user
            CALL sp_log_out_all(user_id_);

            -- update status (unauthorized)
            SET _http_status = 401;
        END IF;
    END IF;
END;