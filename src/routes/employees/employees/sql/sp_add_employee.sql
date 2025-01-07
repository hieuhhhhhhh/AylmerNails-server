DROP PROCEDURE IF EXISTS sp_add_employee;

CREATE PROCEDURE sp_add_employee(
    IN _session JSON,
    IN _alias VARCHAR(50),
    IN _first_date BIGINT,
    IN _stored_intervals JSON,
    IN _service_list JSON
)
sp:BEGIN 
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

    -- create new employee
    INSERT INTO employees (alias, stored_intervals, first_date)
        VALUES (_alias, _stored_intervals, _first_date);
    
    -- set service list for the new employee
    CALL sp_set_employee_services(LAST_INSERT_ID() ,_service_list);

    -- return id of new employee
    SELECT LAST_INSERT_ID();
END; 