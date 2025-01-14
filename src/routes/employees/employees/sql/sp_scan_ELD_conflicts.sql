-- ELD = employee's last date
-- this proc find and store all apointments that conflict with the new last_date of an employee

DROP PROCEDURE IF EXISTS sp_scan_ELD_conflicts;

CREATE PROCEDURE sp_scan_ELD_conflicts(
    IN _employee_id INT UNSIGNED
)
BEGIN
    DECLARE last_date_ BIGINT;


    -- Fetch last_date of the given employee
    SELECT last_date
        INTO last_date_
        FROM employees
        WHERE employee_id = _employee_id
        LIMIT 1;

    -- Proceed only if last_date is not NULL
    IF last_date_ IS NOT NULL THEN
        -- Remove all existing conflicts for the given employee before revalidating
        DELETE FROM ELD_conflicts
            WHERE employee_id = _employee_id;

        -- Insert appointments with a date greater than the employee's last_date into ELD_conflicts
        INSERT INTO ELD_conflicts (appo_id, employee_id)
            SELECT appo_id, _employee_id
                FROM appo_details
                WHERE  employee_id = _employee_id
                    AND date >= (UNIX_TIMESTAMP() - 24*60*60)
                    AND date > last_date_;
    END IF;

END;
