DROP PROCEDURE IF EXISTS sp_update_user_role;

CREATE PROCEDURE sp_update_user_role(
    IN _session JSON,
    IN _user_id INT UNSIGNED,
    IN _role VARCHAR(50)
)
BEGIN    
    -- validate session token
    CALL sp_validate_owner(_session);    

    -- update role
    UPDATE authentication
        SET role = _role            
        WHERE user_id = _user_id;
END;