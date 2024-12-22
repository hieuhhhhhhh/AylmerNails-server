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
        -- write a new salt and store it on another table (next request will update session with this salt)
        INSERT INTO unconfirmed_salts (session_id, new_salt)
        VALUES (_session_id, session_salt_);

        -- Return the session_id and new salt
        SELECT _session_id, session_salt_;
    END IF;

END