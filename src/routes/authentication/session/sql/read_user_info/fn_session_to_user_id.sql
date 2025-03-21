DROP FUNCTION IF EXISTS fn_session_to_user_id;

CREATE FUNCTION fn_session_to_user_id(
    IN _session JSON
)
RETURNS INT UNSIGNED
DETERMINISTIC
BEGIN
    -- variables
    DECLARE session_id_ INT UNSIGNED;
    DECLARE user_id_ INT UNSIGNED;

    -- fetch session id
    SET session_id_ = JSON_UNQUOTE(JSON_EXTRACT(_session, '$.id'));

    -- fetch and return user id 
    SELECT user_id
        INTO user_id_
        FROM user_sessions
        WHERE id = session_id;

    RETURN user_id_;
END;