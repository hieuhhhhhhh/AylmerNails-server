DROP PROCEDURE IF EXISTS sp_get_user_id_role;

CREATE PROCEDURE sp_get_user_id_role(
    IN _session JSON,
    OUT _user_id INT UNSIGNED,
    OUT _role VARCHAR(20)
)
BEGIN
    -- placeholders
    DECLARE session_id_ INT UNSIGNED,
    DECLARE session_salt_ INT,
    DECLARE expiry_ INT;      
    DECLARE created_at_ BIGINT;

    -- fetch id and salt from session
    SET @session_id_ = JSON_UNQUOTE(JSON_EXTRACT(_session, '$.id'));
    SET @session_salt_ = JSON_UNQUOTE(JSON_EXTRACT(_session, '$.salt'));


    -- fetch role and user_id by session id and salt
    SELECT us.expiry, us.created_at, a.role, a.user_id
        INTO expiry_, created_at_, _role, _user_id
        FROM user_sessions us
            JOIN authentication a
            ON us.user_id = a.user_id
        WHERE us.id = _session_id
            AND us.session_salt = _session_salt;

    -- if expired, set outputs back to NULL
    IF (created_at_ + expiry_) < UNIX_TIMESTAMP() THEN
        SET _role = NULL; 
        SET _user_id = NULL;
    END IF;
END;


