DROP PROCEDURE IF EXISTS sp_get_service_preview;

CREATE PROCEDURE sp_get_service_preview(
    IN _service_id INT UNSIGNED,
    IN _date BIGINT
)
BEGIN
    SELECT s.service_id, s.name, s.description, s.last_date, s.category_id, c.name, s.duration
        FROM services s 
            LEFT JOIN categories c
                ON s.category_id = c.category_id
        WHERE s.service_id = _service_id;
END;