DROP PROCEDURE IF EXISTS sp_validate_client;

CREATE PROCEDURE sp_validate_client(
    IN _session JSON
)
BEGIN
    -- placeholders
    DECLARE user_id_ INT UNSIGNED;
    DECLARE role_ VARCHAR(20);
    
    -- fetch and validate user's role from session data
    CALL sp_get_user_id_role(_session, user_id_, role_);

    -- IF role is not valid, leave procedure
    IF role_ IS NULL
        OR role_ NOT IN ('client', 'employee', 'admin', 'developer')
    THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '401, Unauthorized';
    END IF;


END;