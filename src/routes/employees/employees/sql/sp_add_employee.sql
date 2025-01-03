DROP PROCEDURE IF EXISTS sp_add_employee;

CREATE PROCEDURE sp_add_employee(
    IN _session JSON,
    IN _alias VARCHAR(50),
    IN _first_date BIGINT
)
BEGIN 
    -- placeholders
    DECLARE user_id_ INT UNSIGNED;
    DECLARE role_ VARCHAR(20);
    
    -- fetch and validate user's role from session data
    CALL sp_get_user_id_role(_session, user_id_, role_);

    -- IF role is not valid return null and leave procedure
    IF role_ IS NULL
        OR role_ NOT IN ('admin', 'developer')
    THEN 
        SELECT NULL;
        LEAVE sp;
    END IF;

    -- Insert the new category into the categories table
    INSERT INTO employees (alias, first_date)
        VALUES (_alias, _first_date);
    
    -- Optionally, you could return the last inserted ID
    SELECT LAST_INSERT_ID();
END; 