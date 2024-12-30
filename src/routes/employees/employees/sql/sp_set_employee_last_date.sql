DROP PROCEDURE IF EXISTS sp_set_employee_last_date;

CREATE PROCEDURE sp_set_employee_last_date(
    IN  _employee_id INT UNSIGNED, 
    IN  _last_date BIGINT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM employees WHERE employee_id = _employee_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid employee_id, no such employee exists';
    END IF;

    -- Update the last_date for the given employee_id
    UPDATE employees
    SET last_date =  _last_date
    WHERE employee_id =  _employee_id;
END;

