DROP PROCEDURE IF EXISTS sp_get_service_details;

CREATE PROCEDURE sp_get_service_details(
    IN _service_id INT UNSIGNED
)
BEGIN
    -- variables
    DECLARE duration_id_ INT UNSIGNED;

    -- return table: service details
    SELECT s.service_id, s.name, s.description, s.first_date, s.last_date, s.category_id, s.duration, c.name
        FROM services s 
            LEFT JOIN categories c
                ON s.category_id = c.category_id
        WHERE s.service_id = _service_id;

    -- return duration
    SELECT e.employee_id, e.alias, d.duration
        FROM durations d
            JOIN employees e
        WHERE d.service_id = service_id;
END;
