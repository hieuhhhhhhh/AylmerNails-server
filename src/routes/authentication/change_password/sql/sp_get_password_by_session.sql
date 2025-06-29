DROP PROCEDURE IF EXISTS sp_get_password_by_session;

CREATE PROCEDURE sp_get_password_by_session(
    IN _session JSON
)
BEGIN
    SELECT hashed_password
        FROM authentication 
        WHERE user_id = fn_session_to_user_id(_session);
END;