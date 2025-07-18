DROP PROCEDURE IF EXISTS sp_update_employee_info;

CREATE PROCEDURE sp_update_employee_info(
    IN _session JSON,
    IN _employee_id INT UNSIGNED, 
    IN _alias VARCHAR(50),
    IN _interval_percent SMALLINT,
    IN _last_date BIGINT,
    IN _color_id INT UNSIGNED,
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

    -- remove DELAs
    DELETE FROM DELAs
        WHERE employee_id = _employee_id;

    -- update first alias and last_date
    UPDATE employees
        SET alias = _alias,
            interval_percent = _interval_percent,
            last_date = _last_date,
            color_id = _color_id
        WHERE employee_id = _employee_id;


    -- update employee's services
    DELETE FROM employee_services
        WHERE employee_id = _employee_id;
    CALL sp_set_ESs(_employee_id, _service_ids);

    -- scan conflicts on employee's last date
    CALL sp_scan_ELD_conflicts(_employee_id);

END;
