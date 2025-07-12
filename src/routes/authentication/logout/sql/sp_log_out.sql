DROP PROCEDURE IF EXISTS sp_log_out;

CREATE PROCEDURE sp_log_out(
    IN _session_id INT UNSIGNED
)
BEGIN
    DELETE FROM user_sessions
        WHERE id = _session_id;
END;