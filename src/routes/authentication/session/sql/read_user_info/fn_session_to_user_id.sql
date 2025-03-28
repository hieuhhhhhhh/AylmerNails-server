DROP FUNCTION IF EXISTS fn_session_to_user_id;


CREATE FUNCTION fn_session_to_user_id(
    _session VARCHAR(500) 
)
RETURNS INT UNSIGNED
DETERMINISTIC
BEGIN
    -- Variables
    DECLARE session_id_ INT UNSIGNED;
    DECLARE user_id_ INT UNSIGNED;

    -- Extract session id from the JSON string
    SET session_id_ = JSON_UNQUOTE(JSON_EXTRACT(_session, '$.id'));

    -- Fetch and return user id
    SELECT user_id
        INTO user_id_
        FROM user_sessions us
        WHERE id = session_id_;

    RETURN user_id_;
END;
