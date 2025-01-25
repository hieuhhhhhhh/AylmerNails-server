DROP PROCEDURE IF EXISTS sp_get_SEs;

CREATE PROCEDURE sp_get_SEs(
    IN _service_id INT UNSIGNED,
    IN _date BIGINT
)
BEGIN
    SELECT e.employee_id, e.alias, e.last_date, es.service_id
        FROM employees e 
            LEFT JOIN employee_services es 
                ON e.employee_id = es.employee_id
                    AND es.service_id = _service_id
        WHERE last_date IS NULL 
            OR last_date >= _date;
END;

