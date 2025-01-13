DROP PROCEDURE IF EXISTS sp_get_service_employees;

CREATE PROCEDURE sp_get_service_employees(
    IN _service_id INT UNSIGNED, 
    IN _date BIGINT
)
BEGIN
    SELECT e.employee_id, e.alias
        FROM employees e 
            JOIN employee_services es 
                ON e.service_id = es.service_id
        WHERE es.service_id = _service_id
            AND e.first_date <= _date 
            AND e.last_date >= _date;
END;
