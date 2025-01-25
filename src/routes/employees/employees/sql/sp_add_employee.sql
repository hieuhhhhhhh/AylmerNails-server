DROP PROCEDURE IF EXISTS sp_add_employee;

CREATE PROCEDURE sp_add_employee(
    IN _session JSON,
    IN _alias VARCHAR(50),
    IN _first_date BIGINT,
    IN _stored_intervals JSON,
    IN _service_ids JSON
)
sp:BEGIN 
    -- validate session token
    CALL sp_validate_admin(_session);

    -- create new employee
    INSERT INTO employees (alias, stored_intervals, first_date)
        VALUES (_alias, _stored_intervals, _first_date);
    
    -- set service list for the new employee
    CALL sp_set_employee_services(LAST_INSERT_ID() ,_service_ids);

    -- return id of new employee
    SELECT LAST_INSERT_ID();
END; 