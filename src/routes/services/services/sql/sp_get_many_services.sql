DROP PROCEDURE IF EXISTS sp_get_all_services;

CREATE PROCEDURE sp_get_all_services(
    IN _timestamp BIGINT
)
BEGIN
    SELECT s.service_id, s.name, s.last_date, s.category_id, c.name
        FROM services s 
            LEFT JOIN categories c
                ON s.category_id = c.category_id
        WHERE s.last_date IS NULL 
            OR s.last_date >= _timestamp();
END;
