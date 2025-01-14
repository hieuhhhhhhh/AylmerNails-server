-- ELD = employee's last date

DROP PROCEDURE IF EXISTS sp_set_ELD;

CREATE PROCEDURE sp_set_ELD(
    IN _session JSON,
    IN _employee_id INT UNSIGNED, 
    IN _last_date BIGINT
)
BEGIN
    -- placeholders
    DECLARE user_id_ INT UNSIGNED;
    DECLARE role_ VARCHAR(20);
    
    -- fetch and validate user's role from session data
    CALL sp_get_user_id_role(_session, user_id_, role_);

    -- IF role is not valid, leave procedure
    IF role_ IS NULL
        OR role_ NOT IN ('admin', 'developer')
    THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '401, Unauthorized';
    END IF;

    -- Check if the employee exists
    IF NOT EXISTS (SELECT 1 FROM employees WHERE employee_id = _employee_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid employee_id, no such employee exists';
    END IF;

    -- Update the last_date for the given employee_id
    UPDATE employees
        SET last_date = _last_date
        WHERE employee_id = _employee_id;

    -- Call sp_scan_ELD_conflicts to find any appointments that conflict the update
    CALL sp_scan_ELD_conflicts(_employee_id);
END;
