DROP PROCEDURE IF EXISTS sp_process_token;

CREATE PROCEDURE sp_process_token(
    IN _session_id INT UNSIGNED,
    IN _session_salt INT,
)
sp:BEGIN
    -- placeholders for output
    DECLARE http_status_ SMALLINT DEFAULT 401;
    DECLARE user_id_ INT DEFAULT NULL;
    DECLARE session_salt_ INT DEFAULT NULL;

    -- other variables
    DECLARE remember_me_ BOOLEAN DEFAULT NULL;
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
            IF remember_me_ THEN
                -- Check if the provided salt matches the stored salt
                IF session_salt_ = _session_salt THEN
                    -- generate a new salt
                    CALL sp_generate_salt(_session_id, session_salt_);
                    
                    -- Return the session_id and updated session_salt
                    SELECT _session_id, session_salt_;
                ELSE
                    -- validate if it is new salt that hasnot been confirmed
                    SET session_salt_ = fn_get_unconfirmed_salt(_session_id);

                    -- if it is a new salt overwrite that on this table
                    IF session_salt_ = _session_salt THEN
                        -- Update the new salt and birth time of the session (refresh session)
                        CALL sp_confirm_salt(_session_id, _session_salt);
                    ELSE
                        -- Salt doesn't match (security risk): delete all active sessions of this user
                        CALL sp_log_out_all(user_id_);
                    END IF;
                END IF;
            ELSE
                DELETE FROM user_sessions WHERE id = _session_id

        END IF;
    END IF;

    SELECT http_status_ AS http_status_, user_id_ AS user_id, _session_id AS session_id, session_salt_ AS session_salt;
END;