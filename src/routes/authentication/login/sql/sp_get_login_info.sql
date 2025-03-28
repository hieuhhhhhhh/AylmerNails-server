DROP PROCEDURE IF EXISTS sp_get_login_info;

CREATE PROCEDURE sp_get_login_info(
    IN _user_id INT UNSIGNED    
)
BEGIN
    -- variables
    SELECT role
        FROM authentication
        WHERE user_id = _user_id;        
END;