DROP PROCEDURE IF EXISTS sp_get_login_info;

CREATE PROCEDURE sp_get_login_info(
    IN _user_id INT UNSIGNED    
)
BEGIN
    -- validate blacklist
    IF EXISTS (
        SELECT 1
            FROM blacklist b
                JOIN authentication a
                    ON a.phone_num_id = b.phone_num_id
            WHERE a.user_id = _user_id
    )   
    THEN
        -- remove all sessions of this phone num
        DELETE
            FROM user_sessions
                WHERE user_id = _user_id;

        -- throw exception
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '403, restricted phone number';
    END IF;

    -- variables
    SELECT role
        FROM authentication
        WHERE user_id = _user_id;        
END;