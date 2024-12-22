DROP PROCEDURE IF EXISTS sp_log_out_all;

CREATE PROCEDURE sp_log_out_all(
    IN _user_id INT UNSIGNED
)
BEGIN
    -- Salt doesn't match (security risk): delete all active sessions of this user
    DELETE FROM user_sessions
    WHERE user_id = _user_id;
END;