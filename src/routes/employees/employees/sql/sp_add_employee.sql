DROP PROCEDURE IF EXISTS sp_add_employee;

CREATE PROCEDURE sp_add_employee(
    IN _session JSON,
    IN _alias VARCHAR(50),
    IN _stored_intervals JSON,
    IN _interval_percent SMALLINT,
    IN _color_id INT UNSIGNED,
    IN _service_ids JSON
)
sp:BEGIN 
    DECLARE emp_id_ INT UNSIGNED;

    -- validate session token
    CALL sp_validate_admin(_session);

    -- create new employee
    INSERT INTO employees (alias, stored_intervals, interval_percent, color_id )
        VALUES (_alias, _stored_intervals, _interval_percent, _color_id);
    
    -- fetch id of new service
    SET emp_id_ = LAST_INSERT_ID();
    
    -- set service list for the new employee
    CALL sp_set_ESs(LAST_INSERT_ID() ,_service_ids);

    -- return id of new employee
    SELECT LAST_INSERT_ID();
END; 