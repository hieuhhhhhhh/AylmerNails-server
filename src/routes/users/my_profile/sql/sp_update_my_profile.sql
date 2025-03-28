DROP PROCEDURE IF EXISTS sp_update_my_profile;

CREATE PROCEDURE sp_update_my_profile(
    IN _session JSON,
    IN _first_name VARCHAR(30),
    IN _last_name VARCHAR(30)
)
BEGIN        
    -- validate session token
    CALL sp_validate_client(_session);    

    -- overwrite user details
    UPDATE profiles
        SET 
            first_name = _first_name,
            last_name = _last_name
        WHERE user_id = fn_session_to_user_id(_session);
        
END;