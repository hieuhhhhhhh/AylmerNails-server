DROP PROCEDURE IF EXISTS sp_get_my_profile;

CREATE PROCEDURE sp_get_my_profile(
    IN _session JSON 
)
BEGIN    
    -- variables
    DECLARE user_id_ INT UNSIGNED;

    -- validate session token
    CALL sp_validate_client(_session);

    -- fetch user id
    SET user_id_ = fn_session_to_user_id(_session);

    -- return user details
    CALL sp_get_user_details(user_id_);
END;