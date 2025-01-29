DROP PROCEDURE IF EXISTS sp_get_service_preview;

CREATE PROCEDURE sp_get_service_preview(
    IN _service_id INT UNSIGNED,
    IN _date BIGINT
)
BEGIN
    SELECT s.service_id, s.name, s.description, s.last_date, s.category_id, c.name, sl.length
        FROM services s 
            LEFT JOIN categories c
                ON s.category_id = c.category_id
            JOIN service_lengths sl
                ON s.service_id = sl.service_id
        WHERE s.service_id = _service_id 
            AND sl.effective_from <= _date  
        ORDER BY sl.effective_from DESC
        LIMIT 1;
END;