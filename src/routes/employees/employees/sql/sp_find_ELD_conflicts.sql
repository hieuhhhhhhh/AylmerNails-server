DROP PROCEDURE IF EXISTS sp_find_ELD_conflicts;

CREATE PROCEDURE sp_find_ELD_conflicts(
    IN _employee_id INT UNSIGNED
)
BEGIN
    DECLARE last_date_ BIGINT;

    -- Fetch last_date for the given employee
    SELECT last_date
    INTO last_date_
    FROM employees
    WHERE employee_id = _employee_id;

    IF last_date_ IS NOT NULL THEN
        -- Remove all existing conflicts for the given employee before revalidating
        DELETE FROM ELD_appo_conflicts
        WHERE employee_id = _employee_id;

        -- Insert appointments with a date greater than the employee's last_date into ELD_appo_conflicts
        INSERT INTO ELD_appo_conflicts (appo_id, employee_id)
        SELECT appo_id, _employee_id
        FROM appo_details
        WHERE date > last_date_ 
            AND employee_id = _employee_id;
    END IF;
END;
