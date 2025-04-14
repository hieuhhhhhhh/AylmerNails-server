-- ELD = employee's last date
-- this proc find and store all apointments that conflict with the new last_date of an employee

DROP PROCEDURE IF EXISTS sp_scan_ELD_conflicts;

CREATE PROCEDURE sp_scan_ELD_conflicts(
    IN _employee_id INT UNSIGNED
)
BEGIN
    
    DECLARE last_date_ BIGINT;
    DECLARE yesterday_ BIGINT DEFAULT UNIX_TIMESTAMP() - 24*60*60;

    -- fetch last_date
    SELECT last_date
        INTO last_date_
        FROM employees
        WHERE employee_id = _employee_id
        LIMIT 1;

    -- remove old conflicts
    DELETE FROM ELD_conflicts
        WHERE employee_id = _employee_id;

    -- insert new conflicts
    INSERT INTO ELD_conflicts (appo_id, employee_id)
        SELECT appo_id, _employee_id
            FROM appo_details
            WHERE employee_id = _employee_id
                AND date > yesterday_
                AND date > last_date_;
END;
