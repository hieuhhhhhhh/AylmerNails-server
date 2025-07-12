DROP PROCEDURE IF EXISTS sp_update_user_role;

CREATE PROCEDURE sp_update_user_role(
    IN _session JSON,
    IN _user_id INT UNSIGNED,
    IN _role VARCHAR(50)
)
BEGIN    
    -- variables
    DECLARE role_ VARCHAR(50);

    -- validate session token
    CALL sp_validate_owner(_session);    

    -- fetch role of user
    SELECT role
        INTO role_
        FROM authentication 
        WHERE user_id= _user_id;

    -- validate role
    IF role_ IN ('owner')
    THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '400, Can not change role of owners';
    END IF;

    -- update role
    UPDATE authentication
        SET role = _role            
        WHERE user_id = _user_id;
END;