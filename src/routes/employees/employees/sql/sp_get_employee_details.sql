DROP PROCEDURE IF EXISTS sp_get_employee_details;

CREATE PROCEDURE sp_get_employee_details(
    IN _employee_id INT UNSIGNED
)
BEGIN
    SELECT employee_id, alias, stored_intervals, interval_percent, last_date
        FROM employees
        WHERE employee_id = _employee_id;
END;