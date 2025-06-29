DROP PROCEDURE IF EXISTS sp_log_out_everywhere;

CREATE PROCEDURE sp_log_out_everywhere(
    IN _session JSON
)
BEGIN
    -- delete all session tokens of user
    DELETE FROM user_sessions
        WHERE user_id = fn_session_to_user_id(_session);
END;