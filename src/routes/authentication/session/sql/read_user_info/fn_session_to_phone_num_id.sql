DROP FUNCTION IF EXISTS fn_session_to_phone_num_id;


CREATE FUNCTION fn_session_to_phone_num_id(
    _session VARCHAR(500) 
)
RETURNS INT UNSIGNED
DETERMINISTIC
BEGIN
    -- variables
    DECLARE phone_num_id_ INT UNSIGNED;

    -- fetch, return phone number id
    SELECT phone_num_id
        INTO phone_num_id_
        FROM authentication
        WHERE user_id = fn_session_to_user_id(_session);

    RETURN phone_num_id_;
END;
