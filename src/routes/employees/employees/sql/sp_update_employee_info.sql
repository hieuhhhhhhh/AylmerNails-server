DROP PROCEDURE IF EXISTS sp_update_employee_info;

CREATE PROCEDURE sp_update_employee_info(
    IN _session JSON,
    IN _employee_id INT UNSIGNED, 
    IN _alias VARCHAR(50),
    IN _stored_intervals JSON,
    IN _service_ids JSON
)
BEGIN
    -- validate token session
    CALL sp_validate_admin(_session);

    -- Check if the employee exists
    IF NOT EXISTS (SELECT 1 FROM employees WHERE employee_id = _employee_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '400, Invalid employee_id, no such employee exists';
    END IF;


END;
