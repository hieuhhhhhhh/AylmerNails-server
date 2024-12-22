DROP PROCEDURE IF EXISTS sp_confirm_salt;

CREATE PROCEDURE sp_confirm_salt(
    IN _session_id INT UNSIGNED,
    IN _session_salt INT
)
BEGIN
    -- Update the new salt and birth time of the session (refresh session)
    UPDATE user_sessions
    SET session_salt = _session_salt, created_at = UNIX_TIMESTAMP()
    WHERE id = _session_id;

    -- clean up that new salt on the other table (update completed)
    DELETE FROM unconfirmed_salts
    WHERE session_id = _session_id;
END;