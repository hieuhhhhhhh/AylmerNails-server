DROP FUNCTION IF EXISTS fn_get_user_id;

CREATE FUNCTION fn_get_user_id(
    _session_id INT UNSIGNED
)
RETURNS INT UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE _user_id INT DEFAULT NULL;

    SELECT user_id 
    INTO _user_id
    FROM user_sessions
    WHERE session_id = _session_id;

    RETURN _user_id;
END;
