DROP FUNCTION IF EXISTS fn_get_user_role;

CREATE FUNCTION fn_get_user_role(
    _session_id INT UNSIGNED,
    _session_salt INT
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    -- placeholders
    DECLARE role_ VARCHAR(20);
    DECLARE expiry_ INT;      
    DECLARE created_at_ BIGINT;

    -- fetch role by session id and salt
    SELECT us.expiry, us.created_at, a.role 
        INTO expiry_, created_at_, role_
        FROM user_sessions us
            JOIN authentication a
            ON us.user_id = a.user_id
        WHERE us.id = _session_id
            AND us.session_salt = _session_salt;

    -- if not expired, return role
    IF (created_at_ + expiry_) >= UNIX_TIMESTAMP() 
    THEN
        RETURN role_;
    ELSE
        RETURN NULL; -- Or some default value
    END IF;
END;
