DROP PROCEDURE IF EXISTS sp_refresh_token;

CREATE PROCEDURE sp_refresh_token(
    IN _session_id INT UNSIGNED,
    IN _session_salt INT
)
sp:BEGIN
    -- data required for process
    DECLARE is_expired_ BOOLEAN;
    DECLARE remember_me_ BOOLEAN;

    -- fetch data from a procedure
    CALL sp_verify_token();
    SELECT  is_expired, remember_me INTO  is_expired_, remember_me_;

    IF remember_me_ THEN
        -- refresh birth time and assign a new salt to session
        UPDATE user_sessions
        SET session_salt = FLOOR(RAND() * 1000000000), created_at = UNIX_TIMESTAMP()
        WHERE id = _session_id;

        -- Return the session_id and new salt
        SELECT _session_id, session_salt_;
    END IF;

END