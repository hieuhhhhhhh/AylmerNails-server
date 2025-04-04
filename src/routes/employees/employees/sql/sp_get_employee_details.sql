DROP PROCEDURE IF EXISTS sp_get_employee_details;

CREATE PROCEDURE sp_get_employee_details(
    IN _employee_id INT UNSIGNED
)
BEGIN
    -- return employee's information
    SELECT e.employee_id, e.alias, c.color_id, c.name, c.code, e.stored_intervals, e.interval_percent, e.last_date
        FROM employees e
            JOIN colors c 
                ON e.color_id = c.color_id
        WHERE employee_id = _employee_id;

    -- return last date conflict count
    SELECT COUNT(*) 
        FROM ELD_conflicts
        WHERE employee_id = _employee_id;

    -- return schedule conflict count    
    SELECT COUNT(*) 
        FROM schedule_conflicts sc
            JOIN schedules s 
            ON sc.schedule_id = s.schedule_id
        WHERE s.employee_id = _employee_id;
  
END;