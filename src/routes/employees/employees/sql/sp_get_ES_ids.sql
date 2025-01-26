DROP PROCEDURE IF EXISTS sp_get_ES_ids;

CREATE PROCEDURE sp_get_ES_ids(
    IN _employee_id INT UNSIGNED,
    IN _date BIGINT
)
BEGIN
    SELECT s.service_id
        FROM services s
            JOIN employee_services es 
                ON s.service_id = es.service_id
        WHERE es.employee_id = _employee_id
            AND (s.last_date IS NULL OR s.last_date >= _date);
END;

