DROP PROCEDURE IF EXISTS sp_update_employee_info;

CREATE PROCEDURE sp_update_employee_info(
    IN _session JSON,
    IN _employee_id INT UNSIGNED, 
    IN _alias VARCHAR(50),
    IN _alias_tokens JSON,
    IN _last_date BIGINT,
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

    -- update first alias and last_date
    UPDATE employees
        SET alias = _alias,
            last_date = _last_date
        WHERE employee_id = _employee_id;

    -- update tokens of employee by new alias
    CALL sp_store_alias_tokens(_employee_id, _alias_tokens);

    -- update employee's services
    DELETE FROM employee_services
        WHERE employee_id = _employee_id;
    CALL sp_set_ESs(_employee_id, _service_ids);
END;
