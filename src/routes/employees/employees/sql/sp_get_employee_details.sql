DROP PROCEDURE IF EXISTS sp_get_employee_details;

CREATE PROCEDURE sp_get_employee_details(
    IN _employee_id INT UNSIGNED
)
BEGIN
    SELECT e.employee_id, e.alias, c.color_id, c.name, c.code, e.stored_intervals, e.interval_percent, e.last_date
        FROM employees e
            JOIN colors c 
                ON e.color_id = c.color_id
        WHERE employee_id = _employee_id;
END;